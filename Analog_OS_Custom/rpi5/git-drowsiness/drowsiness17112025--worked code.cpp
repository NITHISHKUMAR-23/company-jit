#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <linux/videodev2.h>
#include <csignal>
#include <cerrno>
#include <cstdlib>
#include <cstdio>
#include <cstring>
#include <iostream>
#include <fstream>
#include <vector>
#include <atomic>
#include <condition_variable>
#include <thread>
#include <mutex>
#include <numeric>
#include <chrono>

#include <opencv2/opencv.hpp>
#include <opencv2/face.hpp>
#include <opencv2/dnn.hpp>

using namespace std;
using namespace cv;

// ------------------------- CONFIG -------------------------
constexpr int CAP_W = 1920;
constexpr int CAP_H = 1080;
constexpr int PROC_W = 1280; // processing width
constexpr int PROC_H = 720;  // processing height
constexpr int YUNET_SIDE = 256; // yuNet model input size (256 or 320)

constexpr bool USE_BOX_BLUR = true; // used in blur demo (not necessary for drowsiness)
constexpr int OPENCV_THREADS = 2;
constexpr bool ENABLE_TIMESTAMPS = false;

// V4L2
constexpr int V4L2_REQ_COUNT = 2; // 1 or 2; 1 = lower latency

// Models (adjust paths)
const string YUNET_MODEL = "./models/face_detection_yunet_2023mar.onnx";
const string LBF_MODEL   = "./models/lbfmodel.yaml";

// thresholds
const double EAR_INIT_FACTOR = 0.35;
const double EAR_SMOOTH_ALPHA = 0.1;
const double EAR_CLOSED_TIME = 1.5;
const double MAR_YAWN = 0.55;
const double YAW_LIMIT_DEG = 15.0;

// ------------------------- Globals -------------------------
struct Buffer { void* start; size_t length; };
static atomic<bool> running(true);
static mutex frameMutex;
static condition_variable frameCond;
static vector<unsigned char> latestRGB;
static bool frameReady = false;
static atomic<uint64_t> latestFrameId{0};

// ------------------------- Utilities -------------------------
bool fileExists(const string &p){ ifstream f(p); return f.good(); }
void handleSig(int){ running = false; frameCond.notify_all(); }

void xioctl(int fd, int request, void* arg){
    int r;
    do { r = ioctl(fd, request, arg); }
    while (r == -1 && (errno == EINTR || errno == EAGAIN));
    if (r == -1) { perror("ioctl"); exit(EXIT_FAILURE); }
}

// ------------------------- Color conversion (demosaic) -------------------------
// *** UPDATED AS REQUESTED ***
void unpackBayer8ToRGB_Full(const void* src, void* dst, int width, int height) {
    cv::Mat raw8(height, width, CV_8UC1, const_cast<void*>(src));
    cv::Mat rgb;

    // Bayer → RGB
    cv::cvtColor(raw8, rgb, cv::COLOR_BayerRG2RGB);

    // --- Manual color balance ---
    std::vector<cv::Mat> channels(3);
    cv::split(rgb, channels);

    double redGain   = 1.4;
    double greenGain = 1.0;
    double blueGain  = 1.7;

    channels[0] *= blueGain;   // blue
    channels[1] *= greenGain;  // green
    channels[2] *= redGain;    // red

    cv::merge(channels, rgb);

    // --- Contrast + gamma correction ---
    cv::Mat balanced;
    cv::convertScaleAbs(rgb, balanced, 1.2, 5);  // contrast boost

    cv::Mat gamma;
    balanced.convertTo(gamma, CV_32F, 1.0 / 255.0);
    cv::pow(gamma, 1.2, gamma);
    gamma.convertTo(rgb, CV_8UC3, 255.0);

    memcpy(dst, rgb.data, width * height * 3);
}

// ------------------------- EAR / MAR / Headpose -------------------------
double eyeAspectRatio(const std::vector<Point2f>& eye) {
    double A = norm(eye[1] - eye[5]);
    double B = norm(eye[2] - eye[4]);
    double C = norm(eye[0] - eye[3]);
    return (C < 1e-6) ? 0.0 : (A + B) / (2.0 * C);
}

double mouthAspectRatio(const std::vector<Point2f>& lm) {
    double A = norm(lm[61] - lm[67]);
    double B = norm(lm[62] - lm[66]);
    double C = norm(lm[63] - lm[65]);
    double width = norm(lm[60] - lm[64]);
    return (width < 1e-6) ? 0.0 : (A + B + C) / (3.0 * width);
}

