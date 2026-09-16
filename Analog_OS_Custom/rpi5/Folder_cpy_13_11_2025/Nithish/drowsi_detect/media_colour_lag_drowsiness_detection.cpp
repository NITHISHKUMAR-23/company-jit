#include <opencv2/opencv.hpp>
#include <opencv2/core.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/highgui.hpp>

#include <mediapipe/framework/formats/landmark.pb.h>
#include <mediapipe/framework/formats/landmark.pb.cc>
#include <mediapipe/framework/calculator_graph.h>
#include <mediapipe/framework/port/status.h>
#include <mediapipe/framework/port/parse_text_proto.h>
#include <mediapipe/framework/formats/image_frame_opencv.h>

#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <linux/videodev2.h>

#include <deque>
#include <chrono>
#include <iostream>
#include <vector>
#include <algorithm>
#include <signal.h>

volatile sig_atomic_t stopRequested = 0;
void handleSig(int) { stopRequested = 1; }

// -------------------- V4L2 Utilities --------------------
void xioctl(int fd, int request, void* arg) {
    int r;
    do { r = ioctl(fd, request, arg); }
    while (r == -1 && (errno == EINTR || errno == EAGAIN));
    if (r == -1) { perror("ioctl"); exit(EXIT_FAILURE); }
}

struct Buffer { void* start; size_t length; };

// Convert Bayer to RGB with enhanced color/gamma
void unpackBayer8ToRGB(const void* src, void* dst, int width, int height) {
    cv::Mat raw8(height, width, CV_8UC1, const_cast<void*>(src));
    cv::Mat rgb;
    cv::cvtColor(raw8, rgb, cv::COLOR_BayerRG2RGB);

    std::vector<cv::Mat> channels(3);
    cv::split(rgb, channels);
    channels[0] *= 1.8; // B
    channels[1] *= 1.0; // G
    channels[2] *= 1.5; // R
    cv::merge(channels, rgb);

    cv::Mat balanced;
    cv::convertScaleAbs(rgb, balanced, 1.25, 5);
    cv::Mat gamma;
    balanced.convertTo(gamma, CV_32F, 1.0/255.0);
    cv::pow(gamma, 1.1, gamma);
    cv::normalize(gamma, gamma, 0, 1, cv::NORM_MINMAX);
    gamma.convertTo(rgb, CV_8UC3, 255.0);

    memcpy(dst, rgb.data, width * height * 3);
}

// -------------------- Geometric Heuristics --------------------
double eyeAspectRatio(const std::vector<cv::Point2f>& eye) {
    double A = cv::norm(eye[1] - eye[5]);
    double B = cv::norm(eye[2] - eye[4]);
    double C = cv::norm(eye[0] - eye[3]);
    if(C < 1e-6) return 0.0;
    return (A + B) / (2.0 * C);
}

double mouthAspectRatio(const std::vector<cv::Point2f>& lm) {
    double A = cv::norm(lm[61] - lm[67]);
    double B = cv::norm(lm[62] - lm[66]);
    double C = cv::norm(lm[63] - lm[65]);
    double width = cv::norm(lm[60] - lm[64]);
    if(width < 1e-6) return 0.0;
    return (A + B + C)/(3.0*width);
}

cv::Vec3d estimateHeadPose(const std::vector<cv::Point2d>& landmarks, const cv::Size& imageSize) {
    std::vector<cv::Point3d> modelPoints = {
        {0.0, 0.0, 0.0}, {-30.0, -30.0, -30.0}, {30.0, -30.0, -30.0},
        {-30.0, 30.0, -30.0}, {30.0, 30.0, -30.0}, {0.0, 60.0, -30.0}
    };
    std::vector<cv::Point2d> imagePoints = {
        landmarks[1], landmarks[33], landmarks[263],
        landmarks[61], landmarks[291], landmarks[199]
    };
    double focalLength = imageSize.width;
    cv::Point2d center(imageSize.width/2.0, imageSize.height/2.0);
    cv::Mat cameraMatrix = (cv::Mat_<double>(3,3) << focalLength,0,center.x,0,focalLength,center.y,0,0,1);
    cv::Mat distCoeffs = cv::Mat::zeros(4,1,CV_64F);
    cv::Mat rvec, tvec;
    if(!cv::solvePnP(modelPoints, imagePoints, cameraMatrix, distCoeffs, rvec, tvec)) return {0,0,0};
    cv::Mat R; cv::Rodrigues(rvec,R);
    cv::Mat pose = cv::Mat::zeros(3,4,CV_64F); R.copyTo(pose.colRange(0,3)); tvec.copyTo(pose.col(3));
    cv::Mat cameraMatrixOut, rotMatrix, transVect, rotMatrixX, rotMatrixY, rotMatrixZ, eulerAngles;
    cv::decomposeProjectionMatrix(pose, cameraMatrixOut, rotMatrix, transVect, rotMatrixX, rotMatrixY, rotMatrixZ, eulerAngles);
    return cv::Vec3d(
        std::clamp(eulerAngles.at<double>(0),-45.0,45.0),
        std::clamp(eulerAngles.at<double>(1),-45.0,45.0),
        std::clamp(eulerAngles.at<double>(2),-45.0,45.0)
    );
}

