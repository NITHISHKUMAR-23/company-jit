from flask import Flask, request
import os
import subprocess

app = Flask(__name__)

UPLOAD_FOLDER = "uploads"
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

HTML_PAGE = '''
<!doctype html>
<html>
<head>
    <title>Audio Upload</title>
</head>
<body>
    <h2>Upload WAV/MP3 File</h2>
    <form method="POST" action="/upload" enctype="multipart/form-data">
        <input type="file" name="file">
        <input type="submit" value="Upload & Play">
    </form>
</body>
</html>
'''

@app.route('/')
def index():
    return HTML_PAGE


@app.route('/upload', methods=['POST'])
def upload():

    file = request.files['file']

    if file.filename == '':
        return "No file selected"

    filepath = os.path.join(UPLOAD_FOLDER, file.filename)
    file.save(filepath)

    print("Received:", filepath)

    # OPTIONAL (recommended): convert to safe Pi format
    safe_file = "/tmp/audio_play.wav"

    subprocess.run([
        "ffmpeg", "-y",
        "-i", filepath,
        "-c:a", "pcm_s32le",
        "-ar", "192000",
        safe_file
    ])

    # PLAY using ALSA plug (fixes all format issues)
    subprocess.run([
        "aplay",
        "-D", "plughw:3,0",
        safe_file
    ])

    return f"{file.filename} played successfully"


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5050)
