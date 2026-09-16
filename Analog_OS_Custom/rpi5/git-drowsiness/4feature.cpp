// ================================================
// FULL UPDATED C++ DROWSINESS SYSTEM
// Detection logic rewritten based on Python example
// (using YuNet + LBF 68-landmark model)
// ================================================

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
#include <deque>
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
constexpr int PROC_W = 1280;
constexpr int PROC_H = 720;
constexpr int YUNET_SIDE = 256;

constexpr int OPENCV_THREADS = 2;

// V4L2
constexpr int V4L2_REQ_COUNT = 2;

// Models
const string YUNET_MODEL = "./models/face_detection_yunet_2023mar.onnx";
const string LBF_MODEL   = "./models/lbfmodel.yaml";

// Python-matching thresholds
constexpr double EAR_THRESH = 0.25;
constexpr double MAR_THRESH = 0.65;
constexpr double BLINK_DURATION = 0.2;  // sec
constexpr double CLOSED_REQUIRED = 0.5; // sec
constexpr double HEAD_POSE_YAW_THRESH = 25.0;
constexpr double HEAD_POSE_PITCH_THRESH = 20.0;

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

// ------------------------- Bayer demosaic -------------------------
void unpackBayer8ToRGB_Full(const void* src, void* dst, int width, int height) {
    cv::Mat raw8(height, width, CV_8UC1, const_cast<void*>(src));
    cv::Mat rgb;
    cv::cvtColor(raw8, rgb, cv::COLOR_BayerRG2RGB);

    vector<cv::Mat> ch(3);
    split(rgb, ch);

    ch[0] *= 1.7;  // B
    ch[1] *= 1.0;  // G
    ch[2] *= 1.4;  // R

    merge(ch, rgb);

    cv::Mat balanced;
    cv::convertScaleAbs(rgb, balanced, 1.2, 5);

    cv::Mat gamma;
    balanced.convertTo(gamma, CV_32F, 1.0/255.0);
    cv::pow(gamma, 1.2, gamma);
    gamma.convertTo(rgb, CV_8UC3, 255.0);

    memcpy(dst, rgb.data, width * height * 3);
}

// ------------------------- EAR / MAR -------------------------
double eyeAspectRatio(const vector<Point2f>& eye) {
    double A = norm(eye[1] - eye[5]);
    double B = norm(eye[2] - eye[4]);
    double C = norm(eye[0] - eye[3]);
    if(C < 1e-6) return 0.0;
    return (A + B) / (2.0 * C);
}

double mouthAspectRatio_LBF(const vector<Point2f>& lm) {
    // Use 48 (left), 54 (right), and verticals 51 (top), 57 (bottom)
    double A = norm(lm[51] - lm[57]);
    double width = norm(lm[48] - lm[54]);
    if(width < 1e-6) return 0.0;
    return A / width;
}

// ------------------------- Headpose -------------------------
Vec3d estimateHeadPose(const vector<Point2f>& lm, const Size& sz) {
    vector<Point3d> modelPoints = {
        {0,0,0},         // nose
        {-30,-30,-30},   // left eye
        {30,-30,-30},    // right eye
        {-30,30,-30},    // left mouth
        {30,30,-30},     // right mouth
        {0,60,-30}       // chin
    };

    vector<Point2d> imgPts = {
        lm[30],  // nose tip
        lm[36],  // left eye
        lm[45],  // right eye
        lm[48],  // mouth left
        lm[54],  // mouth right
        lm[8]    // chin
    };

    double f = sz.width;
    Point2d c(sz.width/2.0, sz.height/2.0);

    Mat cam = (Mat_<double>(3,3)<< f,0,c.x, 0,f,c.y, 0,0,1);
    Mat dist = Mat::zeros(4,1,CV_64F);

    Mat r,t;
    solvePnP(modelPoints, imgPts, cam, dist, r, t);

    Mat R; Rodrigues(r, R);
    Mat proj = Mat::zeros(3,4,CV_64F);
    R.copyTo(proj(Rect(0,0,3,3)));
    t.copyTo(proj.col(3));

    Mat K, Rm, T, RX, RY, RZ, e;
    decomposeProjectionMatrix(proj, K, Rm, T, RX, RY, RZ, e);

    return Vec3d(e.at<double>(0), e.at<double>(1), e.at<double>(2));
}

