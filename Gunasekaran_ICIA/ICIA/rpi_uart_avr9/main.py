from flask import Flask, request, render_template, jsonify
import serial
import subprocess
import socket
import time
from flask_cors import CORS

# ---------- Serial ----------
ser = serial.Serial(
    port='/dev/ttyUSB0',
    baudrate=115200,
    bytesize=8,
    parity='N',
    stopbits=1,
    timeout=2
)

# ---------- Flask ----------
app = Flask(__name__, static_folder='static')
CORS(app)

# -----------------------------------------------------------------------
# Command constants  (from old working code — unchanged)
# -----------------------------------------------------------------------
CMD_MUTE         = "0x20000023"
CMD_VOL_APPLY    = "0x20000022"
CMD_MUTE_ENABLE  = "0x20010040"
CMD_MUTE_DISABLE = "0x20010080"
CMD_BAL          = 0x06
CMD_FADE         = 0x07

# -----------------------------------------------------------------------
# Dirac / DCX command switch  (Feature #1 — existing, unchanged)
# -----------------------------------------------------------------------
CMD_DIRAC_DCX    = "0x20000024"
CMD_DIRAC_DATA   = "0x20010000"
CMD_DCX_DATA     = "0x20010001"

# -----------------------------------------------------------------------
# NEW Feature #2 — DCX Configuration switch
# Command ID : 0x20000025
# 7.1.4 ch   : 0x20010001  (default ON state)
# 5.1.2 ch   : 0x20010000
# -----------------------------------------------------------------------
CMD_DCX_CONFIG       = "0x20000025"
CMD_DCX_CONFIG_7_1_4 = "0x20010001"   # default
CMD_DCX_CONFIG_5_1_2 = "0x20010000"

# -----------------------------------------------------------------------
# NEW Feature #3 — App Toggle (service switching)
# Maps to the same services used in the standalone toggle_app
# -----------------------------------------------------------------------
SERVICE_DCX   = "RPI_MUTE.service"
SERVICE_DIRAC = "Demo_App_ACS.service"

# Local TCP ports each app's Flask server listens on once fully started.
# Used only as a readiness probe — not assumed for any other purpose.
PORT_DCX   = 5700   # this app's own Flask port (see app.run below)
PORT_DIRAC = 5000   # Demo_App_v3.0.1 main.py: app.run(..., port=5000)

# Max time (seconds) to wait for a service to report active + port open
# before giving up and returning a failure response.
TOGGLE_READY_TIMEOUT = 20
TOGGLE_POLL_INTERVAL = 0.5


# -----------------------------------------------------------------------
# Helpers
# -----------------------------------------------------------------------
def write_line(cmd_str: str):
    """Write an ASCII hex command followed by CR to UART."""
    ser.write((cmd_str + '\r').encode('utf-8'))


def spk_on_off_cmd(spk_index: int, enable: bool) -> str:
    """
    Build per-speaker mute command string.
      enable  (mute ON) : 0x20010000 + (spk_index - 1)
      disable (mute OFF): 0x20010020 + (spk_index - 1)
    """
    base = 0x20010000 if enable else 0x20010020
    return "0x{:08X}".format(base + (spk_index - 1))


def clamp(v, lo, hi):
    return max(lo, min(hi, v))


def get_active_service():
    """Return the currently active service: 'dcx', 'dirac', or 'none'."""
    if subprocess.run(["systemctl", "is-active", "--quiet", SERVICE_DCX]).returncode == 0:
        return "dcx"
    elif subprocess.run(["systemctl", "is-active", "--quiet", SERVICE_DIRAC]).returncode == 0:
        return "dirac"
    return "none"


def is_service_active(service_name: str) -> bool:
    """Wrapper around `systemctl is-active --quiet <service>`."""
    return subprocess.run(
        ["systemctl", "is-active", "--quiet", service_name]
    ).returncode == 0


def is_port_open(port: int, host: str = "127.0.0.1", timeout: float = 1.0) -> bool:
    """Check whether something is listening on the given local TCP port."""
    try:
        with socket.create_connection((host, port), timeout=timeout):
            return True
    except OSError:
        return False


