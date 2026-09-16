import os
import time
import cv2
import numpy as np
import threading
import ctypes
import struct
import fcntl
import mmap

# V4L2 Constants
VIDIOC_S_FMT      = 0xc0d05605
VIDIOC_REQBUFS    = 0xc0145608
VIDIOC_QUERYBUF   = 0xc0585609
VIDIOC_QBUF       = 0xc058560f
VIDIOC_DQBUF      = 0xc0585611
VIDIOC_STREAMON   = 0x40045612
VIDIOC_STREAMOFF  = 0x40045613
V4L2_BUF_TYPE_VIDEO_CAPTURE = 1
V4L2_MEMORY_MMAP            = 1
V4L2_PIX_FMT_SRGGB8         = 0x42474752

class v4l2_pix_format(ctypes.Structure):
    _fields_ = [('width', ctypes.c_uint32), ('height', ctypes.c_uint32),
                ('pixelformat', ctypes.c_uint32), ('field', ctypes.c_uint32),
                ('bytesperline', ctypes.c_uint32), ('sizeimage', ctypes.c_uint32),
                ('colorspace', ctypes.c_uint32), ('priv', ctypes.c_uint32),
                ('flags', ctypes.c_uint32), ('ycbcr_enc', ctypes.c_uint32),
                ('quantization', ctypes.c_uint32), ('xfer_func', ctypes.c_uint32)]

class v4l2_format(ctypes.Structure):
    _fields_ = [('type', ctypes.c_uint32), ('pad', ctypes.c_uint32),
                ('pix', v4l2_pix_format), ('raw_data', ctypes.c_uint8 * 200)]

class v4l2_requestbuffers(ctypes.Structure):
    _fields_ = [('count', ctypes.c_uint32), ('type', ctypes.c_uint32),
                ('memory', ctypes.c_uint32), ('reserved', ctypes.c_uint32 * 2)]

class v4l2_buffer(ctypes.Structure):
    class _u(ctypes.Union):
        _fields_ = [('offset', ctypes.c_uint32), ('userptr', ctypes.c_ulong)]
    _fields_ = [('index', ctypes.c_uint32), ('type', ctypes.c_uint32),
                ('bytesused', ctypes.c_uint32), ('flags', ctypes.c_uint32),
                ('field', ctypes.c_uint32), ('pad', ctypes.c_uint32),
                ('timestamp', ctypes.c_int64 * 2), ('timecode', ctypes.c_uint32 * 4),
                ('sequence', ctypes.c_uint32), ('memory', ctypes.c_uint32),
                ('m', _u), ('length', ctypes.c_uint32),
                ('reserved2', ctypes.c_uint32), ('reserved', ctypes.c_uint32)]

class ColorCorrector:
    _lut = None
    @classmethod
    def get_lut(cls):
        if cls._lut is not None: return cls._lut
        
        # EXACT LOGIC FROM REFERENCE:
        # B_Gain: 1.6, G_Gain: 1.0, R_Gain: 1.3
        # Contrast (Alpha): 1.2, Brightness (Beta): 10
        # Gamma: 1.2 (Inverse 1/1.2)
        lut = np.zeros((1, 256, 3), dtype=np.uint8)
        gains = [1.6, 1.0, 1.3] # Blue, Green, Red
        alpha = 1.2
        beta = 10
        inv_gamma = 1.0 / 1.2

        for i in range(256):
            for c in range(3):
                # 1. Apply Gains
                val = i * gains[c]
                # 2. Apply Brightness/Contrast (convertScaleAbs logic)
                val = (val * alpha) + beta
                val = np.clip(val, 0, 255)
                # 3. Apply Gamma Curve
                val = pow(val / 255.0, inv_gamma) * 255.0
                lut[0, i, c] = int(np.clip(val, 0, 255))
        
        cls._lut = lut
        return cls._lut

    @staticmethod
    def apply(image_bgr):
        return cv2.LUT(image_bgr, ColorCorrector.get_lut())

class V4L2CameraThreaded:
    def __init__(self, device_path, width, height, output_w, output_h):
        self.device_path = device_path
        self.width, self.height = width, height
        self.out_w, self.out_h = output_w, output_h
        self.stopped, self.frame, self.new_frame_available = False, None, False
        self.lock = threading.Lock()
        self.mmaps = []

        try:
            self.fd = os.open(device_path, os.O_RDWR)
            self._set_format()
            self._init_buffers()
            self._stream_on()
        except OSError:
            self.stopped = True

    def _set_format(self):
        fmt = v4l2_format(type=V4L2_BUF_TYPE_VIDEO_CAPTURE)
        fmt.pix.width, fmt.pix.height = self.width, self.height
        fmt.pix.pixelformat = V4L2_PIX_FMT_SRGGB8
        fmt.pix.field = 0
        fcntl.ioctl(self.fd, VIDIOC_S_FMT, fmt)
        self.buffer_size = fmt.pix.sizeimage

    def _init_buffers(self):
        req = v4l2_requestbuffers(count=2, type=V4L2_BUF_TYPE_VIDEO_CAPTURE, memory=V4L2_MEMORY_MMAP)
        fcntl.ioctl(self.fd, VIDIOC_REQBUFS, req)
        for i in range(req.count):
            buf = v4l2_buffer(index=i, type=V4L2_BUF_TYPE_VIDEO_CAPTURE, memory=V4L2_MEMORY_MMAP)
            fcntl.ioctl(self.fd, VIDIOC_QUERYBUF, buf)
            mm = mmap.mmap(self.fd, buf.length, flags=mmap.MAP_SHARED, prot=mmap.PROT_READ, offset=buf.m.offset)
            self.mmaps.append(mm)
            fcntl.ioctl(self.fd, VIDIOC_QBUF, buf)

    def _stream_on(self):
        fcntl.ioctl(self.fd, VIDIOC_STREAMON, struct.pack('I', V4L2_BUF_TYPE_VIDEO_CAPTURE))

    def start(self):
        threading.Thread(target=self.update, daemon=True).start()
        return self

    def update(self):
        buf = v4l2_buffer(type=V4L2_BUF_TYPE_VIDEO_CAPTURE, memory=V4L2_MEMORY_MMAP)
        while not self.stopped:
            try:
                fcntl.ioctl(self.fd, VIDIOC_DQBUF, buf)
                raw = np.frombuffer(self.mmaps[buf.index], dtype=np.uint8, count=self.buffer_size)
                raw = raw[:self.width*self.height].reshape((self.height, self.width))
                
                # Use COLOR_BayerBG2BGR as confirmed in your reference
                bgr = cv2.cvtColor(raw, cv2.COLOR_BayerBG2BGR)
                
                if self.out_w != self.width or self.out_h != self.height:
                    bgr = cv2.resize(bgr, (self.out_w, self.out_h), interpolation=cv2.INTER_NEAREST)

                with self.lock:
                    self.frame = bgr
                    self.new_frame_available = True
                fcntl.ioctl(self.fd, VIDIOC_QBUF, buf)
            except: time.sleep(0.001)

    def read_latest(self):
        with self.lock:
            if not self.new_frame_available: return None
            self.new_frame_available = False
            return self.frame.copy()

    def stop(self):
        self.stopped = True
        try: fcntl.ioctl(self.fd, VIDIOC_STREAMOFF, struct.pack('I', V4L2_BUF_TYPE_VIDEO_CAPTURE))
        except: pass
        for mm in self.mmaps: mm.close()
        try: os.close(self.fd)
        except: pass