Vec3d estimateHeadPose(const vector<Point2d>& landmarks, const Size& imageSize) {
    static vector<Point3d> modelPoints = {
        {0.0,0.0,0.0},{-30.0,-30.0,-30.0},{30.0,-30.0,-30.0},
        {-30.0,30.0,-30.0},{30.0,30.0,-30.0},{0.0,60.0,-30.0}
    };

    vector<Point2d> imagePoints = {
        landmarks[30], landmarks[36], landmarks[45],
        landmarks[48], landmarks[54], landmarks[8]
    };

    double focalLength = imageSize.width;
    Point2d center(imageSize.width/2.0, imageSize.height/2.0);
    Mat cameraMatrix = (Mat_<double>(3,3) <<
        focalLength,0,center.x,
        0,focalLength,center.y,
        0,0,1
    );
    Mat dist = Mat::zeros(4,1,CV_64F);
    Mat rvec, tvec;
    solvePnP(modelPoints, imagePoints, cameraMatrix, dist, rvec, tvec, false, SOLVEPNP_ITERATIVE);
    Mat R; Rodrigues(rvec, R);
    Mat pose = Mat::zeros(3,4,CV_64F);
    R.copyTo(pose.colRange(0,3));
    tvec.copyTo(pose.col(3));
    Mat K, Rmat, T, RX, RY, RZ, euler;
    decomposeProjectionMatrix(pose, K, Rmat, T, RX, RY, RZ, euler);
    return Vec3d(euler.at<double>(0), euler.at<double>(1), euler.at<double>(2));
}

// ------------------------- Capture thread -------------------------
void captureThread(const char* dev) {
    int fd = open(dev, O_RDWR | O_NONBLOCK);
    if(fd < 0){ perror("open"); return; }

    v4l2_format fmt{};
    fmt.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    fmt.fmt.pix.width = CAP_W;
    fmt.fmt.pix.height = CAP_H;
    fmt.fmt.pix.pixelformat = V4L2_PIX_FMT_SRGGB8;
    fmt.fmt.pix.field = V4L2_FIELD_NONE;
    xioctl(fd, VIDIOC_S_FMT, &fmt);

    v4l2_requestbuffers req{};
    req.count = V4L2_REQ_COUNT;
    req.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    req.memory = V4L2_MEMORY_MMAP;
    xioctl(fd, VIDIOC_REQBUFS, &req);

    if(req.count < 1){
        cerr << "[ERROR] Insufficient V4L2 buffers" << endl;
        close(fd);
        return;
    }

    vector<Buffer> bufs(req.count);
    for(unsigned i=0;i<(unsigned)req.count;i++){
        v4l2_buffer b{};
        b.type = req.type;
        b.memory = req.memory;
        b.index = i;
        xioctl(fd, VIDIOC_QUERYBUF, &b);
        bufs[i].length = b.length;
        bufs[i].start = mmap(NULL, b.length, PROT_READ|PROT_WRITE,
                             MAP_SHARED, fd, b.m.offset);
        if(bufs[i].start == MAP_FAILED){
            perror("mmap");
            close(fd);
            return;
        }
        xioctl(fd, VIDIOC_QBUF, &b);
    }

    v4l2_buf_type type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    xioctl(fd, VIDIOC_STREAMON, &type);

    vector<unsigned char> rgbFull(CAP_W * CAP_H * 3);
    latestRGB.resize(PROC_W * PROC_H * 3);

    while(running){
        fd_set fds; FD_ZERO(&fds); FD_SET(fd, &fds);
        timeval tv{0, 5000};
        int s = select(fd+1, &fds, NULL, NULL, &tv);
        if(s < 0){
            if(errno==EINTR) continue;
            perror("select");
            break;
        }
        if(s == 0) continue;

        v4l2_buffer b{};
        b.type = type;
        b.memory = V4L2_MEMORY_MMAP;

        if(ioctl(fd, VIDIOC_DQBUF, &b) == 0){

            // Use the improved Bayer → RGB conversion
            unpackBayer8ToRGB_Full(bufs[b.index].start, rgbFull.data(), CAP_W, CAP_H);

            Mat fullMat(CAP_H, CAP_W, CV_8UC3, rgbFull.data());
            Mat procMat(PROC_H, PROC_W, CV_8UC3, latestRGB.data());
            resize(fullMat, procMat, Size(PROC_W, PROC_H), 0, 0, INTER_LINEAR);

            {
                unique_lock<mutex> lk(frameMutex);
                frameReady = true;
                ++latestFrameId;
            }
            frameCond.notify_one();

            xioctl(fd, VIDIOC_QBUF, &b);
        }
    }

    xioctl(fd, VIDIOC_STREAMOFF, &type);

    for(auto &bb : bufs) munmap(bb.start, bb.length);
    close(fd);
}