def wait_until_ready(service_name: str, port: int, timeout: float = TOGGLE_READY_TIMEOUT) -> bool:
    """
    Block (server-side, not the whole UI) until the target service is both:
      1. reported active by systemd, and
      2. actually accepting connections on its Flask port.

    For DIRAC this also covers the acs -> Flask startup chain in
    start_both_codes.sh, since the Flask port only opens once main.py
    (which runs after the acs process and its `sleep`) has fully started.
    Returns True if ready within `timeout` seconds, False otherwise.
    """
    deadline = time.time() + timeout
    while time.time() < deadline:
        if is_service_active(service_name) and is_port_open(port):
            return True
        time.sleep(TOGGLE_POLL_INTERVAL)
    return False


# -----------------------------------------------------------------------
# Routes
# -----------------------------------------------------------------------
@app.route('/', methods=['GET'])
def index():
    return render_template('index.html')


# -----------------------------------------------------------------------
# /api/app_status  (GET) — reports which app is actually running right now.
# Frontend calls this on page load so the toggle never assumes a default
# state; it always reflects systemd's truth.
# -----------------------------------------------------------------------
@app.route('/api/app_status', methods=['GET'])
def app_status():
    try:
        active = get_active_service()  # 'dcx' | 'dirac' | 'none'
        return jsonify({"ok": True, "active": active})
    except Exception as e:
        print("[ERROR] app_status: {}".format(e))
        return jsonify({"ok": False, "error": str(e)}), 500


# -----------------------------------------------------------------------
# /api/mute_all  (unchanged)
# -----------------------------------------------------------------------
@app.route('/api/mute_all', methods=['POST'])
def mute_all():
    try:
        data      = request.get_json(force=True) or {}
        toggle_id = str(data.get('toggleId', '')).strip()
        is_checked = data.get('isChecked')

        if isinstance(is_checked, bool):
            pass
        elif isinstance(is_checked, (int, float)):
            is_checked = bool(is_checked)
        elif isinstance(is_checked, str):
            is_checked = is_checked.lower() in ('1', 'true', 'yes', 'on')
        else:
            is_checked = False

        if toggle_id == "mute_all":
            write_line(CMD_MUTE_ENABLE if is_checked else CMD_MUTE_DISABLE)
            write_line(CMD_MUTE)
            print("[MUTE_ALL] {} -> {}".format(
                "ENABLE" if is_checked else "DISABLE",
                CMD_MUTE_ENABLE if is_checked else CMD_MUTE_DISABLE
            ))
            return jsonify({"ok": True, "target": "mute_all", "state": is_checked})

        if toggle_id.startswith("spk"):
            try:
                spk_index = int(toggle_id.replace("spk", ""))
            except ValueError:
                return jsonify({"ok": False, "error": "Invalid speaker id"}), 400
            if not (1 <= spk_index <= 18):
                return jsonify({"ok": False, "error": "Speaker index out of range"}), 400

            cmd = spk_on_off_cmd(spk_index, is_checked)
            write_line(cmd)
            write_line(CMD_MUTE)
            print("[SPK{}] {} -> {}".format(spk_index, "MUTE" if is_checked else "UNMUTE", cmd))
            return jsonify({"ok": True, "target": toggle_id, "state": is_checked, "cmd": cmd})

        return jsonify({"ok": False, "error": "Unknown toggleId: {}".format(toggle_id)}), 400

    except Exception as e:
        print("[ERROR] mute_all: {}".format(e))
        return jsonify({"ok": False, "error": str(e)}), 500


# -----------------------------------------------------------------------
# /api/audio_features  – Dirac / DCX command switch  (Feature #1, unchanged)
# -----------------------------------------------------------------------
@app.route('/api/audio_features', methods=['POST'])
def audio_features():
    try:
        data = request.get_json(force=True) or {}
        mode = str(data.get('mode', '')).strip().lower()

        if mode == "dirac":
            write_line(CMD_DIRAC_DATA)
            write_line(CMD_DIRAC_DCX)
            print("[DIRAC] -> {} {}".format(CMD_DIRAC_DATA, CMD_DIRAC_DCX))
            return jsonify({"ok": True, "mode": "dirac"})

        elif mode == "dcx":
            write_line(CMD_DCX_DATA)
            write_line(CMD_DIRAC_DCX)
            print("[DCX] -> {} {}".format(CMD_DCX_DATA, CMD_DIRAC_DCX))
            return jsonify({"ok": True, "mode": "dcx"})

        return jsonify({"ok": False, "error": "Unknown mode: {}".format(mode)}), 400

    except Exception as e:
        print("[ERROR] audio_features: {}".format(e))
        return jsonify({"ok": False, "error": str(e)}), 500


