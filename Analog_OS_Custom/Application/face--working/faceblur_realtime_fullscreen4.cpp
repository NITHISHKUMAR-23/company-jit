// faceblur_realtime.cpp
// Build: g++ -std=c++17 -O2 faceblur_realtime.cpp -o faceblur_realtime `pkg-config --cflags --libs opencv4`

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
#include <mutex>
#include <condition_variable>
#include <atomic>
#include <chrono>
#include <opencv2/opencv.hpp>

// -------------------- Configuration --------------------
const char* DEV_VIDEO = "/dev/video0";
const int WIDTH = 640;
const int HEIGHT = 480;
const int REQ_BUFFER_COUNT = 4;

// If you see "Cannot open device /dev/v4l-subdevX" change this to sensor subdev seen in `media-ctl -p`
const char* sensorSubdev = "/dev/v4l-subdev2";

// Face detection frequency (detect every N frames to save CPU)
const int DETECT_EVERY_N_FRAMES = 3;

// Detection downscale factor (faster detection)
const double DETECT_SCALE = 0.5;

// Blur parameters (adjust for quality vs speed)
const cv::Size BLUR_KERNEL = cv::Size(41, 41);
const double BLUR_SIGMA = 25.0;

// Color balance gains (after demosaic)
const double RED_GAIN = 1.35;
const double GREEN_GAIN = 1.0;
const double BLUE_GAIN = 1.6;

// Whether to use full-screen on start
const bool START_FULLSCREEN = true;
// -------------------------------------------------------

struct Buffer { void* start; size_t length; };

// Safe ioctl wrapper (exits on fatal error)
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

// Try to run camera configuration commands only if sensor subdev exists
void configureCamera() {
    // Configure pipeline formats (these commands are harmless if they fail)
    system("v4l2-ctl -v width=640,height=480,pixelformat=RGGB");
    system("media-ctl -d \"platform:fe801000.csi\" "
           "--set-v4l2 '\"max96717:0 23-0040\":0[fmt:SRGGB8_1X8/640x480 field:none]'");
    system("media-ctl -d \"platform:fe801000.csi\" "
           "--set-v4l2 '\"max96724:0 10-0027\":0[fmt:SRGGB8_1X8/640x480 field:none]'");
    system("media-ctl -d \"platform:fe801000.csi\" "
           "--set-v4l2 '\"imx219 24-0010\":0[fmt:SRGGB8_1X8/640x480 field:none]'");

    // Only set controls if the subdev exists to avoid noisy errors
    if (access(sensorSubdev, F_OK) == 0) {
        std::string cmd;
        cmd = std::string("v4l2-ctl -d ") + sensorSubdev + " --set-ctrl=exposure=2000";
        system(cmd.c_str());
        cmd = std::string("v4l2-ctl -d ") + sensorSubdev + " --set-ctrl=analogue_gain=100";
        system(cmd.c_str());
        cmd = std::string("v4l2-ctl -d ") + sensorSubdev + " --set-ctrl=digital_gain=1900";
        system(cmd.c_str());
    } else {
        std::cerr << "[configureCamera] Warning: " << sensorSubdev << " not found; skipping sensor controls.\n";
    }
}

// Convert Bayer RGGB to RGB and apply manual color balance + mild contrast/gamma
void demosaicAndColorCorrect(const uint8_t* raw, int width, int height, cv::Mat& outRGB) {
    // raw is WIDTH*HEIGHT bytes (SRGGB8_1X8)
    cv::Mat rawMat(height, width, CV_8UC1, const_cast<uint8_t*>(raw));
    cv::Mat rgb;
    // Try BayerRG -> RGB. If results wrong, try BayerBG by changing cv::COLOR_BayerRG2RGB.
    cv::cvtColor(rawMat, rgb, cv::COLOR_BayerRG2RGB);

    // Split and scale channels
    std::vector<cv::Mat> ch(3);
    cv::split(rgb, ch);
    ch[0].convertTo(ch[0], CV_32F);
    ch[1].convertTo(ch[1], CV_32F);
    ch[2].convertTo(ch[2], CV_32F);

    ch[0] *= BLUE_GAIN;
    ch[1] *= GREEN_GAIN;
    ch[2] *= RED_GAIN;

    // Merge back
    cv::Mat merged;
    cv::merge(ch, merged);
    // Normalize and convert to 8-bit
    cv::normalize(merged, merged, 0, 255, cv::NORM_MINMAX);
    merged.convertTo(merged, CV_8UC3);

    // Slight contrast boost
    cv::Mat contrast;
    cv::convertScaleAbs(merged, contrast, 1.12, 6);

    // Mild gamma correction
    cv::Mat gamma;
    contrast.convertTo(gamma, CV_32F, 1.0 / 255.0);
    cv::pow(gamma, 1.05, gamma);
    gamma.convertTo(outRGB, CV_8UC3, 255.0);
}

