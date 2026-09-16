// drowsiness_detection.cpp
// Compile with: g++ -std=c++17 drowsiness_detection.cpp -o drowsiness_detection `pkg-config --cflags --libs opencv4`

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
#include <opencv2/face.hpp>

struct Buffer {
    void* start;
    size_t length;
};

volatile sig_atomic_t stopRequested = 0;
void handleSig(int) { stopRequested = 1; }

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

// Unpack Bayer8 (SRGGB8) to BGR and basic gamma correction
void unpackBayer8ToRGB(const void* src, cv::Mat& dst) {
    // src is raw buffer of size rows*cols (one byte per pixel Bayer)
    // Create Mat header without copying
    cv::Mat raw8(dst.rows, dst.cols, CV_8UC1, const_cast<void*>(src));
    // Convert Bayer pattern to BGR. Adjust pattern to match sensor (BG/GB/RG) as needed.
    cv::cvtColor(raw8, dst, cv::COLOR_BayerBG2BGR);

    // Simple gamma correction to improve contrast (non-destructive)
    cv::Mat floatImg;
    dst.convertTo(floatImg, CV_32F, 1.0 / 255.0);
    cv::pow(floatImg, 1.1, floatImg); // gamma ~1.1 (slight brightening)
    floatImg.convertTo(dst, CV_8UC3, 255.0);
}

// Eye Aspect Ratio (EAR) - standard
double eyeAspectRatio(const std::vector<cv::Point2f>& eye) {
    double A = cv::norm(eye[1] - eye[5]);
    double B = cv::norm(eye[2] - eye[4]);
    double C = cv::norm(eye[0] - eye[3]);
    if (C < 1e-6) return 0.0;
    return (A + B) / (2.0 * C);
}

// Mouth Aspect Ratio (MAR) - uses inner mouth landmarks (60..67) and mouth width (48..54)
double mouthAspectRatio(const std::vector<cv::Point2f>& lm) {
    // lm must be the whole 68-point landmark set
    // inner mouth vertical distances
    double A = cv::norm(lm[61] - lm[67]); // 62-68 in 1-based
    double B = cv::norm(lm[62] - lm[66]); // 63-67
    double C = cv::norm(lm[63] - lm[65]); // 64-66
    double width = cv::norm(lm[60] - lm[64]); // 61-65 outer width approximation
    if (width < 1e-6) return 0.0;
    return (A + B + C) / (3.0 * width);
}

// Estimate head pose using 6 points mapping to a simple 3D model
cv::Vec3d estimateHeadPose(const std::vector<cv::Point2d>& landmarks, const cv::Size& imageSize) {
    // Model points (approximate, in mm)
    std::vector<cv::Point3d> modelPoints = {
        {0.0, 0.0, 0.0},            // Nose tip (30)
        {-30.0, -30.0, -30.0},      // Left eye corner (36)
        {30.0, -30.0, -30.0},       // Right eye corner (45)
        {-30.0, 30.0, -30.0},       // Left mouth corner (48)
        {30.0, 30.0, -30.0},        // Right mouth corner (54)
        {0.0, 60.0, -30.0}          // Chin (8)
    };

    std::vector<cv::Point2d> imagePoints = {
        landmarks[30], landmarks[36], landmarks[45],
        landmarks[48], landmarks[54], landmarks[8]
    };

    double focalLength = imageSize.width; // approximation
    cv::Point2d center(imageSize.width / 2.0, imageSize.height / 2.0);
    cv::Mat cameraMatrix = (cv::Mat_<double>(3,3) <<
                            focalLength, 0, center.x,
                            0, focalLength, center.y,
                            0, 0, 1);

    cv::Mat distCoeffs = cv::Mat::zeros(4,1,CV_64F);
    cv::Mat rvec, tvec;
    bool ok = cv::solvePnP(modelPoints, imagePoints, cameraMatrix, distCoeffs, rvec, tvec, false, cv::SOLVEPNP_ITERATIVE);
    if (!ok) return cv::Vec3d(0,0,0);

    cv::Mat R;
    cv::Rodrigues(rvec, R);
    cv::Mat pose = cv::Mat::zeros(3,4,CV_64F);
    R.copyTo(pose.colRange(0,3));
    tvec.copyTo(pose.col(3));
    cv::Mat cameraMatrixOut, rotMatrix, transVect, rotMatrixX, rotMatrixY, rotMatrixZ, eulerAngles;
    cv::decomposeProjectionMatrix(pose, cameraMatrixOut, rotMatrix, transVect, rotMatrixX, rotMatrixY, rotMatrixZ, eulerAngles);
    // eulerAngles are in degrees
    double pitch = eulerAngles.at<double>(0);
    double yaw   = eulerAngles.at<double>(1);
    double roll  = eulerAngles.at<double>(2);
    return cv::Vec3d(pitch, yaw, roll);
}