# -----------------------------------------------------------------------
# NEW Feature #2 — /api/dcx_config
# Sends Command ID 0x20000025 with parameter for channel configuration.
# Default: 7.1.4  (checked = True)
# -----------------------------------------------------------------------
@app.route('/api/dcx_config', methods=['POST'])
def dcx_config():
    try:
        data = request.get_json(force=True) or {}
        is_714 = data.get('is714', True)

        # Safely coerce to bool
        if isinstance(is_714, str):
            is_714 = is_714.lower() in ('1', 'true', 'yes', 'on')
        else:
            is_714 = bool(is_714)

        param = CMD_DCX_CONFIG_7_1_4 if is_714 else CMD_DCX_CONFIG_5_1_2
        label = "7.1.4" if is_714 else "5.1.2"

        write_line(param)
        write_line(CMD_DCX_CONFIG)
        print("[DCX_CONFIG] {} -> {} {}".format(label, param, CMD_DCX_CONFIG))

        return jsonify({"ok": True, "config": label, "sent": [param, CMD_DCX_CONFIG]})

    except Exception as e:
        print("[ERROR] dcx_config: {}".format(e))
        return jsonify({"ok": False, "error": str(e)}), 500


# -----------------------------------------------------------------------
# NEW Feature #3 — /api/app_toggle
# Switches between DCX service (RPI_MUTE.service) and
# Dirac service (Demo_App_ACS.service) using systemctl.
# -----------------------------------------------------------------------
@app.route('/api/app_toggle', methods=['POST'])
def app_toggle():
    """
    Switches the active application between DCX (this app) and DIRAC.

    IMPORTANT ARCHITECTURAL NOTE:
    This endpoint lives inside the DCX Flask process itself (RPI_MUTE.service).
    That means it can only ever be *reached* while DCX is the active,
    running app — i.e. only the DCX -> DIRAC direction is actually
    triggerable from here. (Switching DIRAC -> DCX would require an
    equivalent endpoint inside the DIRAC app, which is out of scope for
    this change — see assumptions.)

    Because `systemctl stop RPI_MUTE.service` will kill this very process,
    we do the "stop self / start DIRAC" sequence in a detached background
    shell so the HTTP response can be flushed back to the browser first.
    The frontend is responsible for then polling/loading the DIRAC UI.
    """
    try:
        data    = request.get_json(force=True) or {}
        use_dcx = data.get('useDCX', True)

        if isinstance(use_dcx, str):
            use_dcx = use_dcx.lower() in ('1', 'true', 'yes', 'on')
        else:
            use_dcx = bool(use_dcx)

        if use_dcx:
            # We are DCX and were asked to stay/become DCX.
            # Safe to do synchronously: stopping DIRAC does not affect us.
            if is_service_active(SERVICE_DIRAC):
                subprocess.run(["sudo", "/usr/bin/systemctl", "stop",    SERVICE_DIRAC])
                subprocess.run(["sudo", "/usr/bin/systemctl", "disable", SERVICE_DIRAC])

            subprocess.run(["sudo", "/usr/bin/systemctl", "enable", SERVICE_DCX])
            subprocess.run(["sudo", "/usr/bin/systemctl", "start",  SERVICE_DCX])

            ready = wait_until_ready(SERVICE_DCX, PORT_DCX)
            if not ready:
                return jsonify({
                    "ok": False,
                    "error": "Timed out verifying DCX is ready",
                    "active": get_active_service()
                }), 504

            print("[APP_TOGGLE] DCX confirmed active ({})".format(SERVICE_DCX))
            return jsonify({"ok": True, "active": "dcx", "service": SERVICE_DCX})

        else:
            # Switching away to DIRAC: stopping DCX kills this process,
            # so run the switch detached and respond before that happens.
            switch_script = (
                "sudo /usr/bin/systemctl stop {dcx}; "
                "sudo /usr/bin/systemctl disable {dcx}; "
                "sudo /usr/bin/systemctl enable {dirac}; "
                "sudo /usr/bin/systemctl start {dirac}"
            ).format(dcx=SERVICE_DCX, dirac=SERVICE_DIRAC)

            subprocess.Popen(
                ["setsid", "bash", "-c", switch_script],
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
                start_new_session=True
            )

            print("[APP_TOGGLE] Switch to DIRAC initiated (detached); DCX will stop shortly")
            return jsonify({
                "ok": True,
                "active": "dirac",
                "switching": True,
                "service": SERVICE_DIRAC,
                "pollPort": PORT_DIRAC
            })

    except Exception as e:
        print("[ERROR] app_toggle: {}".format(e))
        return jsonify({"ok": False, "error": str(e)}), 500


