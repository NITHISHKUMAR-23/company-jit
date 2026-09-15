from flask import Flask, render_template_string, redirect, url_for
import subprocess

app = Flask(__name__)

# HTML template with Bootstrap styling
HTML_TEMPLATE = """
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Service Toggle</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
      body {
        background: linear-gradient(to right, #6a11cb, #2575fc);
        color: white;
        min-height: 100vh;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      }
      .card {
        background: rgba(0,0,0,0.6);
        padding: 2rem;
        border-radius: 1rem;
        text-align: center;
      }
      .btn-toggle {
        width: 200px;
        font-size: 1.2rem;
      }
      .status {
        font-weight: bold;
        font-size: 1.3rem;
      }
      @media (max-width: 768px) {
        .btn-toggle {
          width: 100%;
        }
      }
    </style>
  </head>
  <body>
    <div class="card shadow-lg">
      <h1 class="mb-4">Service Toggle</h1>
      <p>Current Active Service:</p>
      {% if active_service == 'RPI_MUTE.service' %}
        <p class="status text-success">{{ active_service }}</p>
      {% elif active_service == 'Demo_App_ACS.service' %}
        <p class="status text-warning">{{ active_service }}</p>
      {% else %}
        <p class="status text-danger">None</p>
      {% endif %}
      <form method="POST" action="/toggle">
          <button type="submit" class="btn btn-primary btn-toggle mt-3">Toggle Service</button>
      </form>
    </div>
  </body>
</html>
"""

SERVICE1 = "RPI_MUTE.service"
SERVICE2 = "Demo_App_ACS.service"

def get_active_service():
    """Return the currently active service name, or 'None'"""
    if subprocess.run(["systemctl", "is-active", "--quiet", SERVICE1]).returncode == 0:
        return SERVICE1
    elif subprocess.run(["systemctl", "is-active", "--quiet", SERVICE2]).returncode == 0:
        return SERVICE2
    else:
        return "None"

@app.route('/')
def index():
    active_service = get_active_service()
    return render_template_string(HTML_TEMPLATE, active_service=active_service)

@app.route('/toggle', methods=['POST'])
def toggle():
    try:
        subprocess.run(['/home/jasminuser/Desktop/toggle_app/toggle_service.sh'], check=True)
        return redirect(url_for('index'))
    except subprocess.CalledProcessError as e:
        return f"Error toggling service: {e}", 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=7000)
