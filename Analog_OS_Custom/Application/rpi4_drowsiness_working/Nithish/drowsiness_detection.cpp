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
#include <opencv2/opencv.hpp>
#include <opencv2/face.hpp>

// --- Buffer structure for mmap ---
struct Buffer {
    void* start;
    size_t length;
};

// --- Safe ioctl wrapper ---
void xioctl(int fd, int request, void* arg) {
    int r;
    do { r = ioctl(fd, request, arg); }
    while (r == -1 && (errno == EINTR || errno == EAGAIN));
    if (r == -1) { perror("ioctl"); exit(EXIT_FAILURE); }
}

// --- Convert Bayer RGGB to RGB with enhancement ---
void unpackBayer8ToRGB(const void* src, void* dst, int width, int height) {
    cv::Mat raw8(height, width, CV_8UC1, const_cast<void*>(src));
    cv::Mat rgb;
    cv::cvtColor(raw8, rgb, cv::COLOR_BayerRG2RGB);

    // Improved color balance
    std::vector<cv::Mat> channels(3);
    cv::split(rgb, channels);
    channels[0] *= 1.6; // Blue
    channels[1] *= 1.1; // Green
    channels[2] *= 1.4; // Red
    cv::merge(channels, rgb);

    // Contrast enhancement + mild sharpening
    cv::Mat enhanced;
    cv::convertScaleAbs(rgb, enhanced, 1.25, 8);
    cv::GaussianBlur(enhanced, enhanced, cv::Size(0, 0), 1);
    cv::addWeighted(rgb, 1.5, enhanced, -0.5, 0, rgb);

    memcpy(dst, rgb.data, width * height * 3);
}

// --- Eye & Mouth Aspect Ratios ---
double eyeAspectRatio(const std::vector<cv::Point2f>& eye) {
    double A = cv::norm(eye[1] - eye[5]);
    double B = cv::norm(eye[2] - eye[4]);
    double C = cv::norm(eye[0] - eye[3]);
    return (A + B) / (2.0 * C);
}

double mouthAspectRatio(const std::vector<cv::Point2f>& mouth) {
    double A = cv::norm(mouth[1] - mouth[7]);
    double B = cv::norm(mouth[2] - mouth[6]);
    double C = cv::norm(mouth[3] - mouth[5]);
    double width = cv::norm(mouth[0] - mouth[4]);
    return (A + B + C) / (3.0 * width);
}

int main() {
    const char* devName = "/dev/video0";
    const int width = 640;
    const int height = 480;

    int fd = open(devName, O_RDWR | O_NONBLOCK);
    if (fd < 0) { perror("Cannot open device"); return 1; }

    // --- Configure format ---
    v4l2_format fmt{};
    fmt.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    fmt.fmt.pix.width = width;
    fmt.fmt.pix.height = height;
    fmt.fmt.pix.pixelformat = v4l2_fourcc('R','G','G','B');
    fmt.fmt.pix.field = V4L2_FIELD_NONE;
    xioctl(fd, VIDIOC_S_FMT, &fmt);

    // --- Request buffers ---
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
        if (buffers[i].start == MAP_FAILED) { perror("mmap"); return 1; }
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

    // --- Load models ---
    cv::CascadeClassifier face_cascade("haarcascade_frontalface_default.xml");
    cv::Ptr<cv::face::Facemark> facemark = cv::face::FacemarkLBF::create();
    facemark->loadModel("lbfmodel.yaml");

    std::vector<unsigned char> rgbBuffer(width * height * 3);
    cv::namedWindow("Drowsiness Detection", cv::WINDOW_NORMAL);
    cv::setWindowProperty("Drowsiness Detection", cv::WND_PROP_FULLSCREEN, cv::WINDOW_FULLSCREEN);

    const double EAR_THRESH = 0.26;
    const double MAR_THRESH = 0.6;
    const double EYE_CLOSED_TIME_THRESH = 1.2;

    bool eyeClosed = false;
    auto eyeClosedStart = std::chrono::steady_clock::now();

    std::cout << "[INFO] Starting Drowsiness Detection..." << std::endl;

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
        cv::equalizeHist(gray, gray);

        std::vector<cv::Rect> faces;
        face_cascade.detectMultiScale(gray, faces, 1.1, 4, cv::CASCADE_SCALE_IMAGE, cv::Size(80, 80));

        std::string status = "Driver: OK";

        if (!faces.empty()) {
            std::vector<std::vector<cv::Point2f>> landmarks;
            if (facemark->fit(frame, faces, landmarks)) {
                auto& lm = landmarks[0];
                std::vector<cv::Point2f> leftEye = {lm[36], lm[37], lm[38], lm[39], lm[40], lm[41]};
                std::vector<cv::Point2f> rightEye = {lm[42], lm[43], lm[44], lm[45], lm[46], lm[47]};
                double ear = (eyeAspectRatio(leftEye) + eyeAspectRatio(rightEye)) / 2.0;

                std::vector<cv::Point2f> mouth = {lm[48], lm[49], lm[50], lm[51], lm[52], lm[53], lm[54], lm[55]};
                double mar = mouthAspectRatio(mouth);

                if (ear < EAR_THRESH) {
                    if (!eyeClosed) {
                        eyeClosedStart = std::chrono::steady_clock::now();
                        eyeClosed = true;
                    } else {
                        double duration = std::chrono::duration_cast<std::chrono::seconds>(
                            std::chrono::steady_clock::now() - eyeClosedStart).count();
                        if (duration >= EYE_CLOSED_TIME_THRESH)
                            status = "⚠️ DROWSINESS ALERT - Eyes Closed";
                    }
                } else eyeClosed = false;

                if (mar > MAR_THRESH)
                    status = "⚠️ Yawning Detected";

                for (const auto& face : faces)
                    cv::rectangle(frame, face, cv::Scalar(0, 0, 255), 2);
            } else status = "Landmarks Not Detected";
        } else status = "No Face Detected";

        cv::putText(frame, status, cv::Point(20, 40),
                    cv::FONT_HERSHEY_DUPLEX, 1.0,
                    (status.find("⚠️") != std::string::npos) ? cv::Scalar(0, 0, 255) : cv::Scalar(0, 255, 0), 2);

        cv::imshow("Drowsiness Detection", frame);
        if (cv::waitKey(1) == 27) break;

        xioctl(fd, VIDIOC_QBUF, &buf);
    }

    xioctl(fd, VIDIOC_STREAMOFF, &type);
    for (auto& b : buffers) munmap(b.start, b.length);
    close(fd);
    cv::destroyAllWindows();
    return 0;
}