# -----------------------------------------------------------------------
# /api/volume  (unchanged)
# -----------------------------------------------------------------------
@app.route('/api/volume', methods=['POST'])
def volume():
    try:
        level    = int(request.json.get('command'))
        level    = clamp(level, 0, 30)
        vol_data = "0x2001{:04X}".format(level)

        write_line(vol_data)
        write_line(CMD_VOL_APPLY)
        print("[MASTER VOL] {} -> {}".format(level, vol_data))

        return jsonify({"ok": True, "level": level, "sent": [vol_data, CMD_VOL_APPLY]})
    except Exception as e:
        return jsonify({"ok": False, "error": str(e)}), 500


# -----------------------------------------------------------------------
# /api/channel_volume  (unchanged)
# -----------------------------------------------------------------------
@app.route('/api/channel_volume', methods=['POST'])
def channel_volume():
    try:
        data = request.get_json(force=True) or {}
        ch   = int(data.get('channel', 1))
        vol  = int(data.get('volume',  30))

        ch  = clamp(ch,  1, 18)
        vol = clamp(vol, 0, 30)

        ch_byte  = ch - 1
        vol_byte = vol + 0x20

        combined_cmd = "0x2001{:02X}{:02X}".format(ch_byte, vol_byte)

        write_line(combined_cmd)
        write_line(CMD_VOL_APPLY)

        print("[CH VOL] ch={} vol={} -> {} {}".format(ch, vol, combined_cmd, CMD_VOL_APPLY))

        return jsonify({"ok": True, "channel": ch, "volume": vol,
                        "sent": [combined_cmd, CMD_VOL_APPLY]})
    except Exception as e:
        print("[ERROR] channel_volume: {}".format(e))
        return jsonify({"ok": False, "error": str(e)}), 500


# -----------------------------------------------------------------------
# /api/balance_level  (unchanged)
# -----------------------------------------------------------------------
@app.route('/api/balance_level', methods=['POST'])
def balance():
    try:
        val     = int(request.json.get('command'))
        val     = clamp(val, -7, 7)
        encoded = val + 7
        payload = bytearray([CMD_BAL, 0x00, encoded, 0x04])
        ser.write(payload)
        print("[BALANCE] {} -> {}".format(val, list(payload)))
        return jsonify({"ok": True, "value": val, "sent": list(payload)})
    except Exception as e:
        return jsonify({"ok": False, "error": str(e)}), 500


# -----------------------------------------------------------------------
# /api/fader  (unchanged)
# -----------------------------------------------------------------------
@app.route('/api/fader', methods=['POST'])
def fader():
    try:
        val     = int(request.json.get('command'))
        val     = clamp(val, -7, 7)
        encoded = val + 7
        payload = bytearray([CMD_FADE, 0x00, encoded, 0x04])
        ser.write(payload)
        print("[FADER] {} -> {}".format(val, list(payload)))
        return jsonify({"ok": True, "value": val, "sent": list(payload)})
    except Exception as e:
        return jsonify({"ok": False, "error": str(e)}), 500


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5500, threaded=True)
