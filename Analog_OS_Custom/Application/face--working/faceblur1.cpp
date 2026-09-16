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

// Buffer structure for mmap
struct Buffer {
    void* start;
    size_t length;
};

// Perform ioctl safely
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

// Configure subdevices and set quality parameters before capture
void configureCamera() {
    // Configure pipeline formats
    system("v4l2-ctl -v width=640,height=480,pixelformat=RGGB");
    system("media-ctl -d \"platform:fe801000.csi\" "
           "--set-v4l2 '\"max96717:0 23-0040\":0[fmt:SRGGB8_1X8/640x480 field:none]'");
    system("media-ctl -d \"platform:fe801000.csi\" "
           "--set-v4l2 '\"max96724:0 10-0027\":0[fmt:SRGGB8_1X8/640x480 field:none]'");
    system("media-ctl -d \"platform:fe801000.csi\" "
           "--set-v4l2 '\"imx219 24-0010\":0[fmt:SRGGB8_1X8/640x480 field:none]'");

    // Adjust sensor exposure/gain (update subdev index as needed)
    system("v4l2-ctl -d /dev/v4l-subdev5 --set-ctrl=exposure=2000");
    system("v4l2-ctl -d /dev/v4l-subdev5 --set-ctrl=analogue_gain=100");
    system("v4l2-ctl -d /dev/v4l-subdev5 --set-ctrl=digital_gain=1900");
}

// Convert Bayer RGGB to RGB and correct color balance
void unpackBayer8ToRGB(const void* src, void* dst, int width, int height) {
    cv::Mat raw8(height, width, CV_8UC1, const_cast<void*>(src));
    cv::Mat rgb;
    cv::cvtColor(raw8, rgb, cv::COLOR_BayerRG2RGB);

    // ---- Manual color balance correction (reduce green tint) ----
    std::vector<cv::Mat> channels(3);
    cv::split(rgb, channels);

    // Adjust gains: red & blue boosted, green normal
    double redGain = 1.4;
    double greenGain = 1.0;
    double blueGain = 1.7;

    channels[0] *= blueGain;   // Blue
    channels[1] *= greenGain;  // Green
    channels[2] *= redGain;    // Red

    cv::merge(channels, rgb);

    // Normalize to 8-bit and clip values
    cv::normalize(rgb, rgb, 0, 255, cv::NORM_MINMAX);
    rgb.convertTo(rgb, CV_8UC3);

    memcpy(dst, rgb.data, width * height * 3);
}

// Static face detector (loads once)
cv::CascadeClassifier face_cascade;
std::vector<cv::Rect> detectFaces(const cv::Mat& gray) {
    if (face_cascade.empty()) {
        if (!face_cascade.load("haarcascade_frontalface_default.xml")) {
            std::cerr << "Error: Failed to load Haar cascade file.\n";
            return {};
        }
    }
    std::vector<cv::Rect> faces;
    face_cascade.detectMultiScale(gray, faces, 1.1, 3, 0, cv::Size(30, 30));
    return faces;
}

// Draw bounding box and apply blur
void blurAndMarkFaces(unsigned char* rgbBuffer, int width, int height, const std::vector<cv::Rect>& faces) {
    cv::Mat img(height, width, CV_8UC3, rgbBuffer);
    for (const auto& face : faces) {
        // Draw red rectangle around the face
        cv::rectangle(img, face, cv::Scalar(0, 0, 255), 2); // BGR -> red

        // Apply stronger Gaussian blur for privacy
        cv::Mat faceROI = img(face);
        cv::GaussianBlur(faceROI, faceROI, cv::Size(61, 61), 50);
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
        if (buffers[i].start == MAP_FAILED) {
            perror("mmap");
            return 1;
        }
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

    while (true) {
        fd_set fds;
        FD_ZERO(&fds);
        FD_SET(fd, &fds);
        timeval tv = {2, 0};
        int r = select(fd + 1, &fds, NULL, NULL, &tv);
        if (r == -1) {
            if (errno == EINTR) continue;
            perror("select");
            break;
        }
        if (r == 0) {
            std::cerr << "Timeout\n";
            break;
        }

        v4l2_buffer buf{};
        buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
        buf.memory = V4L2_MEMORY_MMAP;
        xioctl(fd, VIDIOC_DQBUF, &buf);

        unpackBayer8ToRGB(buffers[buf.index].start, rgbBuffer.data(), width, height);

        cv::Mat frame(height, width, CV_8UC3, rgbBuffer.data());

        cv::Mat gray;
        cv::cvtColor(frame, gray, cv::COLOR_BGR2GRAY);
        std::vector<cv::Rect> faces = detectFaces(gray);

        blurAndMarkFaces(rgbBuffer.data(), width, height, faces);

        cv::imshow("Face Blur", frame);
        if (cv::waitKey(1) == 27) break; // ESC to exit

        xioctl(fd, VIDIOC_QBUF, &buf);
    }

    xioctl(fd, VIDIOC_STREAMOFF, &type);
    for (auto& b : buffers) munmap(b.start, b.length);
    close(fd);
    cv::destroyAllWindows();

    return 0;
}

