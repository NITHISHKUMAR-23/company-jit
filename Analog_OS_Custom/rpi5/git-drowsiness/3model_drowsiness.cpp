// face_drowsiness.cpp
// Based on your face_blur.cpp, but now with drowsiness, yawning, head pose, and state logic.

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
#include <opencv2/dnn.hpp>

// Include dlib for landmarks
#include <dlib/opencv.h>
#include <dlib/image_processing.h>
#include <dlib/image_processing/frontal_face_detector.h>

using namespace std;
using namespace cv;

// ------------------------- CONFIG -------------------------
constexpr int CAP_W = 1920;
constexpr int CAP_H = 1080;
constexpr int PROC_W = 1280;
constexpr int PROC_H = 720;

constexpr int YUNET_SIDE = 256;
constexpr bool USE_BOX_BLUR = false;  // we no longer blur
constexpr bool USE_HAAR = false;

constexpr bool REUSE_MATS = true;
constexpr int OPENCV_THREADS = 2;
constexpr bool ENABLE_TIMESTAMPS = true;

constexpr int V4L2_REQ_COUNT = 1;

const string YUNET_MODEL = "./face_detector/face_detection_yunet_2023mar.onnx";
const string HAAR_FILE = "./face_detector/haarcascade_frontalface_default.xml";

// New: dlib model path
const string SHAPE_PREDICTOR = "./shape_predictor_68_face_landmarks.dat";

// EAR / MAR thresholds and timings
constexpr double EAR_THRESHOLD = 0.25;    // adjust per person
constexpr double MAR_THRESHOLD = 0.75;    // adjust per person
constexpr int EAR_CONSEC_FRAMES = 2 * 30; // assume ~30 fps: 2 seconds
constexpr int MAR_CONSEC_FRAMES = 3 * 30; // 3 seconds

// Head pose thresholds (in degrees) for left/right
constexpr double YAW_LEFT_THRESHOLD = -15.0;
constexpr double YAW_RIGHT_THRESHOLD = 15.0;

// State enums
enum DriverState { STATE_NO_FACE, STATE_OK, STATE_DROWSY, STATE_YAWNING, STATE_HEAD_LEFT, STATE_HEAD_RIGHT };

// Globals for threading
struct Buffer { void* start; size_t length; };
static atomic<bool> running(true);
static mutex frameMutex;
static condition_variable frameCond;
static vector<unsigned char> latestRGB;
static bool frameReady = false;
static atomic<uint64_t> latestFrameId{0};

// -------------------- Utilities --------------------
bool fileExists(const string &p) { ifstream f(p); return f.good(); }
void handleSig(int) { running = false; frameCond.notify_all(); }
void xioctl(int fd, int request, void* arg) {
    int r;
    do { r = ioctl(fd, request, arg); }
    while (r == -1 && (errno == EINTR || errno == EAGAIN));
    if (r == -1) { perror("ioctl"); exit(EXIT_FAILURE); }
}

void unpackBayer8ToRGB_Full(const void* src, void* dst, int w, int h) {
    Mat raw8(h, w, CV_8UC1, const_cast<void*>(src));
    Mat rgb;
    cvtColor(raw8, rgb, COLOR_BayerRG2RGB);
    vector<Mat> ch(3);
    split(rgb, ch);
    double redGain = 1.3, greenGain = 1.0, blueGain = 1.6;
    ch[0] *= blueGain;
    ch[1] *= greenGain;
    ch[2] *= redGain;
    merge(ch, rgb);
    Mat balanced;
    convertScaleAbs(rgb, balanced, 1.2, 10);
    Mat gammaMat;
    balanced.convertTo(gammaMat, CV_32F, 1.0/255.0);
    pow(gammaMat, 1.2, gammaMat);
    gammaMat.convertTo(rgb, CV_8UC3, 255.0);
    memcpy(dst, rgb.data, w * h * 3);
}

