// face_blur_drowsiness.cpp
// Based on your provided file with added drowsiness/yawning/left-right detection
// Keep all original capture/colour/resolution/blur logic unchanged except added diagnostics

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
#include <opencv2/objdetect.hpp>

using namespace std;
using namespace cv;

// ------------------------- CONFIG (tweak here) -------------------------
constexpr int CAP_W = 1920;
constexpr int CAP_H = 1080;
constexpr int PROC_W = 1280; // processing (detection) width
constexpr int PROC_H = 720;  // processing (detection) height

// A - Box blur (true = use box blur instead of Gaussian)
constexpr bool USE_BOX_BLUR = true;

// B - YuNet input size (choose 256 or 320). Using 256 for speed.
constexpr int YUNET_SIDE = 256;

// C - Haar fallback usage
constexpr bool USE_HAAR = false; // set true if you want Haar fallback

// D - Preallocation & reuse (already implemented)
constexpr bool REUSE_MATS = true;

// E - OpenCV internal threads
constexpr int OPENCV_THREADS = 2;

// F - Timestamp logging
constexpr bool ENABLE_TIMESTAMPS = true;

// V4L2 req buffers
constexpr int V4L2_REQ_COUNT = 1; // you can set 1 or 2 (1 = lowest latency)

// Model / files
const string YUNET_MODEL = "./face_detector/face_detection_yunet_2023mar.onnx";
const string HAAR_FILE = "./face_detector/haarcascade_frontalface_default.xml";

// ------------------------- Globals -------------------------
struct Buffer { void* start; size_t length; };
static atomic<bool> running(true);

static mutex frameMutex;
static condition_variable frameCond;

// preallocated storage for PROC-sized RGB (single buffer reused)
static vector<unsigned char> latestRGB; // size = PROC_W * PROC_H * 3
static bool frameReady = false;
static atomic<uint64_t> latestFrameId{0}; // incremented by capture, read by detect

// ------------------------- Utilities -------------------------
bool fileExists(const string &p){ ifstream f(p); return f.good(); }
void handleSig(int){ running = false; frameCond.notify_all(); }

void xioctl(int fd, int request, void* arg){
    int r;
    do { r = ioctl(fd, request, arg); }
    while (r == -1 && (errno == EINTR || errno == EAGAIN));
    if (r == -1) { perror("ioctl"); exit(EXIT_FAILURE); }
}

// ------------------------- Color conversion (full demosaic, no color change) -------------------------
// Unpack 1080p Bayer -> RGB 1080p, then caller should resize to PROC
void unpackBayer8ToRGB_Full(const void* src, void* dst, int w, int h) {
    Mat raw8(h, w, CV_8UC1, const_cast<void*>(src));
    Mat rgb;
    cvtColor(raw8, rgb, COLOR_BayerRG2RGB); // RGB ordering

    // Color gains (your tuning)
    vector<Mat> ch(3);
    split(rgb, ch);
    double redGain = 1.3, greenGain = 1.0, blueGain = 1.6;
    ch[0] *= blueGain;
    ch[1] *= greenGain;
    ch[2] *= redGain;
    merge(ch, rgb);

    // contrast & gamma
    Mat balanced;
    convertScaleAbs(rgb, balanced, 1.2, 10);
    Mat gammaMat;
    balanced.convertTo(gammaMat, CV_32F, 1.0/255.0);
    pow(gammaMat, 1.2, gammaMat);
    gammaMat.convertTo(rgb, CV_8UC3, 255.0);

    // copy rgb data (w*h*3)
    memcpy(dst, rgb.data, w * h * 3);
}

