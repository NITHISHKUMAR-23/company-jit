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
#include <fstream>
#include <signal.h>
#include <thread>

#include <opencv2/opencv.hpp>
#include <opencv2/face.hpp>

struct Buffer {
    void* start;
    size_t length;
};

volatile sig_atomic_t stopRequested = 0;
void handleSig(int) { stopRequested = 1; }

void xioctl(int fd, int request, void* arg) {
    int r;
    do { r = ioctl(fd, request, arg); } 
    while (r == -1 && (errno == EINTR || errno == EAGAIN));
    if (r == -1) { perror("ioctl"); exit(EXIT_FAILURE); }
}

// Convert Bayer to RGB and improve image quality
void unpackBayer8ToRGB(const void* src, void* dst, int width, int height) {
    cv::Mat raw8(height, width, CV_8UC1, const_cast<void*>(src));
    cv::Mat rgb;
    cv::cvtColor(raw8, rgb, cv::COLOR_BayerRG2RGB);

    // --- Manual color balance ---
    std::vector<cv::Mat> channels(3);
    cv::split(rgb, channels);
    double redGain = 1.4, greenGain = 1.0, blueGain = 1.7;
    channels[0] *= blueGain;
    channels[1] *= greenGain;
    channels[2] *= redGain;
    cv::merge(channels, rgb);

    // --- Contrast and gamma correction ---
    cv::Mat balanced;
    cv::convertScaleAbs(rgb, balanced, 1.2, 5); // contrast boost
    cv::Mat gamma;
    balanced.convertTo(gamma, CV_32F, 1.0 / 255.0);
    cv::pow(gamma, 1.2, gamma);
    gamma.convertTo(rgb, CV_8UC3, 255.0);

    memcpy(dst, rgb.data, width * height * 3);
}

// EAR calculation
double eyeAspectRatio(const std::vector<cv::Point2f>& eye) {
    double A = cv::norm(eye[1] - eye[5]);
    double B = cv::norm(eye[2] - eye[4]);
    double C = cv::norm(eye[0] - eye[3]);
    if (C < 1e-6) return 0.0;
    return (A + B) / (2.0 * C);
}

// MAR calculation
double mouthAspectRatio(const std::vector<cv::Point2f>& lm) {
    double A = cv::norm(lm[61] - lm[67]);
    double B = cv::norm(lm[62] - lm[66]);
    double C = cv::norm(lm[63] - lm[65]);
    double width = cv::norm(lm[60] - lm[64]);
    if (width < 1e-6) return 0.0;
    return (A + B + C) / (3.0 * width);
}

// Head pose estimate
cv::Vec3d estimateHeadPose(const std::vector<cv::Point2d>& landmarks, const cv::Size& imageSize) {
    std::vector<cv::Point3d> modelPoints = {
        {0.0, 0.0, 0.0}, {-30.0, -30.0, -30.0}, {30.0, -30.0, -30.0},
        {-30.0, 30.0, -30.0}, {30.0, 30.0, -30.0}, {0.0, 60.0, -30.0}
    };
    std::vector<cv::Point2d> imagePoints = {
        landmarks[30], landmarks[36], landmarks[45],
        landmarks[48], landmarks[54], landmarks[8]
    };
    double focalLength = imageSize.width;
    cv::Point2d center(imageSize.width/2.0, imageSize.height/2.0);
    cv::Mat cameraMatrix = (cv::Mat_<double>(3,3) << focalLength,0,center.x,0,focalLength,center.y,0,0,1);
    cv::Mat distCoeffs = cv::Mat::zeros(4,1,CV_64F);
    cv::Mat rvec, tvec;
    if(!cv::solvePnP(modelPoints,imagePoints,cameraMatrix,distCoeffs,rvec,tvec,false,cv::SOLVEPNP_ITERATIVE)) return {0,0,0};
    cv::Mat R; cv::Rodrigues(rvec,R);
    cv::Mat pose = cv::Mat::zeros(3,4,CV_64F); R.copyTo(pose.colRange(0,3)); tvec.copyTo(pose.col(3));
    cv::Mat cameraMatrixOut, rotMatrix, transVect, rotMatrixX, rotMatrixY, rotMatrixZ, eulerAngles;
    cv::decomposeProjectionMatrix(pose,cameraMatrixOut,rotMatrix,transVect,rotMatrixX,rotMatrixY,rotMatrixZ,eulerAngles);
    return cv::Vec3d(eulerAngles.at<double>(0),eulerAngles.at<double>(1),eulerAngles.at<double>(2));
}

bool fileExists(const std::string& path) { std::ifstream f(path); return f.good(); }

