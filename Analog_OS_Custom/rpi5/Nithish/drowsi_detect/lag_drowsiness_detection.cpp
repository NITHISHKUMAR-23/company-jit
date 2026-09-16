//g++ -o drowsiness_detection drowsiness_detection.cpp `pkg-config --cflags --libs opencv4` -lopencv_face

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
#include <thread>
#include <atomic>
#include <mutex>
#include <condition_variable>
#include <chrono>

#include <opencv2/opencv.hpp>
#include <opencv2/face.hpp>

struct Buffer {
    void* start;
    size_t length;
};

static void xioctl(int fd, int request, void* arg) {
    int r;
    do {
        r = ioctl(fd, request, arg);
    } while (r == -1 && (errno == EINTR || errno == EAGAIN));
    if (r == -1) {
        perror("ioctl");
        exit(EXIT_FAILURE);
    }
}

// Convert Bayer to RGB
void unpackBayer8ToRGB(const void* src, void* dst, int width, int height) {
    cv::Mat raw8(height, width, CV_8UC1, const_cast<void*>(src));
    cv::Mat rgb;
    cv::cvtColor(raw8, rgb, cv::COLOR_BayerRG2BGR);
    memcpy(dst, rgb.data, width * height * 3);
}

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

cv::Vec3d estimateHeadPose(const std::vector<cv::Point2d>& landmarks, const cv::Size& imageSize) {
    std::vector<cv::Point3d> modelPoints = {
        {0.0, 0.0, 0.0}, {-30.0, -30.0, -30.0}, {30.0, -30.0, -30.0},
        {-30.0, 30.0, -30.0}, {30.0, 30.0, -30.0}, {0.0, 60.0, -30.0}
    };
    std::vector<cv::Point2d> imagePoints = {
        landmarks[30], landmarks[36], landmarks[45],
        landmarks[48], landmarks[54], landmarks[8]
    };

    double focalLength = imageSize.width;
    cv::Point2d center(imageSize.width / 2, imageSize.height / 2);
    cv::Mat cameraMatrix = (cv::Mat_<double>(3,3) <<
        focalLength, 0, center.x, 0, focalLength, center.y, 0, 0, 1);
    cv::Mat distCoeffs = cv::Mat::zeros(4,1,CV_64F);
    cv::Mat rotationVector, translationVector;
    bool success = cv::solvePnP(modelPoints, imagePoints, cameraMatrix,
                                distCoeffs, rotationVector, translationVector);
    if (!success) return cv::Vec3d(0,0,0);

    cv::Mat rotationMatrix;
    cv::Rodrigues(rotationVector, rotationMatrix);
    cv::Mat poseMatrix = cv::Mat::zeros(3,4,CV_64F);
    rotationMatrix.copyTo(poseMatrix(cv::Rect(0,0,3,3)));
    translationVector.copyTo(poseMatrix.col(3));
    cv::Mat eulerAngles;
    cv::decomposeProjectionMatrix(poseMatrix, cv::Mat(), cv::Mat(),
                                  cv::Mat(), cv::Mat(), cv::Mat(), cv::Mat(), eulerAngles);
    return cv::Vec3d(eulerAngles.at<double>(0), eulerAngles.at<double>(1), eulerAngles.at<double>(2));
}

struct FrameData {
    std::vector<unsigned char> data;
    bool ready = false;
};

// Shared frame buffer
std::mutex frameMutex;
std::condition_variable frameCond;
FrameData sharedFrame;
std::atomic<bool> running(true);