// ------------------------- Capture thread -------------------------
// (unchanged)
// ========= CONTINUATION OF FULL UPDATED C++ CODE ==========

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
    for(unsigned i=0;i<req.count;i++){
        v4l2_buffer b{};
        b.type = req.type;
        b.memory = req.memory;
        b.index = i;
        xioctl(fd, VIDIOC_QUERYBUF, &b);
        bufs[i].length = b.length;
        bufs[i].start = mmap(NULL, b.length, PROT_READ|PROT_WRITE,
                             MAP_SHARED, fd, b.m.offset);
        if(bufs[i].start == MAP_FAILED){
            perror("mmap"); close(fd); return;
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
            unpackBayer8ToRGB_Full(bufs[b.index].start, rgbFull.data(), CAP_W, CAP_H);

            Mat fullMat(CAP_H, CAP_W, CV_8UC3, rgbFull.data());
            Mat procMat(PROC_H, PROC_W, CV_8UC3, latestRGB.data());
            resize(fullMat, procMat, Size(PROC_W, PROC_H), 0,0,INTER_LINEAR);

            {
                lock_guard<mutex> lk(frameMutex);
                frameReady = true;
                latestFrameId++;
            }
            frameCond.notify_one();

            xioctl(fd, VIDIOC_QBUF, &b);
        }
    }

    xioctl(fd, VIDIOC_STREAMOFF, &type);
    for(auto& bb : bufs) munmap(bb.start, bb.length);
    close(fd);
}

// ------------------------- Simple NMS -------------------------
vector<int> simpleNMS(const vector<Rect>& boxes, const vector<float>& scores, float iouThresh){
    vector<int> idx(boxes.size());
    iota(idx.begin(), idx.end(), 0);

    sort(idx.begin(), idx.end(), [&](int a, int b){ return scores[a] > scores[b]; });

    vector<int> keep;
    vector<char> sup(boxes.size(), 0);

    for(size_t _i=0; _i<idx.size(); _i++){
        int i = idx[_i];
        if(sup[i]) continue;
        keep.push_back(i);

        for(size_t _j=_i+1; _j<idx.size(); _j++){
            int j = idx[_j];
            if(sup[j]) continue;
            float inter = (boxes[i] & boxes[j]).area();
            float uni = boxes[i].area() + boxes[j].area() - inter;
            if(uni > 0 && inter/uni > iouThresh)
                sup[j] = 1;
        }
    }
    return keep;
}

