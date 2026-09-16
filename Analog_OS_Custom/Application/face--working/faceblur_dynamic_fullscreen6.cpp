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
#include <thread>
#include <atomic>
#include <mutex>
#include <vector>
#include <opencv2/opencv.hpp>

struct Buffer {
    void* start;
    size_t length;
};

// Global state
std::atomic<bool> running(true);
cv::Mat latestFrame;
std::mutex frameMutex;

void xioctl(int fd, int request, void* arg) {
    int r;
    do {
        r = ioctl(fd, request, arg);
    } while (r == -1 && (errno == EINTR || errno == EAGAIN));
    if (r == -1) {
        perror("ioctl");
        exit(EXIT_FAILURE);
    }
}

void configureCamera() {
    system("v4l2-ctl -v width=640,height=480,pixelformat=RGGB");
    system("media-ctl -d \"platform:fe801000.csi\" "
           "--set-v4l2 '\"max96717:0 23-0040\":0[fmt:SRGGB8_1X8/640x480 field:none]'");
    system("media-ctl -d \"platform:fe801000.csi\" "
           "--set-v4l2 '\"max96724:0 10-0027\":0[fmt:SRGGB8_1X8/640x480 field:none]'");
    system("media-ctl -d \"platform:fe801000.csi\" "
           "--set-v4l2 '\"imx219 24-0010\":0[fmt:SRGGB8_1X8/640x480 field:none]'");

    const char* sensorSubdev = "/dev/v4l-subdev2";
    std::string cmd;
    cmd = std::string("v4l2-ctl -d ") + sensorSubdev + " --set-ctrl=exposure=2500";
    system(cmd.c_str());
    cmd = std::string("v4l2-ctl -d ") + sensorSubdev + " --set-ctrl=analogue_gain=150";
    system(cmd.c_str());
    cmd = std::string("v4l2-ctl -d ") + sensorSubdev + " --set-ctrl=digital_gain=2000";
    system(cmd.c_str());
}

// Convert Bayer RGGB to RGB and enhance
void unpackBayer8ToRGB(const void* src, void* dst, int width, int height) {
    cv::Mat raw8(height, width, CV_8UC1, const_cast<void*>(src));
    cv::Mat rgb;
    cv::cvtColor(raw8, rgb, cv::COLOR_BayerRG2RGB);

    // Color balancing
    std::vector<cv::Mat> ch(3);
    cv::split(rgb, ch);
    ch[0] *= 1.7; // blue
    ch[1] *= 1.0; // green
    ch[2] *= 1.5; // red
    cv::merge(ch, rgb);

    // Brightness, contrast & gamma
    cv::Mat corrected;
    cv::convertScaleAbs(rgb, corrected, 1.25, 5);
    corrected.convertTo(corrected, CV_32F, 1.0 / 255.0);
    cv::pow(corrected, 1.15, corrected);
    corrected.convertTo(rgb, CV_8UC3, 255.0);

    memcpy(dst, rgb.data, width * height * 3);
}

// Face detection and blurring
cv::CascadeClassifier face_cascade;

std::vector<cv::Rect> detectFaces(const cv::Mat& gray) {
    if (face_cascade.empty()) {
        if (!face_cascade.load("haarcascade_frontalface_default.xml")) {
            std::cerr << "Error loading Haar cascade file.\n";
            return {};
        }
    }
    std::vector<cv::Rect> faces;
    face_cascade.detectMultiScale(gray, faces, 1.1, 4, 0, cv::Size(30, 30));
    return faces;
}

void blurAndMarkFaces(cv::Mat& frame, const std::vector<cv::Rect>& faces) {
    for (const auto& face : faces) {
        cv::rectangle(frame, face, cv::Scalar(0, 0, 255), 2);
        cv::Mat faceROI = frame(face);
        cv::GaussianBlur(faceROI, faceROI, cv::Size(41, 41), 25);
    }
}