// Capture thread
void captureThreadFunc(const char* devName, int width, int height) {
    int fd = open(devName, O_RDWR | O_NONBLOCK);
    if (fd < 0) { perror("open"); return; }

    v4l2_format fmt{};
    fmt.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    fmt.fmt.pix.width = width;
    fmt.fmt.pix.height = height;
    fmt.fmt.pix.pixelformat = v4l2_fourcc('R','G','G','B');
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

    while (running) {
        fd_set fds;
        FD_ZERO(&fds);
        FD_SET(fd, &fds);
        timeval tv = {0, 50000}; // 50ms timeout
        int r = select(fd + 1, &fds, NULL, NULL, &tv);
        if (r <= 0) continue;

        v4l2_buffer buf{};
        buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
        buf.memory = V4L2_MEMORY_MMAP;
        if (ioctl(fd, VIDIOC_DQBUF, &buf) == 0) {
            unpackBayer8ToRGB(buffers[buf.index].start, rgbBuffer.data(), width, height);

            {
                std::unique_lock<std::mutex> lock(frameMutex);
                sharedFrame.data = rgbBuffer;
                sharedFrame.ready = true;
            }
            frameCond.notify_one();

            xioctl(fd, VIDIOC_QBUF, &buf);
        }
    }

    xioctl(fd, VIDIOC_STREAMOFF, &type);
    for (auto& b : buffers) munmap(b.start, b.length);
    close(fd);
}

int main() {
    const char* devName = "/dev/video0";
    const int width = 1920;
    const int height = 1080;

    cv::CascadeClassifier face_cascade("haarcascade_frontalface_default.xml");
    cv::Ptr<cv::face::Facemark> facemark = cv::face::FacemarkLBF::create();
    facemark->loadModel("lbfmodel.yaml");

    std::thread captureThread(captureThreadFunc, devName, width, height);

    cv::namedWindow("Drowsiness Detection", cv::WINDOW_AUTOSIZE);

    const double EAR_THRESH = 0.25;
    const double MAR_THRESH = 0.65;
    const double EYE_CLOSED_TIME_THRESH = 1.0;

    bool eyeClosed = false;
    auto eyeClosedStart = std::chrono::steady_clock::now();
    int blinkCount = 0;

    while (running) {
        std::unique_lock<std::mutex> lock(frameMutex);
        frameCond.wait(lock, [] { return sharedFrame.ready || !running; });
        if (!running) break;
        cv::Mat frame(height, width, CV_8UC3, sharedFrame.data.data());
        sharedFrame.ready = false;
        lock.unlock();

        std::vector<cv::Rect> faces;
        cv::Mat gray;
        cv::cvtColor(frame, gray, cv::COLOR_BGR2GRAY);
        face_cascade.detectMultiScale(gray, faces, 1.1, 3, 0, cv::Size(80, 80));

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

                std::vector<cv::Point2d> keyLandmarks(lm.begin(), lm.end());
                cv::Vec3d eulerAngles = estimateHeadPose(keyLandmarks, frame.size());
                double pitch = eulerAngles[0];
                double yaw = eulerAngles[1];

                if (ear < EAR_THRESH) {
                    if (!eyeClosed) {
                        eyeClosedStart = std::chrono::steady_clock::now();
                        eyeClosed = true;
                    } else {
                        double duration = std::chrono::duration_cast<std::chrono::seconds>(
                            std::chrono::steady_clock::now() - eyeClosedStart).count();
                        if (duration >= EYE_CLOSED_TIME_THRESH)
                            status = "DROWSINESS ALERT - Eyes Closed";
                    }
                } else {
                    if (eyeClosed) {
                        blinkCount++;
                        eyeClosed = false;
                    }
                }

                if (mar > MAR_THRESH)
                    status = "Yawning";

                if (yaw > 25)
                    status = "Looking Left";
                else if (yaw < -25)
                    status = "Looking Right";
                else if (pitch > 20)
                    status = "Looking Down";
            } else status = "Landmarks Not Detected";
        } else status = "No Face Detected";

        cv::putText(frame, status, cv::Point(10, 30),
                    cv::FONT_HERSHEY_SIMPLEX, 0.8, cv::Scalar(0, 0, 255), 2);
        cv::imshow("Drowsiness Detection", frame);

        if (cv::waitKey(1) == 27) { // ESC
            running = false;
            frameCond.notify_all();
            break;
        }
    }

    captureThread.join();
    cv::destroyAllWindows();
    return 0;
}

