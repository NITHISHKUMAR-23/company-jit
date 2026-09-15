from flask import Flask, request, render_template, jsonify
import serial
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
# NEW: Per-channel volume K-expression address
# -----------------------------------------------------------------------
CMD_CH_VOL_APPLY = "0x20000021"

# -----------------------------------------------------------------------
# NEW: Dirac / DCX K-expression address and data values
# IMPORTANT: 0x20010060 and 0x20010061 are chosen because they do NOT
# overlap with any mute commands:
#   spk mute ON  : 0x20010000 – 0x20010011
#   spk mute OFF : 0x20010020 – 0x20010031
#   mute_all ON  : 0x20010040
#   mute_all OFF : 0x20010080
# -----------------------------------------------------------------------
CMD_DIRAC_DCX    = "0x20000024"
CMD_DIRAC_DATA   = "0x20010060"
CMD_DCX_DATA     = "0x20010061"


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
    spk1  -> ON: 0x20010000  OFF: 0x20010020
    spk18 -> ON: 0x20010011  OFF: 0x20010031
    """
    base = 0x20010000 if enable else 0x20010020
    return "0x{:08X}".format(base + (spk_index - 1))


def clamp(v, lo, hi):
    return max(lo, min(hi, v))


# -----------------------------------------------------------------------
# Routes
# -----------------------------------------------------------------------
@app.route('/', methods=['GET'])
def index():
    return render_template('index.html')


# -----------------------------------------------------------------------
# /api/mute_all
# Handles "mute_all" global toggle and individual "spk1".."spk18" toggles.
# JS sends isChecked as boolean true/false.
# -----------------------------------------------------------------------
@app.route('/api/mute_all', methods=['POST'])
def mute_all():
    try:
        data      = request.get_json(force=True) or {}
        toggle_id = str(data.get('toggleId', '')).strip()
        is_checked = data.get('isChecked')

        # Safely coerce JS boolean/int/string to Python bool
        if isinstance(is_checked, bool):
            pass  # already correct
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
# /api/audio_features  – Dirac / DCX
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
# /api/volume  – Master volume  (unchanged from old working code)
# Sends: "0x2001" + HEX(level, 4 digits)  then CMD_VOL_APPLY
# Range: 0–30
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
# /api/channel_volume  – Per-channel volume  (independent of master volume)
#
# Per your spec:
#   Channel select : "0x2001" + HEX(ch - 1, 4 digits)
#     ch1  -> 0x20010000
#     ch2  -> 0x20010001
#     ...
#     ch18 -> 0x20010011
#
#   Volume level   : "0x2001" + HEX(vol + 0x20, 4 digits)
#     vol 1  -> hex 0x21  -> "0x20010021"
#     vol 30 -> hex 0x3F  -> "0x2001003F"
#
#   Trigger        : CMD_CH_VOL_APPLY  (0x20000021)
# -----------------------------------------------------------------------
@app.route('/api/channel_volume', methods=['POST'])
def channel_volume():
    try:
        data = request.get_json(force=True) or {}
        ch   = int(data.get('channel', 1))
        vol  = int(data.get('volume',  30))

        ch  = clamp(ch,  1, 18)
        vol = clamp(vol, 1, 30)

        channel_hex = ch - 1          # 0..17 => 00..11
	volume_hex  = vol + 0x21      # 0..30 => 21..3F

	vol_cmd = "0x2001{:02X}{:02X}".format(channel_hex, volume_hex)

        write_line(vol_cmd)
	write_line(CMD_CH_VOL_APPLY)

        print("[CH VOL] ch={} vol={} -> {} {} {}".format(
            ch, vol, ch_cmd, vol_cmd, CMD_CH_VOL_APPLY))

        return jsonify({"ok": True, "channel": ch, "volume": vol,
                        "sent": [ch_cmd, vol_cmd, CMD_CH_VOL_APPLY]})
    except Exception as e:
        print("[ERROR] channel_volume: {}".format(e))
        return jsonify({"ok": False, "error": str(e)}), 500


# -----------------------------------------------------------------------
# /api/balance_level  (unchanged from old working code)
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
# /api/fader  (unchanged from old working code)
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
    app.run(debug=True, host='0.0.0.0', port=5700, threaded=True)
