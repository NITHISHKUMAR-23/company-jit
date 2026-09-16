import cv2
import subprocess
import numpy as np

# Load trained model and labels
recognizer = cv2.face.LBPHFaceRecognizer_create()
recognizer.read("face_model.yml")
labels = np.load("labels.npy", allow_pickle=True).item()

# Haar Cascade
face_cascade = cv2.CascadeClassifier(
    "opencv_haarcascades/haarcascade_frontalface_default.xml")

# Start libcamera-vid
cmd = [
    "libcamera-vid", "-t", "0",
    "--inline", "--codec", "mjpeg",
    "--width", "640", "--height", "480",
    "-o", "-"
]
proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, bufsize=10**8)
bytes_buffer = b""
print("Starting face recognition... Press 'q' to quit")

while True:
    chunk = proc.stdout.read(4096)
    if not chunk:
        break
    bytes_buffer += chunk

    a = bytes_buffer.find(b'\xff\xd8')
    b = bytes_buffer.find(b'\xff\xd9')
    if a != -1 and b != -1:
        jpg = bytes_buffer[a:b+2]
        bytes_buffer = bytes_buffer[b+2:]

        frame = cv2.imdecode(np.frombuffer(jpg, dtype=np.uint8), cv2.IMREAD_COLOR)
        if frame is None:
            continue

        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        faces = face_cascade.detectMultiScale(gray, 1.1, 5)

        for (x, y, w, h) in faces:
            roi_gray = gray[y:y+h, x:x+w]  # raw ROI

            id_, confidence = recognizer.predict(roi_gray)
            print(f"Predicted ID={id_}, Confidence={confidence:.2f}")

            if confidence < 70:   # adjust threshold
                name = labels.get(id_, "Unknown")
            else:
                name = "Unknown"

            cv2.rectangle(frame, (x, y), (x+w, y+h), (255, 0, 0), 2)
            cv2.putText(frame, name, (x, y-10),
                        cv2.FONT_HERSHEY_SIMPLEX, 0.8, (255, 255, 255), 2)

        cv2.imshow("Face Recognition", frame)
        if cv2.waitKey(1) & 0xFF == ord("q"):
            break

cv2.destroyAllWindows()
proc.kill()