// -----------------------------------------------------------
// ---------------------- DETECTION THREAD -------------------
// -----------------------------------------------------------
void detectThread(){
    setNumThreads(OPENCV_THREADS);

    const Size procSz(PROC_W, PROC_H);
    const Size yunSz(YUNET_SIDE, YUNET_SIDE);

    if(!fileExists(YUNET_MODEL) || !fileExists(LBF_MODEL)){
        cerr << "[ERROR] Missing model files." << endl;
        running = false; frameCond.notify_all();
        return;
    }

    Ptr<FaceDetectorYN> yunet =
        FaceDetectorYN::create(YUNET_MODEL, "", yunSz, 0.45, 0.3, 5000);
    yunet->setInputSize(yunSz);

    Ptr<face::Facemark> facemark = face::FacemarkLBF::create();
    facemark->loadModel(LBF_MODEL);

    namedWindow("Driver Monitor", WINDOW_NORMAL);
    resizeWindow("Driver Monitor", 960, 540);

    Mat procFrame(PROC_H, PROC_W, CV_8UC3);
    Mat yunIn(yunSz.height, yunSz.width, CV_8UC3);
    Mat gray;

    // ===== Python-equivalent state =====
    double eye_closed_start = -1;
    double last_status_update = 0;
    int blink_counter = 0;
    vector<double> blink_times;
    string displayStatus = "Driver: OK";

    while(running){
        // ---- Wait for frame ----
        {
            unique_lock<mutex> lk(frameMutex);
            frameCond.wait(lk, []{ return frameReady || !running; });
            if(!running) break;
            Mat wrapper(PROC_H, PROC_W, CV_8UC3, latestRGB.data());
            wrapper.copyTo(procFrame);
            frameReady = false;
        }

        // ------------------ Face detection ------------------
        resize(procFrame, yunIn, yunSz);
        yunet->setInputSize(yunSz);
        Mat dets;
        yunet->detect(yunIn, dets);

        vector<string> status;   // accumulate like Python
        bool faceFound = false;
        vector<Rect> boxes;
        vector<float> scores;

        for(int i=0;i<dets.rows;i++){
            float conf = dets.at<float>(i,4);
            if(conf < 0.35f) continue;

            float x = dets.at<float>(i,0) * procSz.width / yunSz.width;
            float y = dets.at<float>(i,1) * procSz.height/ yunSz.height;
            float w = dets.at<float>(i,2) * procSz.width / yunSz.width;
            float h = dets.at<float>(i,3) * procSz.height/ yunSz.height;

            Rect r(cvRound(x),cvRound(y),cvRound(w),cvRound(h));
            r &= Rect(0,0,PROC_W,PROC_H);
            if(r.area() > 0){
                boxes.push_back(r);
                scores.push_back(conf);
            }
        }

        vector<int> keep;
        if(!boxes.empty()){
            try{ dnn::NMSBoxes(boxes, scores, 0.3f, 0.45f, keep); }
            catch(...){ keep = simpleNMS(boxes, scores, 0.45f); }
        }

        if(keep.empty()){
            status.push_back("NO FACE DETECTED");
        } else {
            // choose largest face
            int best = keep[0];
            double area = boxes[best].area();
            for(int i: keep){
                if(boxes[i].area() > area){
                    best = i; area = boxes[i].area();
                }
            }

            Rect faceR = boxes[best];
            faceFound = true;

            Mat faceROI = procFrame(faceR);
            cvtColor(faceROI, gray, COLOR_BGR2GRAY);

            vector<vector<Point2f>> lm;
            vector<Rect> faceRectLocal = { Rect(0,0,faceR.width, faceR.height) };

            bool ok = false;
            try{ ok = facemark->fit(gray, faceRectLocal, lm); }
            catch(...){ ok = false; }

            if(ok && !lm.empty()){
                auto &land = lm[0];

                // Shift to full image coords
                for(auto &p : land){
                    p.x += faceR.x;
                    p.y += faceR.y;
                }

                // ------------------ EAR detection ------------------
                vector<Point2f> leftEye {
                    land[36], land[37], land[38],
                    land[39], land[40], land[41]
                };
                vector<Point2f> rightEye {
                    land[42], land[43], land[44],
                    land[45], land[46], land[47]
                };

                double ear = (eyeAspectRatio(leftEye) + eyeAspectRatio(rightEye)) / 2.0;

                double now = chrono::duration<double>(
                    chrono::steady_clock::now().time_since_epoch()).count();

                if(ear < EAR_THRESH){
                    if(eye_closed_start < 0){
                        eye_closed_start = now;
                    } else {
                        if(now - eye_closed_start >= CLOSED_REQUIRED){
                            status.push_back("Eyes Closed");
                        }
                    }
                } else {
                    if(eye_closed_start > 0){
                        double dur = now - eye_closed_start;
                        if(dur <= BLINK_DURATION){
                            blink_counter++;
                            blink_times.push_back(now);
                        }
                    }
                    eye_closed_start = -1;
                }

                // purge old blink timestamps
                blink_times.erase(
                    remove_if(blink_times.begin(), blink_times.end(),
                        [&](double t){ return now - t > 60.0; }),
                    blink_times.end()
                );

                // ------------------ MAR (yawn) ------------------
                double mar = mouthAspectRatio_LBF(land);
                if(mar > MAR_THRESH){
                    status.push_back("Yawning");
                }

                // ------------------ Head pose ------------------
                Vec3d pose = estimateHeadPose(land, procSz);
                double pitch = pose[0];
                double yaw = pose[1];

                if(yaw >  HEAD_POSE_YAW_THRESH)  status.push_back("Looking Left");
                if(yaw < -HEAD_POSE_YAW_THRESH)  status.push_back("Looking Right");
                if(pitch >  HEAD_POSE_PITCH_THRESH) status.push_back("Looking Down");
                if(pitch < -HEAD_POSE_PITCH_THRESH) status.push_back("Looking Up");

                // distraction
                if(find(status.begin(), status.end(), "Looking Left")  != status.end() ||
                   find(status.begin(), status.end(), "Looking Right") != status.end() ||
                   find(status.begin(), status.end(), "Looking Down")  != status.end())
                {
                    status.push_back("Distracted");
                }

                // draw face + landmarks
                rectangle(procFrame, faceR, Scalar(0,255,0), 2);
                for(auto &p : land)
                    circle(procFrame, p, 2, Scalar(255,0,0), -1);

                putText(procFrame, format("EAR: %.3f", ear),
                        Point(10,30), FONT_HERSHEY_SIMPLEX, 0.7, Scalar(255,255,0),2);

                putText(procFrame, format("MAR: %.3f", mar),
                        Point(10,60), FONT_HERSHEY_SIMPLEX, 0.7, Scalar(255,255,0),2);
            }
        }

        // ------------- Update status every 0.5 sec (Python logic) -------------
        double now = chrono::duration<double>(
            chrono::steady_clock::now().time_since_epoch()).count();

        if(now - last_status_update > 0.5){
            if(status.empty()) displayStatus = "Driver: OK";
            else {
                displayStatus.clear();
                for(size_t i=0;i<status.size();i++){
                    displayStatus += status[i];
                    if(i+1 < status.size()) displayStatus += " | ";
                }
            }
            last_status_update = now;
        }

        putText(procFrame, displayStatus, Point(10,100),
                FONT_HERSHEY_SIMPLEX, 1.0, Scalar(0,0,255), 2);

        imshow("Driver Monitor", procFrame);
        if(waitKey(1) == 27) break; // ESC
    }
}

// ------------------------- MAIN -------------------------
int main(){
    signal(SIGINT, handleSig);
    signal(SIGTERM, handleSig);

    if(!fileExists(YUNET_MODEL)){
        cerr << "[ERROR] YuNet model not found.\n";
        return -1;
    }
    if(!fileExists(LBF_MODEL)){
        cerr << "[ERROR] LBF model not found.\n";
        return -1;
    }

    latestRGB.resize(PROC_W * PROC_H * 3);

    const char* dev = "/dev/video0";
    thread tcap(captureThread, dev);
    thread tdet(detectThread);

    tcap.join();
    tdet.join();
    return 0;
}


