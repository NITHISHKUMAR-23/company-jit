#include <cstddef> // for size_t
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <linux/videodev2.h>
#include <errno.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include <iostream>
#include <vector>
#include <fstream>
#include <string>

#include <opencv2/opencv.hpp>
#include <opencv2/dnn.hpp>

// ====== Model configuration ======
const std::string modelConfiguration = "/home/rpi/Desktop/object_detection/models/ssd_mobilenet_v1_coco.pbtxt";
const std::string modelWeights = "/home/rpi/Desktop/object_detection/models/frozen_inference_graph.pb";
const std::string classNamesFile = "/home/rpi/Desktop/object_detection/models/coco.names";
const float confidenceThreshold = 0.6f;

// ====== Global objects ======
std::vector<std::string> classNamesVec;
cv::dnn::Net net;

struct Buffer {
    void* start;
    size_t length;
};

// ====== Safe ioctl wrapper ======
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

// ====== Camera Configuration ======
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
    cmd = std::string("v4l2-ctl -d ") + sensorSubdev + " --set-ctrl=exposure=2000";
    system(cmd.c_str());
    cmd = std::string("v4l2-ctl -d ") + sensorSubdev + " --set-ctrl=analogue_gain=100";
    system(cmd.c_str());
    cmd = std::string("v4l2-ctl -d ") + sensorSubdev + " --set-ctrl=digital_gain=1900";
    system(cmd.c_str());
}

// ====== Bayer to RGB conversion with color balance and gamma ======
void unpackBayer8ToRGB(const void* src, void* dst, int width, int height) {
    cv::Mat raw8(height, width, CV_8UC1, const_cast<void*>(src));
    cv::Mat rgb;
    cv::cvtColor(raw8, rgb, cv::COLOR_BayerRG2RGB);

    // Color balance
    std::vector<cv::Mat> channels(3);
    cv::split(rgb, channels);
    double redGain = 1.4, greenGain = 1.0, blueGain = 1.7;
    channels[0] *= blueGain;
    channels[1] *= greenGain;
    channels[2] *= redGain;
    cv::merge(channels, rgb);

    // Contrast & gamma
    cv::Mat balanced;
    cv::convertScaleAbs(rgb, balanced, 1.2, 5);
    cv::Mat gamma;
    balanced.convertTo(gamma, CV_32F, 1.0 / 255.0);
    cv::pow(gamma, 1.2, gamma);
    gamma.convertTo(rgb, CV_8UC3, 255.0);

    memcpy(dst, rgb.data, width * height * 3);
}

// ====== Load class names ======
void loadClassNames() {
    std::ifstream ifs(classNamesFile.c_str());
    if (!ifs.is_open()) {
        std::cerr << "ERROR: Failed to open " << classNamesFile << std::endl;
        exit(EXIT_FAILURE);
    }
    std::string line;
    while (std::getline(ifs, line))
        classNamesVec.push_back(line);
}

// ====== Initialize DNN model ======
void initializeObjectDetector() {
    net = cv::dnn::readNetFromTensorflow(modelWeights, modelConfiguration);
    if (net.empty()) {
        std::cerr << "ERROR: Failed to load DNN model from "
                  << modelConfiguration << " and " << modelWeights << std::endl;
        exit(EXIT_FAILURE);
    }
    net.setPreferableBackend(cv::dnn::DNN_BACKEND_OPENCV);
    net.setPreferableTarget(cv::dnn::DNN_TARGET_CPU);
    loadClassNames();
}

// ====== Run detection and draw boxes ======
void detectObjects(cv::Mat& frame) {
    cv::Mat blob;
    cv::dnn::blobFromImage(frame, blob, 1.0 / 255.0, cv::Size(300, 300), cv::Scalar(), true, CV_8U);
    net.setInput(blob);
    cv::Mat detections = net.forward();

    if (detections.dims == 4)
        detections = detections.reshape(1, detections.size[2]);

    int cols = frame.cols;
    int rows = frame.rows;

    for (int i = 0; i < detections.rows; ++i) {
        float confidence = detections.at<float>(i, 2);
        if (confidence > confidenceThreshold) {
            int classId = static_cast<int>(detections.at<float>(i, 1));
            float x_min = detections.at<float>(i, 3);
            float y_min = detections.at<float>(i, 4);
            float x_max = detections.at<float>(i, 5);
            float y_max = detections.at<float>(i, 6);

            int x1 = static_cast<int>(x_min * cols);
            int y1 = static_cast<int>(y_min * rows);
            int x2 = static_cast<int>(x_max * cols);
            int y2 = static_cast<int>(y_max * rows);

            x1 = std::max(0, std::min(x1, cols - 1));
            y1 = std::max(0, std::min(y1, rows - 1));
            x2 = std::max(0, std::min(x2, cols - 1));
            y2 = std::max(0, std::min(y2, rows - 1));

            cv::Rect rect(x1, y1, x2 - x1, y2 - y1);
            cv::rectangle(frame, rect, cv::Scalar(0, 255, 0), 2);

            if (classId < classNamesVec.size()) {
                std::string label = classNamesVec[classId] + ": " + cv::format("%.2f", confidence);
                int baseLine = 0;
                cv::Size labelSize = cv::getTextSize(label, cv::FONT_HERSHEY_SIMPLEX, 0.5, 1, &baseLine);
                int top = std::max(y1, labelSize.height);
                cv::rectangle(frame, cv::Point(x1, top - labelSize.height),
                              cv::Point(x1 + labelSize.width, top + baseLine),
                              cv::Scalar(255, 255, 255), cv::FILLED);
                cv::putText(frame, label, cv::Point(x1, top),
                            cv::FONT_HERSHEY_SIMPLEX, 0.5, cv::Scalar(0, 0, 0), 1);
            }
        }
    }
}

// ====== Main Loop ======
int main() {
    const char* devName = "/dev/video0";
    const int width = 640;
    const int height = 480;

    configureCamera();
    initializeObjectDetector();

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
            perror("mmap failed");
            exit(EXIT_FAILURE);
        }
        xioctl(fd, VIDIOC_QBUF, &buf);
    }

    v4l2_buf_type type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    xioctl(fd, VIDIOC_STREAMON, &type);

    std::vector<unsigned char> rgbBuffer(width * height * 3);
    cv::namedWindow("Object Detection", cv::WINDOW_AUTOSIZE);

    while (true) {
        fd_set fds;
        FD_ZERO(&fds);
        FD_SET(fd, &fds);
        timeval tv = {1, 0};
        int r = select(fd + 1, &fds, NULL, NULL, &tv);
        if (r <= 0) {
            if (r < 0 && errno != EINTR) perror("select");
            continue;
        }

        v4l2_buffer buf{};
        buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
        buf.memory = V4L2_MEMORY_MMAP;
        xioctl(fd, VIDIOC_DQBUF, &buf);

        unpackBayer8ToRGB(buffers[buf.index].start, rgbBuffer.data(), width, height);
        cv::Mat frame(height, width, CV_8UC3, rgbBuffer.data());

        detectObjects(frame);
        cv::imshow("Object Detection", frame);

        if (cv::waitKey(1) == 27) break; // ESC

        xioctl(fd, VIDIOC_QBUF, &buf);
    }

    xioctl(fd, VIDIOC_STREAMOFF, &type);
    for (auto& b : buffers)
        munmap(b.start, b.length);
    close(fd);
    cv::destroyAllWindows();
    return 0;
}