bool fileExists(const std::string& path) {
    std::ifstream f(path.c_str());
    return f.good();
}

int main() {
    signal(SIGINT, handleSig);
    signal(SIGTERM, handleSig);

    const char* devName = "/dev/video0";
    const int width = 1920;
    const int height = 1080;

    int fd = open(devName, O_RDWR | O_NONBLOCK);
    if (fd < 0) {
        perror("Cannot open device");
        return 1;
    }

    // Set format to Bayer 8-bit SRGGB
    v4l2_format fmt{};
    fmt.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    fmt.fmt.pix.width = width;
    fmt.fmt.pix.height = height;
    fmt.fmt.pix.pixelformat = V4L2_PIX_FMT_SRGGB8; // raw bayer 8
    fmt.fmt.pix.field = V4L2_FIELD_NONE;
    xioctl(fd, VIDIOC_S_FMT, &fmt);

    // Request buffers
    v4l2_requestbuffers req{};
    req.count = 4;
    req.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    req.memory = V4L2_MEMORY_MMAP;
    xioctl(fd, VIDIOC_REQBUFS, &req);

    if (req.count < 2) {
        std::cerr << "Insufficient buffer memory\n";
        close(fd);
        return 1;
    }

    std::vector<Buffer> buffers(req.count);
    for (unsigned i = 0; i < (unsigned)req.count; i++) {
        v4l2_buffer buf{};
        buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
        buf.memory = V4L2_MEMORY_MMAP;
        buf.index = i;
        xioctl(fd, VIDIOC_QUERYBUF, &buf);
        buffers[i].length = buf.length;
        buffers[i].start = mmap(NULL, buf.length, PROT_READ | PROT_WRITE, MAP_SHARED, fd, buf.m.offset);

        if (buffers[i].start == MAP_FAILED) {
            perror("mmap");
            // cleanup previously mmapped buffers
            for (unsigned j = 0; j < i; ++j) munmap(buffers[j].start, buffers[j].length);
            close(fd);
            return 1;
        }
    }

    for (unsigned i = 0; i < (unsigned)req.count; i++) {
        v4l2_buffer buf{};
        buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
        buf.memory = V4L2_MEMORY_MMAP;
        buf.index = i;
        xioctl(fd, VIDIOC_QBUF, &buf);
    }

    v4l2_buf_type type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    xioctl(fd, VIDIOC_STREAMON, &type);

    // --- Load models ---
    const std::string facemarkModelPath = "lbfmodel.yaml";
    const std::string faceCascadePath = "haarcascade_frontalface_default.xml";

    if (!fileExists(facemarkModelPath) || !fileExists(faceCascadePath)) {
        std::cerr << "Required model files missing. Make sure:\n"
                  << " - " << facemarkModelPath << "\n"
                  << " - " << faceCascadePath << "\n";
        // cleanup
        xioctl(fd, VIDIOC_STREAMOFF, &type);
        for (auto& b : buffers) munmap(b.start, b.length);
        close(fd);
        return -1;
    }

    cv::Ptr<cv::face::Facemark> facemark = cv::face::FacemarkLBF::create();
    try {
        facemark->loadModel(facemarkModelPath);
    } catch (const cv::Exception& e) {
        std::cerr << "Error loading facemark model: " << e.what() << "\n";
        xioctl(fd, VIDIOC_STREAMOFF, &type);
        for (auto& b : buffers) munmap(b.start, b.length);
        close(fd);
        return -1;
    }

    cv::CascadeClassifier face_cascade;
    if (!face_cascade.load(faceCascadePath)) {
        std::cerr << "Error loading face cascade\n";
        xioctl(fd, VIDIOC_STREAMOFF, &type);
        for (auto& b : buffers) munmap(b.start, b.length);
        close(fd);
        return -1;
    }

    cv::Mat frame(height, width, CV_8UC3);
    cv::Mat gray(height, width, CV_8UC1);
    cv::namedWindow("Drowsiness Detection", cv::WINDOW_NORMAL);
    cv::resizeWindow("Drowsiness Detection", 1280, 720);

    // Parameters and thresholds (tweakable)
    const double DEFAULT_EAR_THRESH = 0.25;  // below this -> eye possibly closed
    const double DEFAULT_MAR_THRESH = 0.60;  // above this -> yawning
    const double DEFAULT_YAW_THRESH = 25.0;  // degrees
    const double DEFAULT_PITCH_THRESH = 20.0;
    const double EYE_CLOSED_TIME_THRESH = 1.0; // seconds considered drowsy if closed continuously

    // Smoothing windows for EAR/MAR/yaw to reduce jitter
    const size_t SMOOTHING_WINDOW = 5;
    std::deque<double> earHistory, marHistory, yawHistory;

    bool eyeClosed = false;
    auto eyeClosedStart = std::chrono::steady_clock::now();
    int blinkCount = 0;

    // Calibration collection: first N frames for baseline EAR (open-eye)
    const int CALIB_FRAMES = 30;
    int calibCounter = 0;
    double calibEarSum = 0.0;
    bool calibrated = false;
    double earThreshold = DEFAULT_EAR_THRESH;
    double marThreshold = DEFAULT_MAR_THRESH;

    // For FPS display
    auto lastTime = std::chrono::steady_clock::now();
    int frameCounter = 0;
    double fps = 0.0;

    while (!stopRequested) {
        fd_set fds;
        FD_ZERO(&fds);
        FD_SET(fd, &fds);
        timeval tv = {0, 10000}; // 10ms
        int r = select(fd + 1, &fds, NULL, NULL, &tv);
        if (r < 0) {
            if (errno == EINTR) continue;
            perror("select");
            break;
        }
        if (r == 0) {
            // timeout - loop
            continue;
        }

        v4l2_buffer buf{};
        buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
        buf.memory = V4L2_MEMORY_MMAP;
        xioctl(fd, VIDIOC_DQBUF, &buf);

        // Convert raw Bayer -> BGR
        unpackBayer8ToRGB(buffers[buf.index].start, frame);
        cv::cvtColor(frame, gray, cv::COLOR_BGR2GRAY);

        std::vector<cv::Rect> faces;
        face_cascade.detectMultiScale(gray, faces, 1.1, 3, 0, cv::Size(80, 80));

        std::string status = "Driver: OK";

        if (!faces.empty()) {
            // Fit landmarks
            std::vector<std::vector<cv::Point2f>> landmarks;
            bool ok = false;
            try {
                ok = facemark->fit(frame, faces, landmarks);
            } catch (const cv::Exception& e) {
                ok = false;
            }

            if (ok && !landmarks.empty()) {
                // We assume one face for drowsiness; choose the largest face (optional)
                size_t chosenIdx = 0;
                if (landmarks.size() > 1) {
                    // pick largest face bounding box
                    int maxArea = 0;
                    for (size_t i = 0; i < faces.size(); ++i) {
                        int a = faces[i].width * faces[i].height;
                        if (a > maxArea) { maxArea = a; chosenIdx = i; }
                    }
                }

                auto& lm = landmarks[chosenIdx];

                // Compute EAR (both eyes)
                std::vector<cv::Point2f> leftEye = {lm[36], lm[37], lm[38], lm[39], lm[40], lm[41]};
                std::vector<cv::Point2f> rightEye = {lm[42], lm[43], lm[44], lm[45], lm[46], lm[47]};
                double ear = (eyeAspectRatio(leftEye) + eyeAspectRatio(rightEye)) / 2.0;

                // Compute MAR
                double mar = mouthAspectRatio(lm);

                // Head pose estimate
                std::vector<cv::Point2d> lm2d(lm.begin(), lm.end());
                cv::Vec3d euler = estimateHeadPose(lm2d, frame.size());
                double pitch = euler[0], yaw = euler[1], roll = euler[2];

                // Smoothing
                earHistory.push_back(ear);
                if (earHistory.size() > SMOOTHING_WINDOW) earHistory.pop_front();
                marHistory.push_back(mar);
                if (marHistory.size() > SMOOTHING_WINDOW) marHistory.pop_front();
                yawHistory.push_back(yaw);
                if (yawHistory.size() > SMOOTHING_WINDOW) yawHistory.pop_front();

                auto meanDeque = [](const std::deque<double>& d) {
                    if (d.empty()) return 0.0;
                    double s = 0;
                    for (double v : d) s += v;
                    return s / d.size();
                };

                double earSmooth = meanDeque(earHistory);
                double marSmooth = meanDeque(marHistory);
                double yawSmooth = meanDeque(yawHistory);

                // Calibration during first CALIB_FRAMES frames to get open-eye EAR baseline
                if (!calibrated) {
                    calibEarSum += earSmooth;
                    calibCounter++;
                    if (calibCounter >= CALIB_FRAMES) {
                        double meanOpenEar = calibEarSum / calibCounter;
                        earThreshold = std::max(0.12, meanOpenEar * 0.50); // set threshold as ~50% of open-eye EAR but not too low
                        calibrated = true;
                        std::cout << "Calibration done. meanOpenEar=" << meanOpenEar << " EAR_THRESH=" << earThreshold << std::endl;
                    } else {
                        status = "Calibrating...";
                    }
                }

                // If not calibrated yet, use default threshold
                double usedEarThresh = calibrated ? earThreshold : DEFAULT_EAR_THRESH;
                double usedMarThresh = marThreshold; // kept constant (tweakable)

                // Drowsiness detection logic
                if (earSmooth < usedEarThresh) {
                    if (!eyeClosed) {
                        eyeClosedStart = std::chrono::steady_clock::now();
                        eyeClosed = true;
                    } else {
                        auto duration = std::chrono::duration_cast<std::chrono::duration<double>>(
                            std::chrono::steady_clock::now() - eyeClosedStart).count();
                        if (duration >= EYE_CLOSED_TIME_THRESH) status = "DROWSINESS ALERT";
                        else status = "Eyes Closed";
                    }
                } else {
                    if (eyeClosed) {
                        blinkCount++;
                        eyeClosed = false;
                    }
                }

                if (marSmooth > usedMarThresh) status = "Yawning";
                else if (yawSmooth > DEFAULT_YAW_THRESH) status = "Looking Left";
                else if (yawSmooth < -DEFAULT_YAW_THRESH) status = "Looking Right";
                else if (pitch > DEFAULT_PITCH_THRESH) status = "Looking Down";

                // Draw landmarks and boxes
                cv::rectangle(frame, faces[chosenIdx], cv::Scalar(0,255,0), 2);
                for (const auto &p : lm) cv::circle(frame, p, 2, cv::Scalar(255,0,0), -1);

                // Display numeric info
                char info[256];
                snprintf(info, sizeof(info), "EAR: %.3f (%.3f)  MAR: %.3f  Yaw: %.1f  Blinks: %d",
                         ear, earSmooth, marSmooth, yawSmooth, blinkCount);
                cv::putText(frame, info, cv::Point(10, 55), cv::FONT_HERSHEY_SIMPLEX, 0.6, cv::Scalar(255,255,255), 2);
            } else {
                status = "Landmarks Not Detected";
            }
        } else {
            status = "No Face Detected";
        }

        // FPS calculation
        frameCounter++;
        auto now = std::chrono::steady_clock::now();
        double elapsed = std::chrono::duration_cast<std::chrono::duration<double>>(now - lastTime).count();
        if (elapsed >= 1.0) {
            fps = frameCounter / elapsed;
            frameCounter = 0;
            lastTime = now;
        }

        // Put status and fps
        cv::putText(frame, status, cv::Point(10, 30), cv::FONT_HERSHEY_SIMPLEX, 0.9, cv::Scalar(0,0,255), 2);
        char fpsbuf[64];
        snprintf(fpsbuf, sizeof(fpsbuf), "FPS: %.1f", fps);
        cv::putText(frame, fpsbuf, cv::Point(10, frame.rows - 20), cv::FONT_HERSHEY_SIMPLEX, 0.7, cv::Scalar(0,255,255), 2);

        cv::imshow("Drowsiness Detection", frame);

        // Requeue buffer
        xioctl(fd, VIDIOC_QBUF, &buf);

        // Keep window responsive
        int key = cv::waitKey(1);
        if (key == 27) break; // ESC
    }

    // cleanup
    xioctl(fd, VIDIOC_STREAMOFF, &type);
    for (auto& b : buffers) munmap(b.start, b.length);
    close(fd);
    cv::destroyAllWindows();
    return 0;
}

