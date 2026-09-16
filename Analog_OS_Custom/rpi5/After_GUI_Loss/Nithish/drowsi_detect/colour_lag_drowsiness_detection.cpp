// Compile with:
// g++ -o drowsiness_detection drowsiness_detection.cpp `pkg-config --cflags --libs opencv4` -lopencv_face

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
#include <opencv2/face.hpp>

// --- Buffer structure for mmap ---
struct Buffer {
    void* start;
    size_t length;
};

// --- Safe ioctl wrapper ---
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

// --- Camera configuration (like face blur) ---

// --- Camera configuration (updated for new media device and 1080p resolution) ---
void configureCamera() {
    const char* MEDIA_DEV = "platform:1f00110000.csi";

    // Configure video node format
    system("v4l2-ctl -v width=1920,height=1080,pixelformat=RGGB");

    // Configure CSI2 links and formats
    system("media-ctl -d \"platform:1f00110000.csi\" -V \"'csi2':0 [fmt:SRGGB8_1X8/1920x1080 field:none]\"");
    system("media-ctl -d \"platform:1f00110000.csi\" -V \"'csi2':1 [fmt:SRGGB8_1X8/1920x1080 field:none]\"");
    system("sudo media-ctl -d \"platform:1f00110000.csi\" -l \"'csi2':1 -> 'rp1-cfe-csi2-ch0':0 [1]\"");

    // Configure camera subdevice (IMX219)
    system("media-ctl -d \"platform:1f00110000.csi\" --set-v4l2 '\"imx219 16-0010\":0[fmt:SRGGB8_1X8/1920x1080 field:none]'");

    // Configure serializer (MAX96717)
    system("media-ctl -d \"platform:1f00110000.csi\" --set-v4l2 '\"max96717 15-0040\":1[fmt:SRGGB8_1X8/1920x1080 field:none]'");

    // Configure deserializer (MAX96724)
    system("media-ctl -d \"platform:1f00110000.csi\" --set-v4l2 '\"max96724 10-0027\":6[fmt:UYVY8_1X16/1920x1080 field:none]'");

    // Apply format to video device node
    system("v4l2-ctl -d /dev/video0 --set-fmt-video=width=1920,height=1080,pixelformat=RGGB");

    // Optional camera control parameters (exposure/gain) – adjust as needed
    system("v4l2-ctl -d /dev/v4l-subdev4 --set-ctrl=exposure=1600");
    system("v4l2-ctl -d /dev/v4l-subdev4 --set-ctrl=analogue_gain=100");
    system("v4l2-ctl -d /dev/v4l-subdev4 --set-ctrl=digital_gain=1900");
}

// --- Convert Bayer RGGB to RGB with color balance and gamma correction ---
void unpackBayer8ToRGB(const void* src, void* dst, int width, int height) {
    cv::Mat raw8(height, width, CV_8UC1, const_cast<void*>(src));
    cv::Mat rgb;
    cv::cvtColor(raw8, rgb, cv::COLOR_BayerRG2RGB);

    // Manual color balance
    std::vector<cv::Mat> channels(3);
    cv::split(rgb, channels);
    double redGain = 1.4, greenGain = 1.0, blueGain = 1.7;
    channels[0] *= blueGain;
    channels[1] *= greenGain;
    channels[2] *= redGain;
    cv::merge(channels, rgb);

    // Contrast and gamma correction
    cv::Mat balanced;
    cv::convertScaleAbs(rgb, balanced, 1.2, 5);
    cv::Mat gamma;
    balanced.convertTo(gamma, CV_32F, 1.0 / 255.0);
    cv::pow(gamma, 1.2, gamma);
    gamma.convertTo(rgb, CV_8UC3, 255.0);

    memcpy(dst, rgb.data, width * height * 3);
}

// --- Eye and Mouth Aspect Ratios ---
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

    configureCamera();

    int fd = open(devName, O_RDWR | O_NONBLOCK);
    if (fd < 0) {
        perror("Cannot open device");
        return 1;
    }

    // Set format
    v4l2_format fmt{};
    fmt.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
    fmt.fmt.pix.width = width;
    fmt.fmt.pix.height = height;
    fmt.fmt.pix.pixelformat = v4l2_fourcc('R','G','G','B');
    fmt.fmt.pix.field = V4L2_FIELD_NONE;
    xioctl(fd, VIDIOC_S_FMT, &fmt);

    // Request buffers
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

    // Load models
    cv::CascadeClassifier face_cascade("haarcascade_frontalface_default.xml");
    cv::Ptr<cv::face::Facemark> facemark = cv::face::FacemarkLBF::create();
    facemark->loadModel("lbfmodel.yaml");

    std::vector<unsigned char> rgbBuffer(width * height * 3);
    cv::namedWindow("Drowsiness Detection", cv::WINDOW_AUTOSIZE);

    const double EAR_THRESH = 0.25;
    const double MAR_THRESH = 0.65;
    const double EYE_CLOSED_TIME_THRESH = 1.0;

    bool eyeClosed = false;
    auto eyeClosedStart = std::chrono::steady_clock::now();

    while (true) {
        // Wait for frame
        fd_set fds;
        FD_ZERO(&fds);
        FD_SET(fd, &fds);
        timeval tv = {2, 0};
        int r = select(fd + 1, &fds, NULL, NULL, &tv);
        if (r <= 0) continue;

        // Dequeue buffer
        v4l2_buffer buf{};
        buf.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
        buf.memory = V4L2_MEMORY_MMAP;
        xioctl(fd, VIDIOC_DQBUF, &buf);

        // Convert to RGB
        unpackBayer8ToRGB(buffers[buf.index].start, rgbBuffer.data(), width, height);
        cv::Mat frame(height, width, CV_8UC3, rgbBuffer.data());

        // Detect faces
        cv::Mat gray;
        cv::cvtColor(frame, gray, cv::COLOR_BGR2GRAY);
        std::vector<cv::Rect> faces;
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
                } else {
                    eyeClosed = false;
                }

                if (mar > MAR_THRESH)
                    status = "⚠️ Yawning Detected";

                // Draw face box
                for (const auto& face : faces)
                    cv::rectangle(frame, face, cv::Scalar(0, 0, 255), 2);
            } else {
                status = "Landmarks Not Detected";
            }
        } else {
            status = "No Face Detected";
        }

        cv::putText(frame, status, cv::Point(10, 30),
                    cv::FONT_HERSHEY_SIMPLEX, 0.8, cv::Scalar(0, 255, 255), 2);
        cv::imshow("Drowsiness Detection", frame);

        if (cv::waitKey(1) == 27) break; // ESC to exit

        // Requeue buffer
        xioctl(fd, VIDIOC_QBUF, &buf);
    }

    xioctl(fd, VIDIOC_STREAMOFF, &type);
    for (auto& b : buffers)
        munmap(b.start, b.length);
    close(fd);
    cv::destroyAllWindows();

    return 0;
}