// ------------------------- Simple NMS -------------------------
vector<int> simpleNMS(const vector<Rect>& boxes, const vector<float>& scores, float iouThresh){
    vector<int> idx(boxes.size());
    iota(idx.begin(), idx.end(), 0);

    sort(idx.begin(), idx.end(), [&](int a, int b){
        return scores[a] > scores[b];
    });

    vector<int> keep;
    vector<char> suppressed(boxes.size(), 0);

    for(size_t _i=0; _i<idx.size(); ++_i){
        int i = idx[_i];
        if(suppressed[i]) continue;

        keep.push_back(i);

        for(size_t _j=_i+1; _j<idx.size(); ++_j){
            int j = idx[_j];
            if(suppressed[j]) continue;

            float inter = (boxes[i] & boxes[j]).area();
            float uni = boxes[i].area() + boxes[j].area() - inter;
            if(uni <= 0) continue;

            if((inter/uni) > iouThresh) suppressed[j] = 1;
        }
    }
    return keep;
}

// ------------------------- Detection Thread -------------------------
void detectThread(){
    setNumThreads(OPENCV_THREADS);

    const Size procSz(PROC_W, PROC_H);
    const Size yunSz(YUNET_SIDE, YUNET_SIDE);

    if(!fileExists(YUNET_MODEL) || !fileExists(LBF_MODEL)){
        cerr << "[ERROR] Missing model files." << endl;
        running = false;
        frameCond.notify_all();
        return;
    }

    Ptr<FaceDetectorYN> yunet =
        FaceDetectorYN::create(YUNET_MODEL, "", yunSz, 0.45, 0.3, 5000);
    yunet->setInputSize(yunSz);

    Ptr<face::Facemark> facemark = face::FacemarkLBF::create();
    facemark->loadModel(LBF_MODEL);

    namedWindow("Drowsiness", WINDOW_NORMAL);
    resizeWindow("Drowsiness", 960, 540);

    Mat procMat(PROC_H, PROC_W, CV_8UC3);
    Mat yunIn(yunSz.height, yunSz.width, CV_8UC3);
    Mat gray;

    double earThreshold = 0.0;
    bool earInitialized = false;

    deque<double> yawHistory;
    const int YAW_WINDOW = 10;
    bool eyesClosed = false;
    chrono::steady_clock::time_point eyesClosedStart;

    while(running){

        {
            unique_lock<mutex> lk(frameMutex);
            frameCond.wait(lk, []{ return frameReady || !running; });
            if(!running) break;

            Mat wrap(PROC_H, PROC_W, CV_8UC3, latestRGB.data());
            wrap.copyTo(procMat);
            frameReady = false;
        }

        uint64_t frameId = latestFrameId.load();

        // YuNet face detection
        resize(procMat, yunIn, yunSz);
        yunet->setInputSize(yunSz);
        Mat dets;
        yunet->detect(yunIn, dets);

        vector<Rect> boxes;
        vector<float> scores;

        for(int i=0;i<dets.rows;i++){
            float conf = dets.at<float>(i,4);
            if(conf < 0.35f) continue;

            float x = dets.at<float>(i,0) * procSz.width  / yunSz.width;
            float y = dets.at<float>(i,1) * procSz.height / yunSz.height;
            float w = dets.at<float>(i,2) * procSz.width  / yunSz.width;
            float h = dets.at<float>(i,3) * procSz.height / yunSz.height;

            Rect r(cvRound(x), cvRound(y), cvRound(w), cvRound(h));
            r &= Rect(0,0,procSz.width, procSz.height);
            if(r.area() <= 0) continue;

            boxes.push_back(r);
            scores.push_back(conf);
        }

        vector<int> keepIdx;
        if(!boxes.empty()){
            try{
                dnn::NMSBoxes(boxes, scores, 0.3f, 0.45f, keepIdx, 1.f, 100);
            }
            catch(...){
                keepIdx = simpleNMS(boxes, scores, 0.45f);
            }
        }

        string status = "Driver OK";
        bool alert = false;

        if(!keepIdx.empty()){

            int best = keepIdx[0];
            double bestArea = boxes[best].area();
            for(int i=1;i<(int)keepIdx.size();++i){
                int id = keepIdx[i];
                if(boxes[id].area() > bestArea){
                    best = id;
                    bestArea = boxes[id].area();
                }
            }

            Rect faceR = boxes[best];

            Mat faceROI = procMat(faceR);
            cvtColor(faceROI, gray, COLOR_BGR2GRAY);

            vector<Rect> tmp = { Rect(0,0,faceR.width, faceR.height) };
            vector<vector<Point2f>> landmarks;
            bool ok = false;

            try{ ok = facemark->fit(gray, tmp, landmarks); }
            catch(...){ ok = false; }

            if(ok && !landmarks.empty()){
                auto lm = landmarks[0];

                for(auto &p : lm){
                    p.x += faceR.x;
                    p.y += faceR.y;
                }

                vector<Point2f> leftEye {
                    lm[36],lm[37],lm[38],lm[39],lm[40],lm[41]
                };
                vector<Point2f> rightEye {
                    lm[42],lm[43],lm[44],lm[45],lm[46],lm[47]
                };

                double ear =
                    (eyeAspectRatio(leftEye) +
                     eyeAspectRatio(rightEye)) / 2.0;

                double mar = mouthAspectRatio(lm);

                vector<Point2d> lm2d(lm.begin(), lm.end());
                double yaw = estimateHeadPose(lm2d, procMat.size())[1];

                if(!earInitialized){
                    earThreshold = ear * EAR_INIT_FACTOR;
                    earInitialized = true;
                }

                earThreshold =
                    (1.0 - EAR_SMOOTH_ALPHA) * earThreshold +
                     EAR_SMOOTH_ALPHA     * (ear * EAR_INIT_FACTOR);

                if(ear < earThreshold){
                    if(!eyesClosed){
                        eyesClosed = true;
                        eyesClosedStart = chrono::steady_clock::now();
                    } else {
                        double sec =
                            chrono::duration<double>(
                                chrono::steady_clock::now() - eyesClosedStart
                            ).count();

                        if(sec >= EAR_CLOSED_TIME){
                            status = "DROWSINESS DETECTED";
                            alert = true;
                        }
                    }
                } else {
                    eyesClosed = false;
                }

                if(mar > MAR_YAWN){
                    status = "YAWNING";
                    alert = true;
                }

                yawHistory.push_back(yaw);
                if((int)yawHistory.size() > YAW_WINDOW)
                    yawHistory.pop_front();

                double yawAvg =
                    accumulate(yawHistory.begin(), yawHistory.end(), 0.0)
                    / max(1,(int)yawHistory.size());

                if(yawAvg > YAW_LIMIT_DEG){
                    status = "TURNING RIGHT";
                    alert = true;
                }
                else if(yawAvg < -YAW_LIMIT_DEG){
                    status = "TURNING LEFT";
                    alert = true;
                }

                rectangle(procMat, faceR,
                          alert ? Scalar(0,0,255) : Scalar(0,255,0),
                          2);

                for(auto &p : lm){
                    circle(procMat, p, 2, Scalar(255,0,0), -1);
                }

                putText(procMat, format("EAR: %.3f", ear),
                        Point(10,30), FONT_HERSHEY_SIMPLEX,
                        0.8, Scalar(255,255,0), 2);

                putText(procMat, format("MAR: %.3f", mar),
                        Point(10,60), FONT_HERSHEY_SIMPLEX,
                        0.8, Scalar(255,255,0), 2);

                putText(procMat, status,
                        Point(10,100), FONT_HERSHEY_SIMPLEX,
                        1.0, Scalar(0,0,255), 2);
            } else {
                status = "Landmarks Not Found";
            }
        } else {
            status = "No Face Detected";
        }

        imshow("Drowsiness", procMat);
        if(waitKey(1) == 27) break;
    }
}

// ------------------------- Main -------------------------
int main(int argc, char** argv){
    signal(SIGINT, handleSig);
    signal(SIGTERM, handleSig);

    if(!fileExists(YUNET_MODEL)){
        cerr << "[ERROR] YuNet model not found: " << YUNET_MODEL << endl;
        return -1;
    }
    if(!fileExists(LBF_MODEL)){
        cerr << "[ERROR] LBF model not found: " << LBF_MODEL << endl;
        return -1;
    }

    latestRGB.resize(PROC_W * PROC_H * 3);

    const char* dev = "/dev/video0";
    thread cap(captureThread, dev);
    thread det(detectThread);

    cap.join();
    det.join();

    return 0;
}

