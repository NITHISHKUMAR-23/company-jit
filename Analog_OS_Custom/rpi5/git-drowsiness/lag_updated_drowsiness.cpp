#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <linux/videodev2.h>
#include <cerrno>
#include <cstdlib>
#include <cstdio>
#include <cstring>
#include <iostream>
#include <vector>
#include <chrono>
#include <deque>
#include <signal.h>

#include <opencv2/opencv.hpp>
#include <opencv2/face.hpp>
#include <opencv2/dnn.hpp>

struct Buffer { void* start; size_t length; };

volatile sig_atomic_t stopRequested = 0;
void handleSig(int) { stopRequested = 1; }

void xioctl(int fd, int request, void* arg) {
    int r;
    do { r = ioctl(fd, request, arg); }
    while (r == -1 && (errno == EINTR || errno == EAGAIN));
    if (r == -1) { perror("ioctl"); exit(EXIT_FAILURE); }
}

void unpackBayer8ToRGB(const void* src, void* dst, int width, int height) {
    static cv::Mat raw8(height, width, CV_8UC1);
    static cv::Mat rgb(height, width, CV_8UC3);
    raw8.data = const_cast<uchar*>(reinterpret_cast<const uchar*>(src));

    cv::cvtColor(raw8, rgb, cv::COLOR_BayerRG2RGB);

    cv::Mat channels[3];
    cv::split(rgb, channels);
    channels[0] *= 1.8;
    channels[2] *= 1.5;
    cv::merge(channels, 3, rgb);

    cv::convertScaleAbs(rgb, rgb, 1.25, 5);
    memcpy(dst, rgb.data, width * height * 3);
}

double eyeAspectRatio(const std::vector<cv::Point2f>& eye) {
    double A = cv::norm(eye[1] - eye[5]);
    double B = cv::norm(eye[2] - eye[4]);
    double C = cv::norm(eye[0] - eye[3]);
    return (C < 1e-6) ? 0.0 : (A + B) / (2.0 * C);
}

double mouthAspectRatio(const std::vector<cv::Point2f>& lm) {
    double A = cv::norm(lm[61] - lm[67]);
    double B = cv::norm(lm[62] - lm[66]);
    double C = cv::norm(lm[63] - lm[65]);
    double width = cv::norm(lm[60] - lm[64]);
    return (width < 1e-6) ? 0.0 : (A + B + C) / (3.0 * width);
}

cv::Vec3d estimateHeadPose(const std::vector<cv::Point2d>& landmarks, const cv::Size& imageSize) {
    static std::vector<cv::Point3d> modelPoints = {
        {0.0,0.0,0.0},{-30.0,-30.0,-30.0},{30.0,-30.0,-30.0},
        {-30.0,30.0,-30.0},{30.0,30.0,-30.0},{0.0,60.0,-30.0}
    };

    std::vector<cv::Point2d> imagePoints = {
        landmarks[30], landmarks[36], landmarks[45],
        landmarks[48], landmarks[54], landmarks[8]
    };

    double focalLength = imageSize.width;
    cv::Point2d center(imageSize.width/2, imageSize.height/2);

    cv::Mat cameraMatrix = (cv::Mat_<double>(3,3)
        << focalLength,0,center.x,0,focalLength,center.y,0,0,1);

    cv::Mat dist = cv::Mat::zeros(4,1,CV_64F);
    cv::Mat rvec, tvec;

    cv::solvePnP(modelPoints, imagePoints, cameraMatrix, dist, rvec, tvec);

    cv::Mat R;
    cv::Rodrigues(rvec, R);
    cv::Mat pose = cv::Mat::zeros(3,4,CV_64F);
    R.copyTo(pose.colRange(0,3));
    tvec.copyTo(pose.col(3));

    cv::Mat K, Rmat, T, RX, RY, RZ, euler;
    cv::decomposeProjectionMatrix(pose, K, Rmat, T, RX, RY, RZ, euler);

    return cv::Vec3d(
        euler.at<double>(0),
        euler.at<double>(1),
        euler.at<double>(2)
    );
}

