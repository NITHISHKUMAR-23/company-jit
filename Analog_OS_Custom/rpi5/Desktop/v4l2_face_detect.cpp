#include <iostream>
#include <vector>
#include <string>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <linux/videodev2.h>
#include <opencv2/opencv.hpp>
#include <errno.h>

struct Buffer {
    void* start;
    size_t length;
};

int xioctl(int fd, int request, void* arg) {
    int r;
    do { r = ioctl(fd, request, arg); } while (r == -1 && errno == EINTR);
    return r;
}

int main() {
    const char* devName = "/dev/video23"; // BE output node
    int fd = open(devName, O_RDWR);
    if (fd < 0) { perror("Cannot open device"); return 1; }

    // --- Step 1: Detect capture type (single vs multiplanar)
    v4l2_capability cap{};
    if (xioctl(fd, VIDIOC_QUERYCAP, &cap) < 0) {
        perror("QueryCap");
        return 1;
    }
    bool isMultiPlanar = (cap.capabilities & V4L2_CAP_VIDEO_CAPTURE_MPLANE);

    // --- Step 2: Set video format ---
    v4l2_format fmt{};
    fmt.type = isMultiPlanar ? V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE : V4L2_BUF_TYPE_VIDEO_CAPTURE;
    fmt.fmt.pix.width = 1920;
    fmt.fmt.pix.height = 1080;
    fmt.fmt.pix.pixelformat = V4L2_PIX_FMT_RGB24; // try RGB3 first
    fmt.fmt.pix.field = V4L2_FIELD_NONE;

    if (xioctl(fd, VIDIOC_S_FMT, &fmt) < 0) {
        perror("Set Format (RGB24 failed), fallback to YUYV");
        fmt.fmt.pix.pixelformat = V4L2_PIX_FMT_YUYV;
        if (xioctl(fd, VIDIOC_S_FMT, &fmt) < 0) {
            perror("Set Format (YUYV failed), fallback to NV12");
            fmt.fmt.pix.pixelformat = V4L2_PIX_FMT_NV12;
            if (xioctl(fd, VIDIOC_S_FMT, &fmt) < 0) {
                perror("All format attempts failed");
                return 1;
            }
        }
    }

    std::cout << "Camera Format: " 
              << (char*)&fmt.fmt.pix.pixelformat << " "
              << fmt.fmt.pix.width << "x" << fmt.fmt.pix.height << std::endl;

    // --- Step 3: Request Buffers ---
    v4l2_requestbuffers req{};
    req.count = 4;
    req.type = fmt.type;
    req.memory = V4L2_MEMORY_MMAP;
    if (xioctl(fd, VIDIOC_REQBUFS, &req) < 0) {
        perror("Request Buffers");
        return 1;
    }

    std::vector<Buffer> buffers(req.count);
    for (unsigned i = 0; i < req.count; i++) {
        v4l2_buffer buf{};
        buf.type = fmt.type;
        buf.memory = V4L2_MEMORY_MMAP;
        buf.index = i;
        if (isMultiPlanar) {
            v4l2_plane planes[VIDEO_MAX_PLANES]{};
            buf.m.planes = planes;
            buf.length = 1;
        }
        xioctl(fd, VIDIOC_QUERYBUF, &buf);
        size_t length = isMultiPlanar ? buf.m.planes[0].length : buf.length;
        size_t offset = isMultiPlanar ? buf.m.planes[0].m.mem_offset : buf.m.offset;
        buffers[i].length = length;
        buffers[i].start = mmap(NULL, length, PROT_READ | PROT_WRITE, MAP_SHARED, fd, offset);
    }

    // --- Step 4: Queue all buffers ---
    for (unsigned i = 0; i < req.count; i++) {
        v4l2_buffer buf{};
        buf.type = fmt.type;
        buf.memory = V4L2_MEMORY_MMAP;
        buf.index = i;
        if (isMultiPlanar) {
            v4l2_plane planes[VIDEO_MAX_PLANES]{};
            buf.m.planes = planes;
            buf.length = 1;
        }
        xioctl(fd, VIDIOC_QBUF, &buf);
    }

    // --- Step 5: Start streaming ---
    //v4l2_buf_type type = fmt.type;
    v4l2_buf_type type = static_cast<v4l2_buf_type>(fmt.type);
    if (xioctl(fd, VIDIOC_STREAMON, &type) < 0) {
        perror("Start Capture");
        return 1;
    }
    std::cout << "✅ Streaming started on " << devName << std::endl;

    // --- Step 6: Capture frames and show using OpenCV ---
    for (int frameCount = 0; frameCount < 100; frameCount++) {
        v4l2_buffer buf{};
        buf.type = fmt.type;
        buf.memory = V4L2_MEMORY_MMAP;
        if (isMultiPlanar) {
            v4l2_plane planes[VIDEO_MAX_PLANES]{};
            buf.m.planes = planes;
            buf.length = 1;
        }

        if (xioctl(fd, VIDIOC_DQBUF, &buf) < 0) { perror("DQBUF"); continue; }

        cv::Mat frame(fmt.fmt.pix.height, fmt.fmt.pix.width, CV_8UC3, buffers[buf.index].start);
        cv::imshow("Live Feed", frame);
        if (cv::waitKey(1) == 27) break; // ESC to exit

        if (xioctl(fd, VIDIOC_QBUF, &buf) < 0) perror("QBUF");
    }

    // --- Step 7: Cleanup ---
    //type = fmt.type;
    type = static_cast<v4l2_buf_type>(fmt.type);
    xioctl(fd, VIDIOC_STREAMOFF, &type);
    for (auto &b : buffers) munmap(b.start, b.length);
    close(fd);
    std::cout << "Stream stopped and cleaned up.\n";
    return 0;
}
