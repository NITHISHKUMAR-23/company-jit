// drowsiness_yawn_only_v4.cpp
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
#include <deque>
#include <algorithm>

#include <opencv2/opencv.hpp>
#include <opencv2/face.hpp>
#include <opencv2/dnn.hpp>

using namespace std;
using namespace cv;

// ------------------------------------------------- CONFIG -------------------------------------------------
constexpr int CAP_W = 1920;
constexpr int CAP_H = 1080;
constexpr int PROC_W = 1280;
constexpr int PROC_H = 720;

constexpr int YUNET_SIDE = 256;
constexpr int OPENCV_THREADS = 2;
constexpr int V4L2_REQ_COUNT = 2;

// Models
const string YUNET_MODEL = "./models/face_detection_yunet_2023mar.onnx";
const string LBF_MODEL   = "./models/lbfmodel.yaml";

// ---- Detection thresholds ----
const double EAR_THRESH = 0.23;
const double MAR_THRESH = 0.05;   // ★ Lower because normalized MAR
const double EAR_CLOSED_TIME = 1.2;
const double MAR_YAWN_TIME  = 0.1;

// ---- Calibration & smoothing ----
const double EAR_INIT_FACTOR = 0.72;
const double MAR_INIT_FACTOR = 0.58;

const double EAR_SMOOTH_ALPHA = 0.10;
const double MAR_SMOOTH_ALPHA = 0.25;

const double MIN_EAR = 0.14;
const double MIN_MAR = 0.15;    // ★ Lower because normalized MAR

const int CALIB_FRAMES = 30;
const int MEDIAN_WIN = 3;

// ------------------------------------------------- Globals -------------------------------------------------
struct Buffer { void* start; size_t length; };

static atomic<bool> running(true);
static mutex frameMutex;
static condition_variable frameCond;
static vector<unsigned char> latestRGB;
static bool frameReady = false;

// ------------------------------------------------- Helpers -------------------------------------------------
bool fileExists(const string &p){ ifstream f(p); return f.good(); }
void handleSig(int){ running = false; frameCond.notify_all(); }

void xioctl(int fd, int request, void* arg){
    int r;
    do { r = ioctl(fd, request, arg); }
    while (r == -1 && (errno == EINTR || errno == EAGAIN));
    if (r == -1){ perror("ioctl"); exit(EXIT_FAILURE); }
}

// --- Bayer to RGB ---
void unpackBayer8ToRGB_Full(const void* src, void* dst, int width, int height) {
    Mat raw(height, width, CV_8UC1, const_cast<void*>(src));
    Mat rgb;
    cvtColor(raw, rgb, COLOR_BayerRG2RGB);

    vector<Mat> ch(3);
    split(rgb, ch);
    ch[0] *= 1.6;
    ch[2] *= 1.35;
    merge(ch, rgb);

    convertScaleAbs(rgb, rgb, 1.18, 3);

    Mat gamma;
    rgb.convertTo(gamma, CV_32F, 1.0/255);
    pow(gamma, 1.10, gamma);
    gamma.convertTo(rgb, CV_8UC3, 255.0);

    memcpy(dst, rgb.data, width * height * 3);
}

// ------------------------------------------------- EAR / NORMALIZED MAR -------------------------------------------------
double ear(const vector<Point2f>& e){
    if(e.size()<6) return 0;
    double A = norm(e[1]-e[5]);
    double B = norm(e[2]-e[4]);
    double C = norm(e[0]-e[3]);
    return (A+B) / (2*C + 1e-6);
}

// ★ NEW FIXED NORMALIZED MAR FUNCTION
double mouth_aspect_ratio_normalized(const vector<Point2f>& lm){
    if(lm.size() < 68) return 0.0;

    // vertical mouth distances
    double v1 = norm(lm[61] - lm[67]);
    double v2 = norm(lm[62] - lm[66]);
    double v3 = norm(lm[63] - lm[65]);
    double v = (v1 + v2 + v3) / 3.0;

    // mouth width
    double w = norm(lm[60] - lm[64]) + 1e-6;

    // raw MAR
    double raw = v / w;

    // normalize by face size (nose tip to chin)
    double face_h = norm(lm[33] - lm[8]) + 1e-6;

    return raw * (v / face_h);  // ★ normalized MAR
}

