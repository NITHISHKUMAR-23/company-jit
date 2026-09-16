import cv2
import subprocess
import numpy as np
import sys
import os

# --- Helper to get resource path (works in PyInstaller and source) ---
def resource_path(relative_path):
    """Get absolute path to resource, works for PyInstaller bundle or source."""
    if getattr(sys, 'frozen', False):  # Running from PyInstaller
        base_path = sys._MEIPASS
    else:
        base_path = os.path.abspath(".")
    return os.path.join(base_path, relative_path)

# --- Load Haar Cascade ---
xml_path = resource_path("haarcascade_frontalface_default.xml")
face_cascade = cv2.CascadeClassifier(xml_path)

# --- Start libcamera-vid process (streaming MJPEG to stdout) ---
cmd = [
    "libcamera-vid",
    "-t", "0",                  # run until stopped
    "--inline",                 # needed for MJPEG streaming
    "--codec", "mjpeg",
    "--width", "640",
    "--height", "480",
    "-o", "-",                  # output to stdout
]
proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, bufsize=10**8)

bytes_buffer = b""
frame_count = 0
detect_interval = 3
faces = []

while True:
    # Read chunk from libcamera
    chunk = proc.stdout.read(4096)
    if not chunk:
        break
    bytes_buffer += chunk

    # Look for JPEG start/end markers
    a = bytes_buffer.find(b'\xff\xd8')  # SOI
    b = bytes_buffer.find(b'\xff\xd9')  # EOI
    if a != -1 and b != -1:
        jpg = bytes_buffer[a:b+2]
        bytes_buffer = bytes_buffer[b+2:]

        # Decode JPEG
        frame_full = cv2.imdecode(np.frombuffer(jpg, dtype=np.uint8), cv2.IMREAD_COLOR)
        if frame_full is None:
            continue

        # Downscale for faster face detection
        frame_lores = cv2.resize(frame_full, (320, 240))
        gray = cv2.cvtColor(frame_lores, cv2.COLOR_BGR2GRAY)

        # Detect faces every N frames
        if frame_count % detect_interval == 0:
            faces = face_cascade.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=4)

        # Scale factor from lores → full frame
        scale_x = frame_full.shape[1] / frame_lores.shape[1]
        scale_y = frame_full.shape[0] / frame_lores.shape[0]

        # Apply Gaussian blur + green box
        for (x, y, w, h) in faces:
            pad_w = int(w * 0.15)
            pad_h = int(h * 0.8)
            y_shift = int(h * 0.1)

            # Scale back to full frame
            x1 = max(0, int((x - pad_w) * scale_x))
            y1 = max(0, int((y - pad_h + y_shift) * scale_y))
            x2 = min(frame_full.shape[1], int((x + w + pad_w) * scale_x))
            y2 = min(frame_full.shape[0], int((y + h + pad_h + y_shift) * scale_y))

            # Apply blur
            face_region = frame_full[y1:y2, x1:x2]
            if face_region.size > 0:
                face_region = cv2.GaussianBlur(face_region, (99, 99), 30)
                frame_full[y1:y2, x1:x2] = face_region

                # Green rectangle
                cv2.rectangle(frame_full, (x1, y1), (x2, y2), (0, 255, 0), 2)

        cv2.imshow("Face Blur Live", frame_full)
        frame_count += 1

        if cv2.waitKey(1) & 0xFF == ord("q"):
            break