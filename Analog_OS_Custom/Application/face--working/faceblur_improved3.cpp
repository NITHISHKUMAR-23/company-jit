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
#include <opencv2/opencv.hpp>

struct Buffer {
    void* start;
    size_t length;
};

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

    const char* sensorSubdev = "/dev/v4l-subdev2"; // Update using `media-ctl -p`
    std::string cmd;
    cmd = std::string("v4l2-ctl -d ") + sensorSubdev + " --set-ctrl=exposure=2000";
    system(cmd.c_str());
    cmd = std::string("v4l2-ctl -d ") + sensorSubdev + " --set-ctrl=analogue_gain=100";
    system(cmd.c_str());
    cmd = std::string("v4l2-ctl -d ") + sensorSubdev + " --set-ctrl=digital_gain=1900";
    system(cmd.c_str());
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

cv::CascadeClassifier face_cascade;
std::vector<cv::Rect> detectFaces(const cv::Mat& gray) {
    if (face_cascade.empty()) {
        face_cascade.load("haarcascade_frontalface_default.xml");
    }
    std::vector<cv::Rect> faces;
    face_cascade.detectMultiScale(gray, faces, 1.1, 3, 0, cv::Size(30, 30));
    return faces;
}

void blurAndMarkFaces(unsigned char* rgbBuffer, int width, int height, const std::vector<cv::Rect>& faces) {
    cv::Mat img(height, width, CV_8UC3, rgbBuffer);
    for (const auto& face : faces) {
        cv::rectangle(img, face, cv::Scalar(0, 0, 255), 2);
        cv::Mat faceROI = img(face);
        cv::GaussianBlur(faceROI, faceROI, cv::Size(41, 41), 25);
    }
}

int main() {
    const char* devName = "/dev/video0";
    const int width = 640;
    const int height = 480;

    configureCamera();

    int fd = open(devName, O_RDWR | O_NONBLOCK);
    if (fd < 0) {
        perror("Cannot open device");
        return 1;
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
    }

    for (unsigned i = 0; i < req.count; i++) {
        v4l2_buffer buf{};
        buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
        buf.memory = V4L2_MEMORY_MMAP;
        buf.index = i;
        xioctl(fd, VIDIOC_QBUF, &buf);
    }

    v4l2_buf_type type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    xioctl(fd, VIDIOC_STREAMON, &type);

    std::vector<unsigned char> rgbBuffer(width * height * 3);
    cv::namedWindow("Face Blur", cv::WINDOW_AUTOSIZE);
    cv::resizeWindow("Face Blur", 640, 360);

    while (true) {
        fd_set fds;
        FD_ZERO(&fds);
        FD_SET(fd, &fds);
        timeval tv = {1, 0};
        int r = select(fd + 1, &fds, NULL, NULL, &tv);
        if (r <= 0) continue;

        v4l2_buffer buf{};
        buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
        buf.memory = V4L2_MEMORY_MMAP;
        xioctl(fd, VIDIOC_DQBUF, &buf);

        unpackBayer8ToRGB(buffers[buf.index].start, rgbBuffer.data(), width, height);
        cv::Mat frame(height, width, CV_8UC3, rgbBuffer.data());

        cv::Mat gray;
        cv::cvtColor(frame, gray, cv::COLOR_BGR2GRAY);
        cv::Mat smallGray;
        cv::resize(gray, smallGray, cv::Size(), 0.5, 0.5);
        auto smallFaces = detectFaces(smallGray);
        std::vector<cv::Rect> faces;
        for (auto& f : smallFaces) faces.push_back(cv::Rect(f.x * 2, f.y * 2, f.width * 2, f.height * 2));

        blurAndMarkFaces(rgbBuffer.data(), width, height, faces);
        cv::imshow("Face Blur", frame);
        if (cv::waitKey(1) == 27) break;

        xioctl(fd, VIDIOC_QBUF, &buf);
    }

    xioctl(fd, VIDIOC_STREAMOFF, &type);
    for (auto& b : buffers) munmap(b.start, b.length);
    close(fd);
    cv::destroyAllWindows();

    return 0;
}