// ------------------------- Capture thread (V4L2) -------------------------
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

    // allocate two buffers: full RGB (1080p) and proc-sized RGB (PROC_W x PROC_H)
    vector<unsigned char> rgbFull(CAP_W * CAP_H * 3);
    latestRGB.resize(PROC_W * PROC_H * 3); // preallocate global

    while(running){
        fd_set fds; FD_ZERO(&fds); FD_SET(fd, &fds);
        timeval tv{0, 5000}; // 5ms
        int s = select(fd+1, &fds, NULL, NULL, &tv);
        if(s < 0){ if(errno==EINTR) continue; perror("select"); break; }
        if(s == 0) continue;

        v4l2_buffer b{}; b.type = type; b.memory = V4L2_MEMORY_MMAP;
        if(ioctl(fd, VIDIOC_DQBUF, &b) == 0){
            // 1) demosaic the full raw -> rgbFull (1080p)
            unpackBayer8ToRGB_Full(bufs[b.index].start, rgbFull.data(), CAP_W, CAP_H);

            // 2) resize RGB1080 -> PROC (cheap, 3-channel)
            Mat rgbFullMat(CAP_H, CAP_W, CV_8UC3, rgbFull.data());
            Mat rgbProcMat(PROC_H, PROC_W, CV_8UC3, latestRGB.data()); // wrap destination
            resize(rgbFullMat, rgbProcMat, Size(PROC_W, PROC_H), 0, 0, INTER_NEAREST);

            // 3) publish without realloc
            {
                unique_lock<mutex> lk(frameMutex);
                frameReady = true;
                // bump frame id
                uint64_t id = ++latestFrameId;
                (void)id;
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

    // cleanup
    xioctl(fd, VIDIOC_STREAMOFF, &type);
    for(auto &bb : bufs) munmap(bb.start, bb.length);
    close(fd);
}

// ------------------------- Simple NMS (fallback) -------------------------
vector<int> simpleNMS(const vector<Rect>& boxes, const vector<float>& scores, float iouThresh){
    vector<int> idx(boxes.size()); iota(idx.begin(), idx.end(), 0);
    sort(idx.begin(), idx.end(), [&](int a, int b){ return scores[a] > scores[b]; });
    vector<int> keep; vector<char> suppressed(boxes.size(), 0);
    for(size_t _i=0; _i<idx.size(); ++_i){
        int i = idx[_i]; if(suppressed[i]) continue;
        keep.push_back(i);
        for(size_t _j=_i+1; _j<idx.size(); ++_j){
            int j = idx[_j]; if(suppressed[j]) continue;
            float inter = (boxes[i] & boxes[j]).area();
            float uni = boxes[i].area() + boxes[j].area() - inter; if(uni<=0) continue;
            if((inter/uni) > iouThresh) suppressed[j] = 1;
        }
    }
    return keep;
}

// ------------------------- Drowsiness / Yawn / Orientation helpers -------------------------
// Heuristic thresholds (tune these on your setup)
constexpr int EYE_ROI_HALF = 14;         // half-size of square around eye landmark (px)
constexpr double EYE_EDGE_LOW = 0.06;    // when normalized edge density < this -> likely closed
constexpr int EYE_CONSEC_FRAMES = 12;    // frames eyes must be low to trigger drowsy
constexpr int SLEEP_CONSEC_FRAMES = 150; // frames to consider "sleeping" (long closed)

// yawning: analyze vertical dark gap in mouth box
constexpr double YAWN_VERT_RATIO = 0.28; // fraction of mouth box height that must be dark to count as yawning
constexpr int YAWN_CONSEC_FRAMES = 6;

// head turn thresholds (fraction of bbox width)
constexpr double TURN_THRESH = 0.18; // if nose offset from bbox center > this*width => turned

// maintain counters
static int eye_low_count = 0;
static int sleep_count = 0;
static int yawn_count = 0;
static int face_turn_state = 0; // -1 left, 0 center, +1 right

// compute normalized edge density in a gray ROI (Canny)
double computeEdgeDensity(const Mat &grayROI){
    if(grayROI.empty()) return 1.0;
    Mat edges;
    Canny(grayROI, edges, 50, 150);
    int edgePixels = countNonZero(edges);
    double area = grayROI.rows * grayROI.cols;
    if(area <= 0) return 0.0;
    return (double)edgePixels / area;
}

// compute mouth vertical darkness fraction: threshold image, count tall dark vertical stripe area
double computeMouthDarkFrac(const Mat &roi){
    if(roi.empty()) return 0.0;
    Mat gray; cvtColor(roi, gray, COLOR_BGR2GRAY);
    // adaptive threshold to compensate lighting
    Mat th;
    adaptiveThreshold(gray, th, 255, ADAPTIVE_THRESH_MEAN_C, THRESH_BINARY_INV, 11, 7);
    // we look for vertical dark area (black after inv-threshold)
    int dark = countNonZero(th);
    double area = th.rows * th.cols;
    if(area <= 0) return 0.0;
    return (double)dark / area;
}

// ------------------------- Detection + blur thread -------------------------
void detectThread(){
    // limit OpenCV threads
    cv::setNumThreads(OPENCV_THREADS);

    const Size procSz(PROC_W, PROC_H);
    const Size yunSz(YUNET_SIDE, YUNET_SIDE);

    if(!fileExists(YUNET_MODEL)){
        cerr << "[ERROR] YuNet model missing: " << YUNET_MODEL << endl;
        running = false; frameCond.notify_all(); return;
    }

    Ptr<FaceDetectorYN> yunet = FaceDetectorYN::create(YUNET_MODEL, "", yunSz, 0.45, 0.3, 5000);
    yunet->setInputSize(yunSz);

    CascadeClassifier haar;
    bool haveHaar = false;
    if(USE_HAAR && fileExists(HAAR_FILE)){
        haveHaar = haar.load(HAAR_FILE);
        if(!haveHaar) cerr << "[WARN] Haar cascade exists but failed to load: " << HAAR_FILE << endl;
    }

    namedWindow("Face Blur", WINDOW_NORMAL);
    resizeWindow("Face Blur", 960, 720);

    // preallocate Mats to avoid repeated allocations
    Mat procMat(PROC_H, PROC_W, CV_8UC3);          // target for processing
    Mat yunInMat(yunSz.height, yunSz.width, CV_8UC3); // dnn input mat
    Mat grayMat; // for Haar if enabled

    // text overlay params
    int baseLine=0;
    const int FONT = FONT_HERSHEY_SIMPLEX;

    while(running){
        {
            unique_lock<mutex> lk(frameMutex);
            frameCond.wait(lk, []{ return frameReady || !running; });
            if(!running) break;
            frameReady = false;
        }

        // wrap the latestRGB buffer in a Mat (no copy)
        {
            Mat wrap(PROC_H, PROC_W, CV_8UC3, latestRGB.data());
            wrap.copyTo(procMat); // operate on local copy to avoid race with capture writing
        }

        // timestamp read for this frame
        uint64_t frameId = latestFrameId.load();

        // YuNet inference
        resize(procMat, yunInMat, yunSz, 0, 0, INTER_LINEAR);
        yunet->setInputSize(yunSz);
        Mat dets; yunet->detect(yunInMat, dets);

        vector<Rect> boxes; vector<float> scores;
        // YuNet format: x, y, w, h, rx,ry, lx,ly, nx,ny, rmouthx,rmouthy, lmouthx,lmouthy, score (15 columns)
        for(int i=0;i<dets.rows;i++){
            float conf = dets.at<float>(i,14); // confidence at last column
            if(conf < 0.35f) continue;
            float x = dets.at<float>(i,0) * procSz.width / yunSz.width;
            float y = dets.at<float>(i,1) * procSz.height / yunSz.height;
            float w = dets.at<float>(i,2) * procSz.width / yunSz.width;
            float h = dets.at<float>(i,3) * procSz.height / yunSz.height;
            Rect r(cvRound(x), cvRound(y), cvRound(w), cvRound(h));
            r &= Rect(0,0,procSz.width, procSz.height);
            if(r.area()<=0) continue;
            boxes.push_back(r); scores.push_back(conf);
        }

        // optional Haar fallback
        if(haveHaar){
            cvtColor(procMat, grayMat, COLOR_BGR2GRAY);
            vector<Rect> hf; haar.detectMultiScale(grayMat, hf, 1.05, 3, 0, Size(30,30));
            for(auto &r: hf){ boxes.push_back(r); scores.push_back(0.45f); }
        }

        // NMS (try OpenCV NMSBoxes first)
        vector<int> keepIdx;
        if(!boxes.empty()){
            try{
                dnn::NMSBoxes(boxes, scores, 0.3f, 0.45f, keepIdx, 1.f, 100);
            } catch(...){
                // fallback
                keepIdx = simpleNMS(boxes, scores, 0.45f);
            }
        }

        // For driver status text
        string driverStatus = "Driver OK";
        Scalar statusColor = Scalar(0,200,0);

        // Apply blur to kept boxes and run heuristics
        if(!keepIdx.empty()){
            // We'll process the largest face (closest) as the driver
            int best = keepIdx[0];
            int bestArea = boxes[best].area();
            for(int id : keepIdx){ if(boxes[id].area() > bestArea){ best = id; bestArea = boxes[id].area(); } }

            // find corresponding row in dets to read landmarks (match by IoU or bbox center close)
            // Simpler: re-run yunet to get per-face row mapping (we have dets rows parallell to boxes earlier).
            // For robustness, we will search dets for a detection whose bbox (scaled to proc) intersects best bbox significantly.
            int detRowIndex = -1;
            for(int i=0;i<dets.rows;i++){
                float x0 = dets.at<float>(i,0) * procSz.width / yunSz.width;
                float y0 = dets.at<float>(i,1) * procSz.height / yunSz.height;
                float w0 = dets.at<float>(i,2) * procSz.width / yunSz.width;
                float h0 = dets.at<float>(i,3) * procSz.height / yunSz.height;
                Rect r0(cvRound(x0), cvRound(y0), cvRound(w0), cvRound(h0));
                r0 &= Rect(0,0,procSz.width, procSz.height);
                if((r0 & boxes[best]).area() * 2 >= min(r0.area(), boxes[best].area())){ detRowIndex = i; break; }
            }
            // fallback: pick first
            if(detRowIndex < 0) detRowIndex = 0;

            // read landmarks (scaled to proc)
            int i = detRowIndex;
            // Ensure dets has at least 15 columns
            vector<Point2f> lm(5, Point2f(-1,-1));
            if(dets.cols >= 15 && i < dets.rows){
                lm[0].x = dets.at<float>(i,4)  * procSz.width / yunSz.width; // right eye? depending on format
                lm[0].y = dets.at<float>(i,5)  * procSz.height / yunSz.height;
                lm[1].x = dets.at<float>(i,6)  * procSz.width / yunSz.width; // left eye
                lm[1].y = dets.at<float>(i,7)  * procSz.height / yunSz.height;
                lm[2].x = dets.at<float>(i,8)  * procSz.width / yunSz.width; // nose
                lm[2].y = dets.at<float>(i,9)  * procSz.height / yunSz.height;
                lm[3].x = dets.at<float>(i,10) * procSz.width / yunSz.width; // right mouth corner
                lm[3].y = dets.at<float>(i,11) * procSz.height / yunSz.height;
                lm[4].x = dets.at<float>(i,12) * procSz.width / yunSz.width; // left mouth corner
                lm[4].y = dets.at<float>(i,13) * procSz.height / yunSz.height;
            }

            // Apply blur for ALL kept boxes (original behaviour)
            for(int id : keepIdx){
                Rect r = boxes[id];
                int padX = cvRound(r.width * 0.10f);
                int padY = cvRound(r.height * 0.10f);
                Rect ext(r.x - padX, r.y - padY, r.width + 2*padX, r.height + 2*padY);
                ext &= Rect(0,0,PROC_W, PROC_H);
                if(ext.area() <= 0) continue;

                Mat roi = procMat(ext);
                if(USE_BOX_BLUR){
                    // two-pass box blur (faster and closer to Gaussian)
                    int kx = max(3, (ext.width/10) | 1);
                    int ky = max(3, (ext.height/10) | 1);
                    blur(roi, roi, Size(kx, 1));
                    blur(roi, roi, Size(1, ky));
                } else {
                    int k = max(21, ((ext.width + ext.height)/10) | 1);
                    GaussianBlur(roi, roi, Size(k,k), 0);
                }
                rectangle(procMat, ext, Scalar(0,255,0), 2);
            }

            // --- DRIVER BEHAVIOR ANALYSIS using landmarks & ROIs ---
            // Eye closure heuristic: compute edge density in small eye boxes around landmarks
            double leftEyeEdge = 1.0, rightEyeEdge = 1.0;
            if(lm[0].x >= 0 && lm[0].y >= 0){
                int ex = cvRound(lm[0].x), ey = cvRound(lm[0].y);
                int x0 = max(0, ex - EYE_ROI_HALF), y0 = max(0, ey - EYE_ROI_HALF);
                int x1 = min(PROC_W, ex + EYE_ROI_HALF), y1 = min(PROC_H, ey + EYE_ROI_HALF);
                Rect er(x0,y0, x1-x0, y1-y0);
                if(er.area() > 10){
                    Mat ero = procMat(er);
                    Mat g; cvtColor(ero, g, COLOR_BGR2GRAY);
                    rightEyeEdge = computeEdgeDensity(g);
                    rectangle(procMat, er, Scalar(255,128,0), 1);
                }
            }
            if(lm[1].x >= 0 && lm[1].y >= 0){
                int ex = cvRound(lm[1].x), ey = cvRound(lm[1].y);
                int x0 = max(0, ex - EYE_ROI_HALF), y0 = max(0, ey - EYE_ROI_HALF);
                int x1 = min(PROC_W, ex + EYE_ROI_HALF), y1 = min(PROC_H, ey + EYE_ROI_HALF);
                Rect el(x0,y0, x1-x0, y1-y0);
                if(el.area() > 10){
                    Mat elo = procMat(el);
                    Mat g; cvtColor(elo, g, COLOR_BGR2GRAY);
                    leftEyeEdge = computeEdgeDensity(g);
                    rectangle(procMat, el, Scalar(255,128,0), 1);
                }
            }

            // Combine both eye edge metrics (we expect open eyes -> higher edge density)
            double eyeMeanEdge = (leftEyeEdge + rightEyeEdge) * 0.5;

            // Drowsiness counters
            if(eyeMeanEdge < EYE_EDGE_LOW){
                eye_low_count++;
                sleep_count++;
            } else {
                eye_low_count = max(0, eye_low_count - 1);
                sleep_count = max(0, sleep_count - 1);
            }

            // Yawn detection using mouth ROI (area between mouth corners and below nose)
            double mouthDarkFrac = 0.0;
            if(lm[3].x >= 0 && lm[4].x >= 0 && lm[2].x >= 0){
                // mouth bbox: between left & right mouth corners, height from nose down to a little below mouth
                int mx0 = cvRound(min(lm[3].x, lm[4].x));
                int mx1 = cvRound(max(lm[3].x, lm[4].x));
                int my0 = cvRound(min(lm[3].y, lm[4].y));
                int my1 = my0 + cvRound((lm[3].y + lm[4].y)/2.0 - lm[2].y + 30); // extend a bit below
                // clamp
                mx0 = max(0, mx0-4);
                mx1 = min(PROC_W-1, mx1+4);
                my0 = max(0, my0-6);
                my1 = min(PROC_H-1, my1+20);
                if(mx1 > mx0 && my1 > my0){
                    Rect mR(mx0, my0, mx1-mx0, my1-my0);
                    Mat mroi = procMat(mR);
                    mouthDarkFrac = computeMouthDarkFrac(mroi);
                    rectangle(procMat, mR, Scalar(0,128,255), 1);
                }
            }

            if(mouthDarkFrac > YAWN_VERT_RATIO) {
                yawn_count++;
            } else {
                yawn_count = max(0, yawn_count - 1);
            }

            // Face left/right detection using nose x relative to face bbox center
            int turn = 0; // -1 left, 0 center, +1 right
            {
                Rect bb = boxes[best];
                double cx = bb.x + bb.width*0.5;
                if(lm[2].x >= 0){
                    double nx = lm[2].x;
                    double dx = (nx - cx) / double(bb.width);
                    if(dx < -TURN_THRESH) turn = -1;
                    else if(dx > TURN_THRESH) turn = +1;
                    else turn = 0;
                }
            }

            // update face_turn_state with hysteresis
            if(turn != 0){
                face_turn_state = turn;
            } else {
                // slowly relax to 0
                // do nothing - keep last state until stable center detected for many frames
            }

            // Decide driverStatus with priorities: Sleeping > Drowsy > Yawning > Turned > OK
            if(sleep_count >= SLEEP_CONSEC_FRAMES){
                driverStatus = "Driver SLEEPING";
                statusColor = Scalar(0,0,255);
            } else if(eye_low_count >= EYE_CONSEC_FRAMES){
                driverStatus = "Driver DROWSY";
                statusColor = Scalar(0,140,255);
            } else if(yawn_count >= YAWN_CONSEC_FRAMES){
                driverStatus = "Driver YAWNING";
                statusColor = Scalar(0,200,200);
            } else {
                // face turn detection overlay
                if(face_turn_state == -1) { driverStatus = "Driver TURNED LEFT"; statusColor = Scalar(0,200,200); }
                else if(face_turn_state == 1) { driverStatus = "Driver TURNED RIGHT"; statusColor = Scalar(0,200,200); }
                else { driverStatus = "Driver OK"; statusColor = Scalar(0,200,0); }
            }

            // small debug prints (console)
            //cout << "eyeEdge="<<eyeMeanEdge<<" mouthDark="<<mouthDarkFrac<<" eye_low_count="<<eye_low_count<<" yawn_count="<<yawn_count<<endl;
        } // end if any face

        // draw status text on top-left
        int fontScale = 1;
        int thickness = 2;
        Size tsize = getTextSize(driverStatus, FONT, fontScale, thickness, &baseLine);
        Point org(10, 30);
        // background rect for readability
        rectangle(procMat, Rect(org.x-6, org.y - tsize.height - 6, tsize.width+12, tsize.height+12), Scalar(0,0,0), FILLED);
        putText(procMat, driverStatus, org, FONT, fontScale, statusColor, thickness, LINE_AA);

        if(ENABLE_TIMESTAMPS){
            auto ts2 = chrono::steady_clock::now();
            long long ms2 = chrono::duration_cast<chrono::milliseconds>(ts2.time_since_epoch()).count();
            cout << "[TS_DISPLAY " << frameId << " " << ms2 << "]" << endl;
        }

        imshow("Face Blur", procMat);
        if(waitKey(1) == 27) break;
    }
}

// ------------------------- Main -------------------------
int main(int ac, char** av){
    signal(SIGINT, handleSig);
    signal(SIGTERM, handleSig);

    if(!fileExists(YUNET_MODEL)){
        cerr << "[ERROR] Missing Yunet model at " << YUNET_MODEL << endl;
        return -1;
    }

    if(!fileExists(HAAR_FILE) && USE_HAAR){
        cerr << "[WARN] Haar cascade not found at " << HAAR_FILE << " (will skip Haar)" << endl;
    }

    // ensure global buffer sized
    latestRGB.resize(PROC_W * PROC_H * 3);

    // Start capture & detect threads
    const char* dev = "/dev/video0";

    thread cap(captureThread, dev);
    thread det(detectThread);

    cap.join();
    det.join();
    return 0;
}
