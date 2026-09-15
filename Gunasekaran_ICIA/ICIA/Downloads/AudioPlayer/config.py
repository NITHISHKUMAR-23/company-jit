# ==========================
# Kodi Configuration
# ==========================

KODI_URL = "http://localhost:8080/jsonrpc"

KODI_USERNAME = "kodi"

KODI_PASSWORD = "kodi123"

# ==========================
# Kodi Startup
# ==========================

KODI_AE_SINK = "ALSA"

ALSA_BUFFER_SIZE = "16384"

# ==========================
# Audio Folder
# ==========================

AUDIO_FOLDER = "/home/jasminuser/dolby"


# ==========================
# Supported Extensions
# ==========================

SUPPORTED_EXTENSIONS = (
    ".mkv",
    ".eac3"
)
# ==========================
# Timing Configuration
# ==========================

KODI_STARTUP_TIMEOUT = 5

KODI_MONITOR_INTERVAL = 3

PLAYBACK_MONITOR_INTERVAL = 1

# ==========================
# Network
# ==========================

REQUEST_TIMEOUT = 5
timeout=REQUEST_TIMEOUT

# ==========================
# Flask
# ==========================

HOST = "0.0.0.0"

PORT = 5600

DEBUG = True