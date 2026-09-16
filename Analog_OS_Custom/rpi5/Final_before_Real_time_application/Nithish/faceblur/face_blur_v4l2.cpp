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

#include <opencv2/opencv.hpp>

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

// Convert Bayer to RGB with simple enhancement
void unpackBayer8ToRGB(const void* src, void* dst, int width, int height) {
    cv::Mat raw8(height, width, CV_8UC1, const_cast<void*>(src));
    cv::Mat rgb;
    cv::cvtColor(raw8, rgb, cv::COLOR_BayerRG2RGB);

    // --- Simple color balance ---
    std::vector<cv::Mat> channels(3);
    cv::split(rgb, channels);
    double redGain = 1.3, greenGain = 1.0, blueGain = 1.6;
    channels[0] *= blueGain;
    channels[1] *= greenGain;
    channels[2] *= redGain;
    cv::merge(channels, rgb);

    // --- Gamma correction and contrast ---
    cv::Mat balanced;
    cv::convertScaleAbs(rgb, balanced, 1.2, 10);
    cv::Mat gamma;
    balanced.convertTo(gamma, CV_32F, 1.0 / 255.0);
    cv::pow(gamma, 1.2, gamma);
    gamma.convertTo(rgb, CV_8UC3, 255.0);

    memcpy(dst, rgb.data, width * height * 3);
}

bool fileExists(const std::string& path) {
    std::ifstream f(path);
    return f.good();
}

int main() {
    signal(SIGINT, handleSig);
    signal(SIGTERM, handleSig);

    const char* devName = "/dev/video0";
    const int width = 1920, height = 1080;

    int fd = open(devName, O_RDWR | O_NONBLOCK);
    if(fd < 0) { perror("Cannot open device"); return 1; }

    // --- Configure camera ---
    v4l2_format fmt{};
    fmt.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    fmt.fmt.pix.width = width;
    fmt.fmt.pix.height = height;
    fmt.fmt.pix.pixelformat = V4L2_PIX_FMT_SRGGB8;
    fmt.fmt.pix.field = V4L2_FIELD_NONE;
    xioctl(fd, VIDIOC_S_FMT, &fmt);

    // --- Request buffers ---
    v4l2_requestbuffers req{};
    req.count = 4;
    req.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    req.memory = V4L2_MEMORY_MMAP;
    xioctl(fd, VIDIOC_REQBUFS, &req);
    if(req.count < 2) { std::cerr << "Insufficient buffers\n"; close(fd); return 1; }

    std::vector<Buffer> buffers(req.count);
    for(unsigned i=0;i<(unsigned)req.count;i++) {
        v4l2_buffer buf{};
        buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
        buf.memory = V4L2_MEMORY_MMAP;
        buf.index = i;
        xioctl(fd, VIDIOC_QUERYBUF, &buf);
        buffers[i].length = buf.length;
        buffers[i].start = mmap(NULL, buf.length, PROT_READ|PROT_WRITE, MAP_SHARED, fd, buf.m.offset);
        if(buffers[i].start==MAP_FAILED) { perror("mmap"); close(fd); return 1; }
    }

    for(unsigned i=0;i<(unsigned)req.count;i++) {
        v4l2_buffer buf{};
        buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
        buf.memory = V4L2_MEMORY_MMAP;
        buf.index = i;
        xioctl(fd, VIDIOC_QBUF, &buf);
    }

    v4l2_buf_type type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    xioctl(fd, VIDIOC_STREAMON, &type);

    // --- Load face detection model ---
    const std::string faceCascadePath = "haarcascade_frontalface_default.xml";
    if(!fileExists(faceCascadePath)) {
        std::cerr << "Face cascade model missing: " << faceCascadePath << std::endl;
        xioctl(fd, VIDIOC_STREAMOFF, &type);
        close(fd);
        return -1;
    }

    cv::CascadeClassifier face_cascade;
    face_cascade.load(faceCascadePath);

    cv::Mat frame(height,width,CV_8UC3), gray(height,width,CV_8UC1);
    cv::namedWindow("Face Blur", cv::WINDOW_NORMAL);
    cv::resizeWindow("Face Blur",1280,720);

    auto lastTime = std::chrono::steady_clock::now();
    int frameCounter = 0;
    double fps = 0.0;

    while(!stopRequested) {
        fd_set fds;
        FD_ZERO(&fds);
        FD_SET(fd,&fds);
        timeval tv={0,5000}; // 5ms wait
        int r=select(fd+1,&fds,NULL,NULL,&tv);
        if(r<0){ if(errno==EINTR) continue; perror("select"); break; }
        if(r==0) continue;

        v4l2_buffer buf{};
        buf.type=V4L2_BUF_TYPE_VIDEO_CAPTURE;
        buf.memory=V4L2_MEMORY_MMAP;
        xioctl(fd, VIDIOC_DQBUF, &buf);

        unpackBayer8ToRGB(buffers[buf.index].start, frame.data, width, height);
        cv::cvtColor(frame, gray, cv::COLOR_BGR2GRAY);

        std::vector<cv::Rect> faces;
        face_cascade.detectMultiScale(gray, faces, 1.1, 3, 0, cv::Size(80,80));

        std::string status;
        if(!faces.empty()) {
            for(const auto& face : faces) {
                // --- Blur each face region ---
                cv::Mat roi = frame(face);
                cv::GaussianBlur(roi, roi, cv::Size(55,55), 30);
                cv::rectangle(frame, face, cv::Scalar(0,255,0), 2);
            }
            status = "Faces Blurred: " + std::to_string(faces.size());
        } else {
            status = "No Face Detected";
        }

        // FPS
        frameCounter++;
        auto now = std::chrono::steady_clock::now();
        double elapsed = std::chrono::duration_cast<std::chrono::duration<double>>(now - lastTime).count();
        if(elapsed >= 1.0) {
            fps = frameCounter / elapsed;
            frameCounter = 0;
            lastTime = now;
        }

        cv::putText(frame, status, cv::Point(10,30), cv::FONT_HERSHEY_SIMPLEX, 0.9, cv::Scalar(0,0,255), 2);
        char fpsbuf[64]; snprintf(fpsbuf,sizeof(fpsbuf),"FPS: %.1f", fps);
        cv::putText(frame, fpsbuf, cv::Point(10,frame.rows-20), cv::FONT_HERSHEY_SIMPLEX, 0.7, cv::Scalar(0,255,255), 2);

        cv::imshow("Face Blur", frame);

        xioctl(fd, VIDIOC_QBUF, &buf);
        int key=cv::waitKey(1);
        if(key==27) break; // ESC
    }

    xioctl(fd, VIDIOC_STREAMOFF, &type);
    for(auto &b:buffers) munmap(b.start,b.length);
    close(fd);
    cv::destroyAllWindows();
    return 0;
}