// Thread-safe single-slot buffer that always holds the latest raw Bayer frame
class LatestFrameBuffer {
public:
    LatestFrameBuffer(size_t size) : buf(size), hasFrame(false) {}
    void push(const std::vector<uint8_t>& data) {
        std::lock_guard<std::mutex> lk(m);
        buf = data; // copy
        hasFrame = true;
        cv.notify_one();
    }
    // wait and pop latest frame, returns false if stopping
    bool waitAndPop(std::vector<uint8_t>& out, std::atomic<bool>& running) {
        std::unique_lock<std::mutex> lk(m);
        cv.wait(lk, [&]{ return hasFrame || !running.load(); });
        if (!running.load() && !hasFrame) return false;
        out = std::move(buf);
        hasFrame = false;
        return true;
    }
    // try get without waiting (non-blocking)
    bool tryGetLatest(std::vector<uint8_t>& out) {
        std::lock_guard<std::mutex> lk(m);
        if (!hasFrame) return false;
        out = std::move(buf);
        hasFrame = false;
        return true;
    }
    // notify to unblock wait if stopping
    void notifyStop() {
        cv.notify_all();
    }
private:
    std::vector<uint8_t> buf;
    bool hasFrame;
    std::mutex m;
    std::condition_variable cv;
};

// Global cascade (load once)
cv::CascadeClassifier faceCascade;

// Capture thread: grabs from V4L2, copies raw Bayer into latestBuffer, requeues buffer fast
void captureThreadFunc(int fd, const std::vector<Buffer>& buffers, LatestFrameBuffer& latestBuffer,
                       std::atomic<bool>& running) {

    while (running.load()) {
        fd_set fds;
        FD_ZERO(&fds);
        FD_SET(fd, &fds);
        timeval tv = {1, 0}; // 1 second timeout
        int r = select(fd + 1, &fds, NULL, NULL, &tv);
        if (r == -1) {
            if (errno == EINTR) continue;
            perror("select");
            break;
        }
        if (r == 0) continue; // timeout, loop again

        v4l2_buffer buf{};
        buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
        buf.memory = V4L2_MEMORY_MMAP;
        // Dequeue
        if (ioctl(fd, VIDIOC_DQBUF, &buf) == -1) {
            if (errno == EAGAIN || errno == EINTR) continue;
            perror("VIDIOC_DQBUF");
            break;
        }

        // Copy raw Bayer to temporary vector quickly, then requeue buffer ASAP
        size_t frameSize = WIDTH * HEIGHT;
        std::vector<uint8_t> raw(frameSize);
        memcpy(raw.data(), buffers[buf.index].start, frameSize);

        // Requeue buffer immediately to keep kernel buffers free (low latency)
        if (ioctl(fd, VIDIOC_QBUF, &buf) == -1) {
            perror("VIDIOC_QBUF");
            break;
        }

        // Push latest raw frame to shared buffer (overwrites old frames)
        latestBuffer.push(raw);
    }

    // Ensure processing thread unblocks if waiting
    latestBuffer.notifyStop();
}

// Processing thread: converts raw -> RGB, detects faces, blurs and displays
void processingThreadFunc(LatestFrameBuffer& latestBuffer, std::atomic<bool>& running) {
    const std::string winName = "Face Blur (Press ESC to exit, F to toggle fullscreen)";
    cv::namedWindow(winName, cv::WINDOW_NORMAL);
    if (START_FULLSCREEN) {
        cv::setWindowProperty(winName, cv::WND_PROP_FULLSCREEN, cv::WINDOW_FULLSCREEN);
    } else {
        cv::resizeWindow(winName, WIDTH, HEIGHT);
    }

    int frameCounter = 0;
    bool fullscreen = START_FULLSCREEN;

    while (running.load()) {
        std::vector<uint8_t> raw;
        // Wait up to a short timeout for a frame (so key events can be handled)
        bool got = latestBuffer.waitAndPop(raw, running);
        if (!got) break;

        // Convert raw Bayer to RGB
        cv::Mat rgb;
        demosaicAndColorCorrect(raw.data(), WIDTH, HEIGHT, rgb);

        // Detect every N frames on a downscaled gray image
        std::vector<cv::Rect> faces;
        if ((frameCounter % DETECT_EVERY_N_FRAMES) == 0) {
            cv::Mat gray;
            cv::cvtColor(rgb, gray, cv::COLOR_BGR2GRAY);
            cv::Mat smallGray;
            cv::resize(gray, smallGray, cv::Size(), DETECT_SCALE, DETECT_SCALE);

            std::vector<cv::Rect> smallFaces;
            if (!faceCascade.empty()) {
                faceCascade.detectMultiScale(smallGray, smallFaces, 1.1, 3, 0, cv::Size(30, 30));
                faces.reserve(smallFaces.size());
                for (auto &f : smallFaces) {
                    faces.emplace_back(cv::Rect(cv::Point(int(f.x / DETECT_SCALE), int(f.y / DETECT_SCALE)),
                                               cv::Size(int(f.width / DETECT_SCALE), int(f.height / DETECT_SCALE))));
                }
            }
        }

        // Draw red rectangles and blur faces
        for (const auto& face : faces) {
            // Ensure face rect is inside image
            cv::Rect r = face & cv::Rect(0, 0, rgb.cols, rgb.rows);
            if (r.width <= 0 || r.height <= 0) continue;
            // Draw thicker/red rectangle
            cv::rectangle(rgb, r, cv::Scalar(0, 0, 255), 2);

            // Blur the face region - copy ROI and blur in place
            cv::Mat roi = rgb(r);
            cv::GaussianBlur(roi, roi, BLUR_KERNEL, BLUR_SIGMA);
        }

        // Display
        cv::imshow(winName, rgb);
        int key = cv::waitKey(1);
        if (key == 27) { // ESC
            running.store(false);
            break;
        } else if (key == 'f' || key == 'F') {
            fullscreen = !fullscreen;
            cv::setWindowProperty(winName, cv::WND_PROP_FULLSCREEN, fullscreen ? cv::WINDOW_FULLSCREEN : cv::WINDOW_NORMAL);
        }

        frameCounter++;
    }

    cv::destroyWindow(winName);
}