// -------------------- Capture Thread --------------------
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

    if(req.count < 1){ cerr << "[ERROR] Insufficient V4L2 buffers" << endl; close(fd); return; }

    vector<Buffer> bufs(req.count);
    for(unsigned i=0;i<(unsigned)req.count;i++){
        v4l2_buffer b{};
        b.type = req.type; b.memory = req.memory; b.index = i;
        xioctl(fd, VIDIOC_QUERYBUF, &b);
        bufs[i].length = b.length;
        bufs[i].start = mmap(NULL, b.length, PROT_READ|PROT_WRITE, MAP_SHARED, fd, b.m.offset);
        if(bufs[i].start == MAP_FAILED){ perror("mmap"); close(fd); return; }
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
        if(s < 0){ if(errno==EINTR) continue; perror("select"); break; }
        if(s == 0) continue;

        v4l2_buffer b{}; b.type = type; b.memory = V4L2_MEMORY_MMAP;
        if(ioctl(fd, VIDIOC_DQBUF, &b) == 0){
            unpackBayer8ToRGB_Full(bufs[b.index].start, rgbFull.data(), CAP_W, CAP_H);
            Mat rgbFullMat(CAP_H, CAP_W, CV_8UC3, rgbFull.data());
            Mat rgbProcMat(PROC_H, PROC_W, CV_8UC3, latestRGB.data());
            resize(rgbFullMat, rgbProcMat, Size(PROC_W, PROC_H), 0, 0, INTER_NEAREST);

            {
                unique_lock<mutex> lk(frameMutex);
                frameReady = true;
                ++latestFrameId;
            }
            frameCond.notify_one();

            if(ENABLE_TIMESTAMPS){
                auto ts = chrono::steady_clock::now();
                long long ms = chrono::duration_cast<chrono::milliseconds>(ts.time_since_epoch()).count();
                uint64_t id = latestFrameId.load();
                cout << "[TS_CAPTURE " << id << " " << ms << "]" << endl;
            }

            xioctl(fd, VIDIOC_QBUF, &b);
        }
    }

    xioctl(fd, VIDIOC_STREAMOFF, &type);
    for(auto &bb : bufs) munmap(bb.start, bb.length);
    close(fd);
}

// -------------------- Helper: EAR, MAR, Head Pose --------------------

// Compute Euclidean distance between two points
static double euclid(const dlib::point &p1, const dlib::point &p2) {
    double dx = p1.x() - p2.x();
    double dy = p1.y() - p2.y();
    return sqrt(dx*dx + dy*dy);
}

// Eye Aspect Ratio (EAR) for one eye
double computeEAR(const std::vector<dlib::point> &eye) {
    // eye has 6 points: p1-p6; formula: (|p2-p6| + |p3-p5|) / (2*|p1-p4|)
    double A = euclid(eye[1], eye[5]);
    double B = euclid(eye[2], eye[4]);
    double C = euclid(eye[0], eye[3]);
    double ear = (A + B) / (2.0 * C);
    return ear;
}

// Mouth Aspect Ratio (MAR)
double computeMAR(const std::vector<dlib::point> &mouth) {
    // mouth landmarks: use e.g.  [61, 67], [62,66], [63,65] over dividing width [60-64]
    // Here, I'll pick points from 68-point dlib:
    // p61 = mouth[61], p67 = mouth[67], etc. Adjust indices accordingly.
    double A = euclid(mouth[61], mouth[67]);
    double B = euclid(mouth[62], mouth[66]);
    double C = euclid(mouth[63], mouth[65]);
    double D = euclid(mouth[60], mouth[64]); // width
    double mar = (A + B + C) / (2.0 * D);
    return mar;
}

// Head pose estimation: solvePnP using 2D-3D correspondences
bool estimateHeadPose(const std::vector<dlib::point>& landmarks,
                      const Mat& cameraMatrix, const Mat& distCoeffs,
                      Vec3d &rvec, Vec3d &tvec)
{
    // 3D model points.
    std::vector<Point3d> modelPoints = {
        {0.0, 0.0, 0.0},          // Nose tip
        {0.0, -330.0, -65.0},     // Chin
        {-225.0, 170.0, -135.0},  // Left eye left corner
        {225.0, 170.0, -135.0},   // Right eye right corner
        {-150.0, -150.0, -125.0}, // Left Mouth corner
        {150.0, -150.0, -125.0}   // Right mouth corner
    };

    // 2D image points from landmarks
    std::vector<Point2d> imagePoints;
    imagePoints.push_back(Point2d(landmarks[30].x(), landmarks[30].y())); // nose tip
    imagePoints.push_back(Point2d(landmarks[8].x(), landmarks[8].y()));   // chin
    imagePoints.push_back(Point2d(landmarks[36].x(), landmarks[36].y())); // left eye left corner
    imagePoints.push_back(Point2d(landmarks[45].x(), landmarks[45].y())); // right eye right corner
    imagePoints.push_back(Point2d(landmarks[48].x(), landmarks[48].y())); // left mouth corner
    imagePoints.push_back(Point2d(landmarks[54].x(), landmarks[54].y())); // right mouth corner

    // Solve PnP
    bool ok = solvePnP(modelPoints, imagePoints, cameraMatrix, distCoeffs, rvec, tvec, false, SOLVEPNP_ITERATIVE);
    return ok;
}