// -------------------- Helper Functions --------------------
double smooth(double prev, double current, double alpha=0.3){ return prev*(1-alpha)+current*alpha; }
double median(std::deque<double>& v){ std::vector<double> tmp(v.begin(), v.end()); std::sort(tmp.begin(), tmp.end()); return tmp[tmp.size()/2]; }

// -------------------- Main --------------------
int main() {
    signal(SIGINT, handleSig);
    signal(SIGTERM, handleSig);

    const char* devName = "/dev/video0";
    const int width = 1920, height = 1080;

    // --- V4L2 Init ---
    int fd = open(devName, O_RDWR | O_NONBLOCK);
    if(fd<0){ perror("Cannot open device"); return 1; }
    v4l2_format fmt{}; fmt.type=V4L2_BUF_TYPE_VIDEO_CAPTURE; fmt.fmt.pix.width=width; fmt.fmt.pix.height=height; fmt.fmt.pix.pixelformat=V4L2_PIX_FMT_SRGGB8; fmt.fmt.pix.field=V4L2_FIELD_NONE;
    xioctl(fd, VIDIOC_S_FMT, &fmt);
    v4l2_requestbuffers req{}; req.count=4; req.type=V4L2_BUF_TYPE_VIDEO_CAPTURE; req.memory=V4L2_MEMORY_MMAP; xioctl(fd, VIDIOC_REQBUFS, &req);
    std::vector<Buffer> buffers(req.count);
    for(unsigned i=0;i<req.count;i++){ v4l2_buffer buf{}; buf.type=V4L2_BUF_TYPE_VIDEO_CAPTURE; buf.memory=V4L2_MEMORY_MMAP; buf.index=i; xioctl(fd, VIDIOC_QUERYBUF, &buf); buffers[i].length=buf.length; buffers[i].start=mmap(NULL, buf.length, PROT_READ|PROT_WRITE, MAP_SHARED, fd, buf.m.offset); }
    for(unsigned i=0;i<req.count;i++){ v4l2_buffer buf{}; buf.type=V4L2_BUF_TYPE_VIDEO_CAPTURE; buf.memory=V4L2_MEMORY_MMAP; buf.index=i; xioctl(fd, VIDIOC_QBUF, &buf); }
    v4l2_buf_type type = V4L2_BUF_TYPE_VIDEO_CAPTURE; xioctl(fd, VIDIOC_STREAMON, &type);

    cv::Mat frame(height,width,CV_8UC3), gray(height,width,CV_8UC1);

    // --- Temporal smoothing ---
    const size_t SMOOTHING_WINDOW=5;
    std::deque<double> earHistory, marHistory, yawHistory;
    double earSmooth=0.0, marSmooth=0.0, yawSmooth=0.0;
    bool eyeClosed=false; auto eyeClosedStart=std::chrono::steady_clock::now();
    int blinkCount=0;

    // --- Thresholds ---
    const double DEFAULT_EAR_THRESH=0.25, DEFAULT_MAR_THRESH=0.60, DEFAULT_YAW_THRESH=25.0, DEFAULT_PITCH_THRESH=20.0, EYE_CLOSED_TIME_THRESH=1.0;
    const int CALIB_FRAMES=30; int calibCounter=0; double calibEarSum=0.0; bool calibrated=false; double earThreshold=DEFAULT_EAR_THRESH, marThreshold=DEFAULT_MAR_THRESH;

    // --- FPS calc ---
    auto lastTime=std::chrono::steady_clock::now(); int frameCounter=0; double fps=0.0;

    cv::namedWindow("Drowsiness Detection",cv::WINDOW_NORMAL);
    cv::resizeWindow("Drowsiness Detection",1280,720);

    // --- MediaPipe Graph ---
    mediapipe::CalculatorGraph graph;
    mediapipe::ParseTextProtoOrDie<mediapipe::CalculatorGraphConfig>(R"(
        # MediaPipe Face Mesh graph here
        # Input video frames, output 468 landmarks
    )");

    while(!stopRequested){
        fd_set fds; FD_ZERO(&fds); FD_SET(fd,&fds); timeval tv={0,5000};
        int r=select(fd+1,&fds,NULL,NULL,&tv);
        if(r<0){ if(errno==EINTR) continue; perror("select"); break;}
        if(r==0) continue;

        v4l2_buffer buf{}; buf.type=V4L2_BUF_TYPE_VIDEO_CAPTURE; buf.memory=V4L2_MEMORY_MMAP;
        xioctl(fd, VIDIOC_DQBUF, &buf);

        unpackBayer8ToRGB(buffers[buf.index].start, frame.data, width, height);
        cv::cvtColor(frame, gray, cv::COLOR_BGR2GRAY);

        // --- MediaPipe Face Mesh (pseudo) ---
        std::vector<cv::Point2f> landmarks; // fill from MediaPipe output (0-467)
        // Example: left eye: 33, 133, 160, 159, 158, 144
        //          right eye: 362, 263, 387, 386, 385, 373
        //          mouth: 78, 308, 13, 14, 87, 317, 82, 312

        if(!landmarks.empty()){
            std::vector<cv::Point2f> leftEye={landmarks[33],landmarks[133],landmarks[160],landmarks[159],landmarks[158],landmarks[144]};
            std::vector<cv::Point2f> rightEye={landmarks[362],landmarks[263],landmarks[387],landmarks[386],landmarks[385],landmarks[373]};
            double ear=(eyeAspectRatio(leftEye)+eyeAspectRatio(rightEye))/2.0;

            double mar=mouthAspectRatio(landmarks); // use correct mouth indices
            cv::Vec3d euler=estimateHeadPose(std::vector<cv::Point2d>(landmarks.begin(),landmarks.end()), frame.size());
            double pitch=euler[0], yaw=euler[1];

            // Smoothing
            earSmooth=smooth(earSmooth,ear); marSmooth=smooth(marSmooth,mar); yawSmooth=smooth(yawSmooth,yaw);

            if(!calibrated){ calibEarSum+=earSmooth; calibCounter++;
                if(calibCounter>=CALIB_FRAMES){ double meanOpenEar=calibEarSum/calibCounter; earThreshold=std::max(0.15,meanOpenEar*0.55); calibrated=true; }
            }

            earHistory.push_back(earSmooth); marHistory.push_back(marSmooth); yawHistory.push_back(yawSmooth);
            if(earHistory.size()>SMOOTHING_WINDOW) earHistory.pop_front(); if(marHistory.size()>SMOOTHING_WINDOW) marHistory.pop_front(); if(yawHistory.size()>SMOOTHING_WINDOW) yawHistory.pop_front();
            double earMed=median(earHistory), marMed=median(marHistory), yawMed=median(yawHistory);

            // Temporal voting for alerts
            std::string status="Driver: OK";
            if(earSmooth<earThreshold){ if(!eyeClosed){ eyeClosedStart=std::chrono::steady_clock::now(); eyeClosed=true; }
                else{ double dur=std::chrono::duration_cast<std::chrono::duration<double>>(std::chrono::steady_clock::now()-eyeClosedStart).count(); if(dur>=EYE_CLOSED_TIME_THRESH) status="DROWSINESS ALERT"; }
            } else{ if(eyeClosed){ blinkCount++; eyeClosed=false; } }

            if(marSmooth>marThreshold) status="Yawning";
            if(std::abs(yawSmooth)>DEFAULT_YAW_THRESH) status="Looking Side";
            if(pitch>DEFAULT_PITCH_THRESH) status="Looking Down";

            cv::putText(frame,status,cv::Point(10,30),cv::FONT_HERSHEY_SIMPLEX,0.9,cv::Scalar(0,0,255),2);
        }

        // --- Display FPS ---
        frameCounter++; auto now=std::chrono::steady_clock::now(); double elapsed=std::chrono::duration_cast<std::chrono::duration<double>>(now-lastTime).count();
        if(elapsed>=1.0){ fps=frameCounter/elapsed; frameCounter=0; lastTime=now; }
        char fpsbuf[64]; snprintf(fpsbuf,sizeof(fpsbuf),"FPS: %.1f",fps); cv::putText(frame,fpsbuf,cv::Point(10,frame.rows-20),cv::FONT_HERSHEY_SIMPLEX,0.7,cv::Scalar(0,255,255),2);

        cv::imshow("Drowsiness Detection",frame);
        xioctl(fd, VIDIOC_QBUF, &buf);
        if(cv::waitKey(1)==27) break;
    }

    xioctl(fd, VIDIOC_STREAMOFF, &type);
    for(auto &b:buffers) munmap(b.start,b.length);
    close(fd); cv::destroyAllWindows();
    return 0;
}