// Capture thread to grab frames in background
void captureThread(const char* devName, int width, int height) {
    int fd = open(devName, O_RDWR | O_NONBLOCK);
    if (fd < 0) {
        perror("Cannot open video device");
        return;
    }

    v4l2_format fmt{};
    fmt.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    fmt.fmt.pix.width = width;
    fmt.fmt.pix.height = height;
    fmt.fmt.pix.pixelformat = v4l2_fourcc('R', 'G', 'G', 'B');
    fmt.fmt.pix.field = V4L2_FIELD_NONE;
    xioctl(fd, VIDIOC_S_FMT, &fmt);

    v4l2_requestbuffers req{};
    req.count = 4;
    req.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    req.memory = V4L2_MEMORY_MMAP;
    xioctl(fd, VIDIOC_REQBUFS, &req);

    std::vector<Buffer> buffers(req.count);
    for (unsigned i = 0; i < req.count; i++) {
        v4l2_buffer buf{};
        buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
        buf.memory = V4L2_MEMORY_MMAP;
        buf.index = i;
        xioctl(fd, VIDIOC_QUERYBUF, &buf);
        buffers[i].length = buf.length;
        buffers[i].start = mmap(NULL, buf.length, PROT_READ | PROT_WRITE, MAP_SHARED, fd, buf.m.offset);
        xioctl(fd, VIDIOC_QBUF, &buf);
    }

    v4l2_buf_type type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    xioctl(fd, VIDIOC_STREAMON, &type);

    std::vector<unsigned char> rgbBuffer(width * height * 3);

    while (running) {
        fd_set fds;
        FD_ZERO(&fds);
        FD_SET(fd, &fds);
        timeval tv = {0, 20000}; // 20ms timeout
        int r = select(fd + 1, &fds, NULL, NULL, &tv);
        if (r <= 0) continue;

        v4l2_buffer buf{};
        buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
        buf.memory = V4L2_MEMORY_MMAP;
        xioctl(fd, VIDIOC_DQBUF, &buf);

        unpackBayer8ToRGB(buffers[buf.index].start, rgbBuffer.data(), width, height);
        cv::Mat frame(height, width, CV_8UC3, rgbBuffer.data());

        {
            std::lock_guard<std::mutex> lock(frameMutex);
            frame.copyTo(latestFrame);
        }

        xioctl(fd, VIDIOC_QBUF, &buf);
    }

    xioctl(fd, VIDIOC_STREAMOFF, &type);
    for (auto& b : buffers) munmap(b.start, b.length);
    close(fd);
}

int main() {
    const char* devName = "/dev/video0";
    const int width = 640;
    const int height = 480;

    configureCamera();
    std::thread capture(captureThread, devName, width, height);

    cv::namedWindow("Face Blur", cv::WINDOW_NORMAL);
    cv::resizeWindow("Face Blur", width, height);

    cv::Mat displayFrame;

    while (running) {
        cv::Mat frameCopy;
        {
            std::lock_guard<std::mutex> lock(frameMutex);
            if (latestFrame.empty()) continue;
            frameCopy = latestFrame.clone();
        }

        cv::Mat gray;
        cv::cvtColor(frameCopy, gray, cv::COLOR_BGR2GRAY);
        auto faces = detectFaces(gray);
        blurAndMarkFaces(frameCopy, faces);

        // Dynamically resize to current window dimensions
        int winWidth = cv::getWindowImageRect("Face Blur").width;
        int winHeight = cv::getWindowImageRect("Face Blur").height;
        if (winWidth > 0 && winHeight > 0)
            cv::resize(frameCopy, displayFrame, cv::Size(winWidth, winHeight), 0, 0, cv::INTER_LINEAR);
        else
            displayFrame = frameCopy;

        cv::imshow("Face Blur", displayFrame);

        int key = cv::waitKey(1);
        if (key == 27) running = false; // ESC to exit
    }

    capture.join();
    cv::destroyAllWindows();
    return 0;
}