int main() {
    signal(SIGINT, handleSig);
    signal(SIGTERM, handleSig);

    const char* devName = "/dev/video0";
    const int width = 1920, height = 1080;
    const int DET_W = 640, DET_H = 360;

    int fd = open(devName, O_RDWR | O_NONBLOCK);
    if(fd < 0) { perror("Cannot open device"); return 1; }

    v4l2_format fmt{};
    fmt.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    fmt.fmt.pix.width = width;
    fmt.fmt.pix.height = height;
    fmt.fmt.pix.pixelformat = V4L2_PIX_FMT_SRGGB8;
    xioctl(fd, VIDIOC_S_FMT, &fmt);

    v4l2_requestbuffers req{};
    req.count = 4;
    req.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    req.memory = V4L2_MEMORY_MMAP;
    xioctl(fd, VIDIOC_REQBUFS, &req);

    std::vector<Buffer> buffers(req.count);
    for(unsigned i=0;i<req.count;i++){
        v4l2_buffer b{};
        b.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
        b.memory = V4L2_MEMORY_MMAP;
        b.index = i;

        xioctl(fd, VIDIOC_QUERYBUF, &b);
        buffers[i].length = b.length;
        buffers[i].start = mmap(NULL, b.length, PROT_READ|PROT_WRITE, MAP_SHARED, fd, b.m.offset);
    }

    for(unsigned i=0;i<req.count;i++){
        v4l2_buffer b{};
        b.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
        b.memory = V4L2_MEMORY_MMAP;
        b.index = i;
        xioctl(fd, VIDIOC_QBUF, &b);
    }

    v4l2_buf_type type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    xioctl(fd, VIDIOC_STREAMON, &type);

    cv::Ptr<cv::face::Facemark> facemark = cv::face::FacemarkLBF::create();
    facemark->loadModel("lbfmodel.yaml");

    cv::Ptr<cv::FaceDetectorYN> detector =
        cv::FaceDetectorYN::create("face_detection_yunet_2023mar.onnx","",
                                   cv::Size(DET_W,DET_H),0.7f,0.3f,5000);

    detector->setInputSize(cv::Size(DET_W,DET_H));

    cv::Mat frame(height, width, CV_8UC3);
    cv::Mat grayFull(height,width,CV_8UC1);
    cv::Mat small(DET_H,DET_W,CV_8UC3);

    cv::namedWindow("Drowsiness Detection", cv::WINDOW_NORMAL);

    double earThreshold = 0.0;
    bool earInitialized = false;

    // Smooth head pose yaw
    std::deque<double> yawHistory;
    const int YAW_WINDOW = 10;

    bool eyesClosed = false;
    auto eyesClosedStart = std::chrono::steady_clock::now();

    const double MAR_YAWN = 0.55;
    const double YAW_LIMIT = 15.0;

    while(!stopRequested) {

        fd_set fds;
        FD_ZERO(&fds);
        FD_SET(fd,&fds);
        timeval tv = {0,10000};
        int r = select(fd+1,&fds,NULL,NULL,&tv);
        if(r <= 0) continue;

        v4l2_buffer b{};
        b.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
        b.memory = V4L2_MEMORY_MMAP;
        if(ioctl(fd, VIDIOC_DQBUF, &b) < 0) continue;

        unpackBayer8ToRGB(buffers[b.index].start, frame.data, width, height);

        cv::cvtColor(frame, grayFull, cv::COLOR_BGR2GRAY);
        cv::resize(frame, small, cv::Size(DET_W,DET_H));

        cv::Mat faces;
        detector->detect(small, faces);

        std::string status = "Driver OK";
        bool alert = false;

        if(faces.rows > 0) {

            int x = faces.at<float>(0,0) * width / DET_W;
            int y = faces.at<float>(0,1) * height / DET_H;
            int w = faces.at<float>(0,2) * width / DET_W;
            int h = faces.at<float>(0,3) * height / DET_H;

            cv::Rect faceRect(x,y,w,h);

            if(w>20 && h>20 &&
               x>=0 && y>=0 &&
               x+w<=width && y+h<=height)
            {
                cv::Mat faceGray = grayFull(faceRect);

                std::vector<std::vector<cv::Point2f>> landmarks;
                std::vector<cv::Rect> tempRect = { cv::Rect(0,0,faceRect.width,faceRect.height) };

                bool ok = facemark->fit(faceGray, tempRect, landmarks);

                if(ok && !landmarks.empty()) {

                    auto &lm = landmarks[0];
                    for(auto &p : lm){
                        p.x += faceRect.x;
                        p.y += faceRect.y;
                    }

                    std::vector<cv::Point2f> leftEye{
                        lm[36],lm[37],lm[38],lm[39],lm[40],lm[41]
                    };
                    std::vector<cv::Point2f> rightEye{
                        lm[42],lm[43],lm[44],lm[45],lm[46],lm[47]
                    };

                    double ear = (eyeAspectRatio(leftEye) +
                                  eyeAspectRatio(rightEye)) / 2.0;

                    double mar = mouthAspectRatio(lm);

                    std::vector<cv::Point2d> lm2d(lm.begin(), lm.end());
                    double yaw = estimateHeadPose(lm2d, frame.size())[1];

                    // --- EAR instant threshold ---
                    if(!earInitialized){
                        earThreshold = ear * 0.35;
                        earInitialized = true;
                    }

                    // Smooth threshold adaptively
                    earThreshold = 0.9 * earThreshold + 0.1 * (ear * 0.35);

                    // Eye closure detection
                    if(ear < earThreshold){
                        if(!eyesClosed){
                            eyesClosed = true;
                            eyesClosedStart = std::chrono::steady_clock::now();
                        } else {
                            double sec = std::chrono::duration<double>(
                                std::chrono::steady_clock::now() - eyesClosedStart
                            ).count();
                            if(sec >= 1.5){
                                status = "DROWSINESS DETECTED";
                                alert = true;
                            }
                        }
                    } else {
                        eyesClosed = false;
                    }

                    // Yawn
                    if(mar > MAR_YAWN){
                        status = "YAWNING";
                        alert = true;
                    }

                    // Smooth yaw for head turning
                    yawHistory.push_back(yaw);
                    if(yawHistory.size() > YAW_WINDOW)
                        yawHistory.pop_back();

                    double yawAvg = 0;
                    for(double v : yawHistory) yawAvg += v;
                    yawAvg /= yawHistory.size();

                    if(yawAvg > YAW_LIMIT){
                        status = "TURNING RIGHT";
                        alert = true;
                    }
                    else if(yawAvg < -YAW_LIMIT){
                        status = "TURNING LEFT";
                        alert = true;
                    }

                    cv::rectangle(frame, faceRect,
                                  alert ? cv::Scalar(0,0,255)
                                        : cv::Scalar(0,255,0),
                                  3);
                }
                else status = "Landmarks Not Found";
            }
        }
        else status = "No Face Detected";

        cv::putText(frame, status, {10,40},
                    cv::FONT_HERSHEY_SIMPLEX, 1.0,
                    cv::Scalar(0,0,255), 2);

        cv::imshow("Drowsiness Detection", frame);

        xioctl(fd, VIDIOC_QBUF, &b);

        if(cv::waitKey(1) == 27) break;
    }

    xioctl(fd, VIDIOC_STREAMOFF, &type);
    for(auto &b : buffers) munmap(b.start, b.length);
    close(fd);
    cv::destroyAllWindows();

    return 0;
}