// ------------------------------------------------- Capture Thread -------------------------------------------------
void captureThread(const char* dev){
    int fd = open(dev, O_RDWR | O_NONBLOCK);
    if(fd < 0){ perror("open"); return; }

    v4l2_format fmt{};
    fmt.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    fmt.fmt.pix.width  = CAP_W;
    fmt.fmt.pix.height = CAP_H;
    fmt.fmt.pix.pixelformat = V4L2_PIX_FMT_SRGGB8;
    fmt.fmt.pix.field = V4L2_FIELD_NONE;
    xioctl(fd, VIDIOC_S_FMT, &fmt);

    v4l2_requestbuffers req{};
    req.count = V4L2_REQ_COUNT;
    req.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    req.memory = V4L2_MEMORY_MMAP;
    xioctl(fd, VIDIOC_REQBUFS, &req);

    vector<Buffer> bufs(req.count);
    for(unsigned i=0;i<req.count;i++){
        v4l2_buffer b{}; b.type=req.type; b.memory=req.memory; b.index=i;
        xioctl(fd, VIDIOC_QUERYBUF, &b);
        bufs[i].length=b.length;
        bufs[i].start=mmap(NULL,b.length,PROT_READ|PROT_WRITE,MAP_SHARED,fd,b.m.offset);
        xioctl(fd, VIDIOC_QBUF,&b);
    }

    v4l2_buf_type type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    xioctl(fd, VIDIOC_STREAMON,&type);

    vector<unsigned char> rgb(CAP_W*CAP_H*3);
    latestRGB.resize(PROC_W*PROC_H*3);

    while(running){
        fd_set fds;
        FD_ZERO(&fds);
        FD_SET(fd,&fds);
        timeval tv{0,5000};
        if(select(fd+1,&fds,nullptr,nullptr,&tv) <= 0) continue;

        v4l2_buffer b{}; b.type=type; b.memory=V4L2_MEMORY_MMAP;
        if(ioctl(fd, VIDIOC_DQBUF,&b)==0){
            unpackBayer8ToRGB_Full(bufs[b.index].start, rgb.data(), CAP_W, CAP_H);
            Mat full(CAP_H, CAP_W, CV_8UC3, rgb.data());
            Mat proc(PROC_H, PROC_W, CV_8UC3, latestRGB.data());
            resize(full, proc, Size(PROC_W,PROC_H));
            {
                lock_guard<mutex> lk(frameMutex);
                frameReady=true;
            }
            frameCond.notify_one();
            xioctl(fd, VIDIOC_QBUF,&b);
        }
    }

    xioctl(fd, VIDIOC_STREAMOFF,&type);
    for(auto &b: bufs) munmap(b.start,b.length);
    close(fd);
}

