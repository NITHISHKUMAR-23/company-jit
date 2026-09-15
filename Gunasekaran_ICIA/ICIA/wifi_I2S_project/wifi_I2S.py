cat > wifi_I2S.py << 'EOF'
from flask import Flask, request
import os

app = Flask(__name__)

HTML_PAGE = """
<!doctype html>
<html>
<body>

<h2>Upload Audio File</h2>

<form method="POST" action="/upload" enctype="multipart/form-data">
    <input type="file" name="file">
    <input type="submit" value="Upload">
</form>

</body>
</html>
"""

@app.route('/')
def index():
    return HTML_PAGE

@app.route('/upload', methods=['POST'])
def upload():

    file = request.files['file']

    filename = file.filename

    file.save(filename)

    print("Received:", filename)

    os.system(f'ffplay -nodisp -autoexit "{filename}"')

    return f"{filename} played successfully"

app.run(host='0.0.0.0', port=5050)
EOF
