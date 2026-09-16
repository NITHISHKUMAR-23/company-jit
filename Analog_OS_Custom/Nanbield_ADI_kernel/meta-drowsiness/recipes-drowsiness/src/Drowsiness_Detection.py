import cv2
import mediapipe as mp
from scipy.spatial import distance as dist
import numpy as np
import subprocess
import time

# ===== Thresholds =====
EAR_THRESH = 0.25
MAR_THRESH = 0.65
BLINK_DURATION = 0.2  # seconds per blink
HEAD_POSE_YAW_THRESH = 25
HEAD_POSE_PITCH_THRESH = 20

# ===== Mediapipe setup =====
mp_face_mesh = mp.solutions.face_mesh
face_mesh = mp_face_mesh.FaceMesh(static_image_mode=False, max_num_faces=1)

# ===== Helper functions =====
def eye_aspect_ratio(eye):
    A = dist.euclidean(eye[1], eye[5])
    B = dist.euclidean(eye[2], eye[4])
    C = dist.euclidean(eye[0], eye[3])
    return (A + B) / (2.0 * C)

def mouth_aspect_ratio(mouth):
    A = dist.euclidean(mouth[1], mouth[6])
    B = dist.euclidean(mouth[2], mouth[5])
    C = dist.euclidean(mouth[0], mouth[3])
    return (A + B) / (2.0 * C)

def estimate_head_pose(landmarks, image_shape):
    image_points = np.array([
        landmarks[1],    # Nose tip
        landmarks[33],   # Left eye
        landmarks[263],  # Right eye
        landmarks[61],   # Left mouth
        landmarks[291],  # Right mouth
        landmarks[199]   # Chin
    ], dtype='double')

    model_points = np.array([
        (0.0, 0.0, 0.0),
        (-30.0, -30.0, -30.0),
        (30.0, -30.0, -30.0),
        (-30.0, 30.0, -30.0),
        (30.0, 30.0, -30.0),
        (0.0, 60.0, -30.0)
    ])

    focal_length = image_shape[1]
    center = (image_shape[1] // 2, image_shape[0] // 2)
    camera_matrix = np.array([
        [focal_length, 0, center[0]],
        [0, focal_length, center[1]],
        [0, 0, 1]
    ], dtype="double")

    dist_coeffs = np.zeros((4, 1))
    success, rotation_vector, translation_vector = cv2.solvePnP(
        model_points, image_points, camera_matrix, dist_coeffs)

    if not success:
        return None

    rotation_matrix, _ = cv2.Rodrigues(rotation_vector)
    proj_matrix = np.hstack((rotation_matrix, translation_vector))
    _, _, _, _, _, _, euler_angles = cv2.decomposeProjectionMatrix(proj_matrix)
    pitch, yaw, roll = [angle[0] for angle in euler_angles]
    return pitch, yaw, roll

# ===== Initialize libcamera-vid subprocess =====
cmd = [
    "libcamera-vid",
    "-t", "0",
    "--inline",
    "--codec", "mjpeg",
    "--width", "640",
    "--height", "480",
    "-o", "-",
]
proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, bufsize=10**8)
bytes_buffer = b""

# ===== Runtime vars =====
eye_closed_start = None
blink_counter = 0
blink_timestamps = []
last_status_update = 0
display_text = "Driver: OK"

print("Camera started. Press 'q' to quit.")

while True:
    # Read MJPEG chunk
    chunk = proc.stdout.read(4096)
    if not chunk:
        break
    bytes_buffer += chunk

    a = bytes_buffer.find(b'\xff\xd8')  # SOI
    b = bytes_buffer.find(b'\xff\xd9')  # EOI
    if a != -1 and b != -1:
        jpg = bytes_buffer[a:b+2]
        bytes_buffer = bytes_buffer[b+2:]

        # Decode JPEG
        frame = cv2.imdecode(np.frombuffer(jpg, dtype=np.uint8), cv2.IMREAD_COLOR)
        if frame is None:
            continue

        frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        results = face_mesh.process(frame_rgb)
        status = []

        if results.multi_face_landmarks:
            for face_landmarks in results.multi_face_landmarks:
                landmarks = [(int(p.x * frame.shape[1]), int(p.y * frame.shape[0]))
                             for p in face_landmarks.landmark]

                # ===== Eye detection =====
                leftEye = [landmarks[i] for i in [33, 160, 158, 133, 153, 144]]
                rightEye = [landmarks[i] for i in [362, 385, 387, 263, 373, 380]]
                ear = (eye_aspect_ratio(leftEye) + eye_aspect_ratio(rightEye)) / 2.0

                if ear < EAR_THRESH:
                    if eye_closed_start is None:
                        eye_closed_start = time.time()
                    else:
                        closed_duration = time.time() - eye_closed_start
                        if closed_duration >= 0.5:  # Require eyes closed > 0.5s
                            status.append("Eyes Closed")
                else:
                    if eye_closed_start is not None:
                        blink_duration = time.time() - eye_closed_start
                        if blink_duration <= BLINK_DURATION:
                            blink_counter += 1
                            blink_timestamps.append(time.time())
                    eye_closed_start = None

                # ===== Yawning detection =====
                mouth = [landmarks[i] for i in [78, 81, 13, 311, 308, 402, 14, 87]]
                mar = mouth_aspect_ratio(mouth)
                if mar > MAR_THRESH:
                    status.append("Yawning")

                # ===== Head pose =====
                try:
                    pitch, yaw, roll = estimate_head_pose(landmarks, frame.shape)
                    if yaw > HEAD_POSE_YAW_THRESH:
                        status.append("Looking Left")
                    elif yaw < -HEAD_POSE_YAW_THRESH:
                        status.append("Looking Right")
                    if pitch > HEAD_POSE_PITCH_THRESH:
                        status.append("Looking Down")
                    elif pitch < -HEAD_POSE_PITCH_THRESH:
                        status.append("Looking Up")
                except Exception:
                    pass

                # ===== Blink rate (per minute) =====
                # Keep counting but do not show as a warning
                current_time = time.time()
                blink_timestamps = [t for t in blink_timestamps if current_time - t < 60]
                blink_rate = len(blink_timestamps)
                # No status.append("High Blink Rate")

                # ===== Distraction detection =====
                if "Looking Left" in status or "Looking Right" in status or "Looking Down" in status:
                    status.append("Distracted")

        else:
            status.append("NO FACE DETECTED")

        # ===== Update display text every 0.5 sec =====
        now = time.time()
        if now - last_status_update > 0.5:
            display_text = " | ".join(status) if status else "Driver: OK"
            last_status_update = now

        cv2.putText(frame, display_text, (10, 30),
                    cv2.FONT_HERSHEY_SIMPLEX, 0.8, (0, 0, 255), 2)

        cv2.imshow("Driver Monitoring (libcamera-vid)", frame)
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

cv2.destroyAllWindows()
proc.kill()