int main() {
    configureCamera();

    int fd = open(DEV_VIDEO, O_RDWR | O_NONBLOCK);
    if (fd < 0) {
        perror("Cannot open video device");
        return 1;
    }

    // Set format
    v4l2_format fmt{};
    fmt.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    fmt.fmt.pix.width = WIDTH;
    fmt.fmt.pix.height = HEIGHT;
    fmt.fmt.pix.pixelformat = v4l2_fourcc('R', 'G', 'G', 'B'); // Bayer RGGB
    fmt.fmt.pix.field = V4L2_FIELD_NONE;
    xioctl(fd, VIDIOC_S_FMT, &fmt);

    // Request buffers
    v4l2_requestbuffers req{};
    req.count = REQ_BUFFER_COUNT;
    req.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    req.memory = V4L2_MEMORY_MMAP;
    xioctl(fd, VIDIOC_REQBUFS, &req);
    if (req.count < 2) {
        std::cerr << "Insufficient buffer memory\n";
        close(fd);
        return 1;
    }

    // Map buffers
    std::vector<Buffer> buffers(req.count);
    for (unsigned i = 0; i < (unsigned)req.count; ++i) {
        v4l2_buffer buf{};
        buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
        buf.memory = V4L2_MEMORY_MMAP;
        buf.index = i;
        xioctl(fd, VIDIOC_QUERYBUF, &buf);
        buffers[i].length = buf.length;
        buffers[i].start = mmap(NULL, buf.length, PROT_READ | PROT_WRITE, MAP_SHARED, fd, buf.m.offset);
        if (buffers[i].start == MAP_FAILED) {
            perror("mmap");
            close(fd);
            return 1;
        }
    }

    // Queue buffers
    for (unsigned i = 0; i < (unsigned)req.count; ++i) {
        v4l2_buffer buf{};
        buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
        buf.memory = V4L2_MEMORY_MMAP;
        buf.index = i;
        xioctl(fd, VIDIOC_QBUF, &buf);
    }

    // Start streaming
    v4l2_buf_type type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    xioctl(fd, VIDIOC_STREAMON, &type);

    // Load Haar cascade
    if (!faceCascade.load("haarcascade_frontalface_default.xml")) {
        std::cerr << "[Warning] Could not load haarcascade_frontalface_default.xml. Face detection will be disabled.\n";
    }

    // Frame exchange buffer
    size_t rawSize = WIDTH * HEIGHT;
    LatestFrameBuffer latestBuffer(rawSize);

    // Atomic running flag
    std::atomic<bool> running(true);

    // Start capture thread
    std::thread captureThread(captureThreadFunc, fd, std::cref(buffers), std::ref(latestBuffer), std::ref(running));

    // Start processing/display thread (runs in mainizable/GUI context)
    std::thread processingThread(processingThreadFunc, std::ref(latestBuffer), std::ref(running));

    // Wait for threads
    processingThread.join();
    // When processing stops, notify capture to exit
    running.store(false);
    // Wake capture if waiting
    latestBuffer.notifyStop();
    captureThread.join();

    // Stop streaming and cleanup
    xioctl(fd, VIDIOC_STREAMOFF, &type);
    for (auto &b : buffers) {
        munmap(b.start, b.length);
    }
    close(fd);

    return 0;
}