int main() {
    signal(SIGINT, handleSig);
    signal(SIGTERM, handleSig);

    const char* devName = "/dev/video0";
    const int width = 1920, height = 1080;

    int fd = open(devName, O_RDWR | O_NONBLOCK);
    if(fd < 0) { perror("Cannot open device"); return 1; }

    // Set format
    v4l2_format fmt{};
    fmt.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    fmt.fmt.pix.width = width;
    fmt.fmt.pix.height = height;
    fmt.fmt.pix.pixelformat = V4L2_PIX_FMT_SRGGB8;
    fmt.fmt.pix.field = V4L2_FIELD_NONE;
    xioctl(fd, VIDIOC_S_FMT, &fmt);

    // Request buffers
    v4l2_requestbuffers req{};
    req.count = 4;
    req.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    req.memory = V4L2_MEMORY_MMAP;
    xioctl(fd, VIDIOC_REQBUFS, &req);
    if(req.count < 2) { std::cerr << "Insufficient buffers\n"; close(fd); return 1; }

    std::vector<Buffer> buffers(req.count);
    for(unsigned i=0;i<(unsigned)req.count;i++) {
        v4l2_buffer buf{}; buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE; buf.memory = V4L2_MEMORY_MMAP; buf.index=i;
        xioctl(fd, VIDIOC_QUERYBUF, &buf);
        buffers[i].length = buf.length;
        buffers[i].start = mmap(NULL, buf.length, PROT_READ|PROT_WRITE, MAP_SHARED, fd, buf.m.offset);
        if(buffers[i].start==MAP_FAILED) { perror("mmap"); close(fd); return 1; }
    }

    for(unsigned i=0;i<(unsigned)req.count;i++) {
        v4l2_buffer buf{}; buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE; buf.memory = V4L2_MEMORY_MMAP; buf.index=i;
        xioctl(fd, VIDIOC_QBUF, &buf);
    }

    v4l2_buf_type type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    xioctl(fd, VIDIOC_STREAMON, &type);

    // Load models
    const std::string facemarkModelPath = "lbfmodel.yaml";
    const std::string faceCascadePath = "haarcascade_frontalface_default.xml";

    if(!fileExists(facemarkModelPath) || !fileExists(faceCascadePath)) {
        std::cerr << "Required models missing.\n"; xioctl(fd, VIDIOC_STREAMOFF, &type); close(fd); return -1;
    }

    cv::Ptr<cv::face::Facemark> facemark = cv::face::FacemarkLBF::create();
    facemark->loadModel(facemarkModelPath);

    cv::CascadeClassifier face_cascade;
    face_cascade.load(faceCascadePath);

    cv::Mat frame(height,width,CV_8UC3), gray(height,width,CV_8UC1);
    cv::namedWindow("Drowsiness Detection", cv::WINDOW_NORMAL);
    cv::resizeWindow("Drowsiness Detection",1280,720);

    // thresholds
    const double DEFAULT_EAR_THRESH=0.25, DEFAULT_MAR_THRESH=0.60, DEFAULT_YAW_THRESH=25.0, DEFAULT_PITCH_THRESH=20.0, EYE_CLOSED_TIME_THRESH=1.0;
    const size_t SMOOTHING_WINDOW = 5;
    std::deque<double> earHistory, marHistory, yawHistory;
    bool eyeClosed=false; auto eyeClosedStart=std::chrono::steady_clock::now(); int blinkCount=0;

    // calibration
    const int CALIB_FRAMES=30; int calibCounter=0; double calibEarSum=0.0; bool calibrated=false; double earThreshold=DEFAULT_EAR_THRESH; double marThreshold=DEFAULT_MAR_THRESH;

    auto lastTime = std::chrono::steady_clock::now(); int frameCounter=0; double fps=0.0;

    while(!stopRequested) {
        fd_set fds; FD_ZERO(&fds); FD_SET(fd,&fds);
        timeval tv={0,5000}; // 5ms
        int r=select(fd+1,&fds,NULL,NULL,&tv);
        if(r<0){ if(errno==EINTR) continue; perror("select"); break;}
        if(r==0) continue;

        v4l2_buffer buf{}; buf.type=V4L2_BUF_TYPE_VIDEO_CAPTURE; buf.memory=V4L2_MEMORY_MMAP;
        xioctl(fd, VIDIOC_DQBUF, &buf);

        unpackBayer8ToRGB(buffers[buf.index].start, frame.data, width, height);
        cv::cvtColor(frame, gray, cv::COLOR_BGR2GRAY);

        std::vector<cv::Rect> faces;
        face_cascade.detectMultiScale(gray,faces,1.1,3,0,cv::Size(80,80));

        std::string status = "Driver: OK";

        if(!faces.empty()){
            std::vector<std::vector<cv::Point2f>> landmarks;
            bool ok=false;
            try { ok=facemark->fit(frame,faces,landmarks); } catch(...) { ok=false; }

            if(ok && !landmarks.empty()){
                size_t chosenIdx=0; int maxArea=0;
                for(size_t i=0;i<faces.size();i++){ int a=faces[i].width*faces[i].height; if(a>maxArea){ maxArea=a; chosenIdx=i;}}
                auto &lm = landmarks[chosenIdx];

                std::vector<cv::Point2f> leftEye={lm[36],lm[37],lm[38],lm[39],lm[40],lm[41]};
                std::vector<cv::Point2f> rightEye={lm[42],lm[43],lm[44],lm[45],lm[46],lm[47]};
                double ear=(eyeAspectRatio(leftEye)+eyeAspectRatio(rightEye))/2.0;
                double mar = mouthAspectRatio(lm);
                std::vector<cv::Point2d> lm2d(lm.begin(), lm.end());
                cv::Vec3d euler = estimateHeadPose(lm2d, frame.size());
                double pitch=euler[0], yaw=euler[1], roll=euler[2];

                earHistory.push_back(ear); if(earHistory.size()>SMOOTHING_WINDOW) earHistory.pop_front();
                marHistory.push_back(mar); if(marHistory.size()>SMOOTHING_WINDOW) marHistory.pop_front();
                yawHistory.push_back(yaw); if(yawHistory.size()>SMOOTHING_WINDOW) yawHistory.pop_front();
                auto meanDeque=[](const std::deque<double>& d){ if(d.empty()) return 0.0; double s=0; for(double v:d) s+=v; return s/d.size();};
                double earSmooth=meanDeque(earHistory), marSmooth=meanDeque(marHistory), yawSmooth=meanDeque(yawHistory);

                if(!calibrated){ calibEarSum+=earSmooth; calibCounter++; if(calibCounter>=CALIB_FRAMES){double meanOpenEar=calibEarSum/calibCounter; earThreshold=std::max(0.12,meanOpenEar*0.50); calibrated=true; std::cout<<"Calibration done. meanOpenEar="<<meanOpenEar<<" EAR_THRESH="<<earThreshold<<std::endl;} else status="Calibrating..."; }

                double usedEarThresh = calibrated ? earThreshold : DEFAULT_EAR_THRESH;
                double usedMarThresh = marThreshold;

                if(earSmooth<usedEarThresh){ 
                    if(!eyeClosed){ eyeClosedStart=std::chrono::steady_clock::now(); eyeClosed=true; }
                    else { auto duration=std::chrono::duration_cast<std::chrono::duration<double>>(std::chrono::steady_clock::now()-eyeClosedStart).count(); if(duration>=EYE_CLOSED_TIME_THRESH) status="DROWSINESS ALERT"; else status="Eyes Closed"; }
                } else { if(eyeClosed){ blinkCount++; eyeClosed=false; } }

                if(marSmooth>usedMarThresh) status="Yawning";
                else if(yawSmooth>DEFAULT_YAW_THRESH) status="Looking Left";
                else if(yawSmooth<-DEFAULT_YAW_THRESH) status="Looking Right";
                else if(pitch>DEFAULT_PITCH_THRESH) status="Looking Down";

                cv::rectangle(frame,faces[chosenIdx],cv::Scalar(0,255,0),2);
                for(const auto &p:lm) cv::circle(frame,p,2,cv::Scalar(255,0,0),-1);
                char info[256]; snprintf(info,sizeof(info),"EAR: %.3f (%.3f) MAR: %.3f Yaw: %.1f Blinks: %d",ear,earSmooth,marSmooth,yawSmooth,blinkCount);
                cv::putText(frame,info,cv::Point(10,55),cv::FONT_HERSHEY_SIMPLEX,0.6,cv::Scalar(255,255,255),2);
            } else status="Landmarks Not Detected";
        } else status="No Face Detected";

        frameCounter++; auto now=std::chrono::steady_clock::now(); double elapsed=std::chrono::duration_cast<std::chrono::duration<double>>(now-lastTime).count();
        if(elapsed>=1.0){ fps=frameCounter/elapsed; frameCounter=0; lastTime=now; }

        cv::putText(frame,status,cv::Point(10,30),cv::FONT_HERSHEY_SIMPLEX,0.9,cv::Scalar(0,0,255),2);
        char fpsbuf[64]; snprintf(fpsbuf,sizeof(fpsbuf),"FPS: %.1f",fps);
        cv::putText(frame,fpsbuf,cv::Point(10,frame.rows-20),cv::FONT_HERSHEY_SIMPLEX,0.7,cv::Scalar(0,255,255),2);

        cv::imshow("Drowsiness Detection",frame);
        xioctl(fd, VIDIOC_QBUF, &buf);
        int key=cv::waitKey(1); if(key==27) break;
    }

    xioctl(fd, VIDIOC_STREAMOFF, &type);
    for(auto &b:buffers) munmap(b.start,b.length);
    close(fd); cv::destroyAllWindows();
    return 0;
}

