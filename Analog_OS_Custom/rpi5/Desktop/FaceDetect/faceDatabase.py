import os
import cv2
import numpy as np
from collections import Counter

dataset_path = "dataset"
face_cascade = cv2.CascadeClassifier(
    "opencv_haarcascades/haarcascade_frontalface_default.xml")

faces = []
labels = []
label_map = {}
current_label = 0

for person_name in os.listdir(dataset_path):
    person_path = os.path.join(dataset_path, person_name)
    if not os.path.isdir(person_path):
        continue

    label_map[current_label] = person_name

    for image_file in os.listdir(person_path):
        if not image_file.lower().endswith((".jpg", ".png", ".jpeg")):
            continue

        img_path = os.path.join(person_path, image_file)
        img = cv2.imread(img_path, cv2.IMREAD_GRAYSCALE)
        if img is None:
            continue

        detected_faces = face_cascade.detectMultiScale(img, 1.1, 5)
        for (x, y, w, h) in detected_faces:
            # Resize ROI to fixed size
            face_roi = cv2.resize(img[y:y+h, x:x+w], (200, 200))
            faces.append(face_roi)
            labels.append(current_label)

    current_label += 1

# 🔹 Keep faces as a list of np.uint8 arrays
# 🔹 Convert labels to int32 numpy array
labels = np.array(labels, dtype=np.int32)

recognizer = cv2.face.LBPHFaceRecognizer_create()


if len(faces) > 0:
    recognizer.train(faces, labels)
    recognizer.save("face_model.yml")
    np.save("labels.npy", label_map)

    print("✅ Training complete.")
    print("📁 Model saved as face_model.yml and labels.npy")

    # 🔹 Print summary
    print("\n--- Training Summary ---")
    counts = Counter(labels)
    for label_id, count in counts.items():
        print(f"👤 {label_map[label_id]} : {count} face samples")
    print(f"\nTotal people trained: {len(label_map)}")
    print(f"Total face samples: {len(faces)}")

else:
    print("⚠️ No faces found in dataset. Training aborted.")
