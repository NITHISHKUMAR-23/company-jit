import cv2
import numpy as np
import os

# Load trained face recognition model
recognizer = cv2.face.LBPHFaceRecognizer_create()
recognizer.read('face_model.yml')

# Load label names
label_map = np.load('labels.npy', allow_pickle=True).item()
label_names = {v: k for k, v in label_map.items()}

# Load Haar cascade for face detection
face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')

# Open camera (0 = default camera)
cap = cv2.VideoCapture(0)

if not cap.isOpened():
    print("❌ Could not access camera.")
    exit()

print("✅ Camera started. Press 'q' to quit.\n")

while True:
    ret, frame = cap.read()
    if not ret:
        print("⚠️ Frame capture failed.")
        break

    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    faces = face_cascade.detectMultiScale(gray, 1.3, 5)

    for (x, y, w, h) in faces:
        roi_gray = gray[y:y+h, x:x+w]
        id_, confidence = recognizer.predict(roi_gray)
        name = label_names.get(id_, "Unknown")
        cv2.rectangle(frame, (x, y), (x+w, y+h), (0, 255, 0), 2)
        cv2.putText(frame, f"{name} ({int(confidence)})", (x, y-10),
                    cv2.FONT_HERSHEY_SIMPLEX, 0.8, (255, 255, 255), 2)

    cv2.imshow('Face Recognition', frame)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()