// ------------------------------------------------- Detection Thread -------------------------------------------------
void detectThread(){
    setNumThreads(OPENCV_THREADS);

    Ptr<FaceDetectorYN> yunet =
        FaceDetectorYN::create(YUNET_MODEL, "", Size(YUNET_SIDE,YUNET_SIDE), 0.45, 0.3);

    Ptr<face::Facemark> facemark = face::FacemarkLBF::create();
    facemark->loadModel(LBF_MODEL);

    Mat frame(PROC_H,PROC_W,CV_8UC3);
    Mat yunIn(YUNET_SIDE,YUNET_SIDE,CV_8UC3);
    Mat gray;

    bool earCal=false, marCal=false;
    double eAvg=0,mAvg=0;
    int eCount=0, mCount=0;

    double eThr=EAR_THRESH;
    double mThr=MAR_THRESH;

    deque<double> eWin, mWin;
    double eEMA=0, mEMA=0;

    bool closed=false, yawn=false;
    auto closedStart = chrono::steady_clock::now();
    bool closedStartFlag=false;

    namedWindow("Drowsiness+Yawn",WINDOW_NORMAL);
    resizeWindow("Drowsiness+Yawn",960,540);

    while(running){
        unique_lock<mutex> lk(frameMutex);
        frameCond.wait(lk,[]{return frameReady||!running;});
        if(!running) break;
        memcpy(frame.data, latestRGB.data(), PROC_W*PROC_H*3);
        frameReady=false;
        lk.unlock();

        // ---- Face Detection ----
        resize(frame, yunIn, Size(YUNET_SIDE,YUNET_SIDE));
        yunet->setInputSize(Size(YUNET_SIDE,YUNET_SIDE));

        Mat det;
        yunet->detect(yunIn, det);

        vector<Rect> faces;
        for(int i=0;i<det.rows;i++){
            float c = det.at<float>(i,4);
            if(c < 0.4) continue;
            float x = det.at<float>(i,0) * PROC_W / YUNET_SIDE;
            float y = det.at<float>(i,1) * PROC_H / YUNET_SIDE;
            float w = det.at<float>(i,2) * PROC_W / YUNET_SIDE;
            float h = det.at<float>(i,3) * PROC_H / YUNET_SIDE;
            Rect r(cvRound(x),cvRound(y),cvRound(w),cvRound(h));
            r &= Rect(0,0,PROC_W,PROC_H);
            if(r.area()>0) faces.push_back(r);
        }

        string status = "Driver: OK";
        bool alert = false;
        bool drowsyFlag=false, yawnFlag=false;

        if(!faces.empty()){
            int idx=0;
            for(int i=1;i<faces.size();i++)
                if(faces[i].area()>faces[idx].area()) idx=i;

            Rect f=faces[idx];
            Rect pad=f;
            int px=f.width/8, py=f.height/6;
            pad.x=max(0,f.x-px);
            pad.y=max(0,f.y-py);
            pad.width=min(PROC_W-pad.x, f.width+px*2);
            pad.height=min(PROC_H-pad.y, f.height+py*2);

            Mat roi = frame(pad).clone();
            cvtColor(roi, gray, COLOR_BGR2GRAY);

            vector<vector<Point2f>> L;
            vector<Rect> box={Rect(0,0,roi.cols,roi.rows)};
            bool ok=false;
            try{ ok=facemark->fit(gray,box,L); } catch(...){ ok=false; }

            if(ok && !L.empty()){
                auto lm=L[0];
                for(auto &p:lm){ p.x+=pad.x; p.y+=pad.y; }

                vector<Point2f> LE={lm[36],lm[37],lm[38],lm[39],lm[40],lm[41]};
                vector<Point2f> RE={lm[42],lm[43],lm[44],lm[45],lm[46],lm[47]};
                double eRaw=(ear(LE)+ear(RE))/2.0;

                if(eEMA==0) eEMA=eRaw;
                eEMA = (1-EAR_SMOOTH_ALPHA)*eEMA + EAR_SMOOTH_ALPHA*eRaw;

                eWin.push_back(eEMA);
                if(eWin.size()>MEDIAN_WIN) eWin.pop_front();
                vector<double> tmpE(eWin.begin(),eWin.end());
                sort(tmpE.begin(),tmpE.end());
                double e = tmpE[tmpE.size()/2];

                if(!earCal){
                    if(e>0.05){ eAvg=(eAvg*eCount+e)/(eCount+1); eCount++; }
                    if(eCount>=CALIB_FRAMES){ earCal=true; eThr=max(MIN_EAR, eAvg*EAR_INIT_FACTOR); }
                } else {
                    double t=max(MIN_EAR,eAvg*EAR_INIT_FACTOR);
                    eThr=(1-EAR_SMOOTH_ALPHA)*eThr + EAR_SMOOTH_ALPHA*t;
                }

                // ★ use normalized MAR
                double mRaw = mouth_aspect_ratio_normalized(lm);

                if(mEMA==0) mEMA=mRaw;
                mEMA = (1-MAR_SMOOTH_ALPHA)*mEMA + MAR_SMOOTH_ALPHA*mRaw;

                mWin.push_back(mEMA);
                if(mWin.size()>MEDIAN_WIN) mWin.pop_front();
                vector<double> tmpM(mWin.begin(),mWin.end());
                sort(tmpM.begin(),tmpM.end());
                double m = tmpM[tmpM.size()/2];

                if(!marCal){
                    if(m>0.03){ mAvg=(mAvg*mCount+m)/(mCount+1); mCount++; }
                    if(mCount>=CALIB_FRAMES){ marCal=true; mThr=max(MIN_MAR, mAvg*MAR_INIT_FACTOR); }
                } else {
                    double t=max(MIN_MAR,mAvg*MAR_INIT_FACTOR);
                    mThr=(1-MAR_SMOOTH_ALPHA)*mThr + MAR_SMOOTH_ALPHA*t;
                }
                if(!marCal) mThr = max(mThr,MAR_THRESH);

                // ---------- Drowsiness Logic ----------
                if(e < eThr){
                    if(!closedStartFlag){ closedStartFlag=true; closedStart=chrono::steady_clock::now(); }
                    drowsyFlag=true;
                    if(chrono::duration<double>(chrono::steady_clock::now()-closedStart).count()>=EAR_CLOSED_TIME)
                        closed=true;
                } else { closedStartFlag=false; closed=false; drowsyFlag=false; }

                // ---------- Yawn Logic ----------
                yawnFlag = (m > mThr);
                yawn = yawnFlag;

                if(drowsyFlag && yawnFlag){ status="DROWSINESS + YAWNING"; alert=true; }
                else if(drowsyFlag){ status="DROWSINESS DETECTED"; alert=true; }
                else if(yawnFlag){ status="YAWNING DETECTED"; alert=true; }

                rectangle(frame,pad,alert?Scalar(0,0,255):Scalar(0,255,0),2);
                for(auto&p:lm) circle(frame,p,2,Scalar(255,0,0),-1);

                putText(frame, format("EAR: %.3f  Thr: %.3f", e, eThr),
                        Point(10,30),FONT_HERSHEY_SIMPLEX,0.7,{255,255,0},2);
                putText(frame, format("MAR: %.3f  Thr: %.3f", m, mThr),
                        Point(10,60),FONT_HERSHEY_SIMPLEX,0.7,{255,255,0},2);
                putText(frame, status, Point(10,120),
                        FONT_HERSHEY_SIMPLEX,1.0,
                        alert?Scalar(0,0,255):Scalar(0,200,0),2);
            }
        } else {
            putText(frame, "No Face Detected", Point(10,100),
                    FONT_HERSHEY_SIMPLEX,0.8,{0,255,255},2);
        }

        imshow("Drowsiness+Yawn", frame);

        int k = waitKey(1);
        if(k == 27){ running=false; frameCond.notify_all(); break; }
        this_thread::sleep_for(chrono::milliseconds(5));
    }

    destroyAllWindows();
}

// ------------------------------------------------- MAIN -------------------------------------------------
int main(){
    signal(SIGINT, handleSig);
    signal(SIGTERM, handleSig);

    if(!fileExists(YUNET_MODEL)){ cerr<<"Missing YuNet model\n"; return -1; }
    if(!fileExists(LBF_MODEL)){ cerr<<"Missing LBF model\n"; return -1; }

    latestRGB.resize(PROC_W*PROC_H*3);

    thread cap(captureThread, "/dev/video0");
    thread det(detectThread);

    cap.join();
    det.join();
    return 0;
}