// Convert Rodrigues rotation vector to yaw/pitch/roll (in degrees)
Vec3d rotationVectorToEuler(const Vec3d &rvec) {
    Mat R;
    Rodrigues(rvec, R);
    double sy = sqrt(R.at<double>(0,0) * R.at<double>(0,0) +
                     R.at<double>(1,0) * R.at<double>(1,0));
    bool singular = (sy < 1e-6);
    double x, y, z;
    if (!singular) {
        x = atan2(R.at<double>(2,1), R.at<double>(2,2));
        y = atan2(-R.at<double>(2,0), sy);
        z = atan2(R.at<double>(1,0), R.at<double>(0,0));
    } else {
        x = atan2(-R.at<double>(1,2), R.at<double>(1,1));
        y = atan2(-R.at<double>(2,0), sy);
        z = 0;
    }
    // Convert to degrees
    return Vec3d(x * 180.0 / CV_PI, y * 180.0 / CV_PI, z * 180.0 / CV_PI);
}

// -------------------- Detection & Logic Thread --------------------
void detectThread() {
    cv::setNumThreads(OPENCV_THREADS);

    if (!fileExists(YUNET_MODEL)) {
        cerr << "[ERROR] YuNet model missing: " << YUNET_MODEL << endl;
        running = false; frameCond.notify_all();
        return;
    }
    if (!fileExists(SHAPE_PREDICTOR)) {
        cerr << "[ERROR] Shape predictor missing: " << SHAPE_PREDICTOR << endl;
        running = false; frameCond.notify_all();
        return;
    }

    // Initialize face detector
    Ptr<FaceDetectorYN> yunet = FaceDetectorYN::create(YUNET_MODEL, "", Size(YUNET_SIDE, YUNET_SIDE), 0.45, 0.3, 5000);
    yunet->setInputSize(Size(YUNET_SIDE, YUNET_SIDE));

    // Initialize dlib face landmark detector
    dlib::frontal_face_detector dlibDetector = dlib::get_frontal_face_detector();
    dlib::shape_predictor shapePredictor;
    dlib::deserialize(SHAPE_PREDICTOR) >> shapePredictor;

    namedWindow("Driver Monitor", WINDOW_NORMAL);
    resizeWindow("Driver Monitor", 960, 720);

    Mat procMat(PROC_H, PROC_W, CV_8UC3);
    Mat yunInMat(YUNET_SIDE, YUNET_SIDE, CV_8UC3);

    // For head-pose: camera intrinsics (you need to set this correctly)
    double focal_length = PROC_W; // approximate
    Point2d center = Point2d(PROC_W / 2.0, PROC_H / 2.0);
    Mat cameraMatrix = (Mat_<double>(3,3) << focal_length, 0, center.x,
                                             0, focal_length, center.y,
                                             0, 0, 1);
    Mat distCoeffs = Mat::zeros(4,1,DataType<double>::type);

    // Counters for consecutive frames
    int eyeClosedFrames = 0;
    int mouthOpenFrames = 0;

    DriverState currentState = STATE_NO_FACE;

    while (running) {
        {
            unique_lock<mutex> lk(frameMutex);
            frameCond.wait(lk, []{ return frameReady || !running; });
            if (!running) break;
            frameReady = false;
        }

        // wrap buffer
        Mat wrap(PROC_H, PROC_W, CV_8UC3, latestRGB.data());
        wrap.copyTo(procMat);

        uint64_t frameId = latestFrameId.load();

        // Face detection via YuNet
        resize(procMat, yunInMat, Size(YUNET_SIDE, YUNET_SIDE), 0, 0, INTER_LINEAR);
        yunet->setInputSize(Size(YUNET_SIDE, YUNET_SIDE));
        Mat dets;
        yunet->detect(yunInMat, dets);

        vector<Rect> boxes;
        vector<float> scores;
        for (int i = 0; i < dets.rows; i++) {
            float conf = dets.at<float>(i, 4);
            if (conf < 0.35f) continue;
            float x = dets.at<float>(i, 0) * PROC_W / (float)YUNET_SIDE;
            float y = dets.at<float>(i, 1) * PROC_H / (float)YUNET_SIDE;
            float w = dets.at<float>(i, 2) * PROC_W / (float)YUNET_SIDE;
            float h = dets.at<float>(i, 3) * PROC_H / (float)YUNET_SIDE;
            Rect r(cvRound(x), cvRound(y), cvRound(w), cvRound(h));
            r &= Rect(0, 0, PROC_W, PROC_H);
            if (r.area() <= 0) continue;
            boxes.push_back(r);
            scores.push_back(conf);
        }

        if (boxes.empty()) {
            currentState = STATE_NO_FACE;
        } else {
            // pick highest score face
            int bestIdx = max_element(scores.begin(), scores.end()) - scores.begin();
            Rect faceRect = boxes[bestIdx];

            // Convert to dlib rectangle
            dlib::cv_image<dlib::bgr_pixel> dlibImg(procMat);
            dlib::rectangle dlibRect(faceRect.x, faceRect.y,
                                     faceRect.x + faceRect.width,
                                     faceRect.y + faceRect.height);

            // Landmark detection
            dlib::full_object_detection shape = shapePredictor(dlibImg, dlibRect);

            // Extract landmarks to vector<dlib::point>
            vector<dlib::point> landmarks;
            for (int i = 0; i < shape.num_parts(); i++) {
                landmarks.push_back(shape.part(i));
            }

            // Compute EAR for both eyes
            vector<dlib::point> leftEye, rightEye;
            // dlib 68-point mapping: left eye = [36..41], right eye = [42..47]
            for (int i = 36; i <= 41; i++) leftEye.push_back(landmarks[i]);
            for (int i = 42; i <= 47; i++) rightEye.push_back(landmarks[i]);
            double earLeft = computeEAR(leftEye);
            double earRight = computeEAR(rightEye);
            double ear = (earLeft + earRight) / 2.0;

            // Compute MAR for mouth
            vector<dlib::point> mouthPts;
            for (int i = 48; i <= 67; i++) mouthPts.push_back(landmarks[i]);
            double mar = computeMAR(mouthPts);

            // Head pose
            Vec3d rvec, tvec;
            bool poseOK = estimateHeadPose(landmarks, cameraMatrix, distCoeffs, rvec, tvec);
            Vec3d eulerAngles(0,0,0);
            if (poseOK) {
                eulerAngles = rotationVectorToEuler(rvec);
            }

            // ----- State logic -----
            // Drowsiness: eyes closed for more than threshold
            if (ear < EAR_THRESHOLD) {
                eyeClosedFrames++;
            } else {
                eyeClosedFrames = 0;
            }

            // Yawning: mouth open for more than threshold
            if (mar > MAR_THRESHOLD) {
                mouthOpenFrames++;
            } else {
                mouthOpenFrames = 0;
            }

            // Determine state
            if (eyeClosedFrames >= EAR_CONSEC_FRAMES) {
                currentState = STATE_DROWSY;
            } else if (mouthOpenFrames >= MAR_CONSEC_FRAMES) {
                currentState = STATE_YAWNING;
            } else if (poseOK && eulerAngles[1] < YAW_LEFT_THRESHOLD) {
                currentState = STATE_HEAD_LEFT;
            } else if (poseOK && eulerAngles[1] > YAW_RIGHT_THRESHOLD) {
                currentState = STATE_HEAD_RIGHT;
            } else {
                currentState = STATE_OK;
            }

            // ----- Visual feedback -----
            // Draw face rectangle
            rectangle(procMat, faceRect, Scalar(255, 0, 0), 2);

            // Draw landmarks
            for (auto &pt : landmarks) {
                circle(procMat, Point(pt.x(), pt.y()), 2, Scalar(0, 255, 0), -1);
            }

            // Display EAR, MAR, pose
            string info = format("EAR: %.2f MAR: %.2f", ear, mar);
            putText(procMat, info, Point(10, 30), FONT_HERSHEY_SIMPLEX, 0.7, Scalar(0,255,255), 2);

            if (poseOK) {
                string poseStr = format("Yaw: %.1f Pitch: %.1f Roll: %.1f",
                    eulerAngles[1], eulerAngles[0], eulerAngles[2]);
                putText(procMat, poseStr, Point(10, 60), FONT_HERSHEY_SIMPLEX, 0.7, Scalar(0,255,255), 2);
            }

            // Display state
            string stateMsg;
            switch (currentState) {
                case STATE_NO_FACE: stateMsg = "No Face"; break;
                case STATE_OK: stateMsg = "Driver OK"; break;
                case STATE_DROWSY: stateMsg = "DROWSY!"; break;
                case STATE_YAWNING: stateMsg = "YAWNING!"; break;
                case STATE_HEAD_LEFT: stateMsg = "LOOKING LEFT"; break;
                case STATE_HEAD_RIGHT: stateMsg = "LOOKING RIGHT"; break;
            }
            putText(procMat, stateMsg, Point(10, 100), FONT_HERSHEY_SIMPLEX, 1.0,
                    (currentState == STATE_OK ? Scalar(0,255,0) : Scalar(0,0,255)), 2);

        } // end if face detected

        if (ENABLE_TIMESTAMPS) {
            auto ts2 = chrono::steady_clock::now();
            long long ms2 = chrono::duration_cast<chrono::milliseconds>(ts2.time_since_epoch()).count();
            cout << "[TS_PROCESS " << frameId << " " << ms2 << " state=" << currentState << "]" << endl;
        }

        imshow("Driver Monitor", procMat);
        int key = waitKey(1);
        if (key == 27) break;
    }

    destroyAllWindows();
}

// -------------------- Main --------------------
int main(int argc, char** argv) {
    signal(SIGINT, handleSig);
    signal(SIGTERM, handleSig);

    latestRGB.resize(PROC_W * PROC_H * 3);

    thread cap(captureThread, "/dev/video0");
    thread det(detectThread);

    cap.join();
    det.join();

    return 0;
}

