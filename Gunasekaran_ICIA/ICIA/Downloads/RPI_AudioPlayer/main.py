"""
main.py — standalone EAC3 audio-player GUI
-------------------------------------------
Workflow this app serves:

    iPad (browser)  -->  Flask GUI on RPi (this app, port 5600)
                            |
                            v
                          mpv  --(bitstream passthrough, HDMI)-->  AVR8  -->  AVR9  -->  Output

This is a SEPARATE app from the existing AVR9 UART-command GUI
(main.py on port 5500). They can run side by side on the same RPi;
this one never touches the UART serial port.
"""

import os
from flask import Flask, request, jsonify, render_template
from flask_cors import CORS
from werkzeug.utils import secure_filename

from player import MPVController, Playlist

AUDIO_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "static", "audio")
os.makedirs(AUDIO_DIR, exist_ok=True)

ALLOWED_EXT = {".eac3", ".ec3"}

app = Flask(__name__, static_folder="static")
CORS(app)

playlist = Playlist()


def refresh_tracks():
    files = sorted(
        f for f in os.listdir(AUDIO_DIR)
        if os.path.splitext(f)[1].lower() in ALLOWED_EXT
    )
    playlist.set_tracks(files)
    return files


def _on_track_end():
    """Fired from mpv's event thread when a track finishes naturally
    (not when the user hits Stop). Advances according to repeat/shuffle."""
    nxt = playlist.next()
    if nxt:
        mpv.load(os.path.join(AUDIO_DIR, nxt))
        mpv.play()


mpv = MPVController(on_track_end=_on_track_end)
mpv.start()
refresh_tracks()


# -----------------------------------------------------------------------
# Page
# -----------------------------------------------------------------------
@app.route("/")
def index():
    return render_template("index.html")


# -----------------------------------------------------------------------
# /api/tracks — list available .eac3 files
# -----------------------------------------------------------------------
@app.route("/api/tracks", methods=["GET"])
def get_tracks():
    files = refresh_tracks()
    return jsonify({"ok": True, "tracks": files, "current": playlist.current()})


# -----------------------------------------------------------------------
# /api/upload — iPad sends a .eac3 file, we save it into AUDIO_DIR
# -----------------------------------------------------------------------
@app.route("/api/upload", methods=["POST"])
def upload():
    if "file" not in request.files:
        return jsonify({"ok": False, "error": "No file part in request"}), 400
    f = request.files["file"]
    if f.filename == "":
        return jsonify({"ok": False, "error": "No file selected"}), 400

    ext = os.path.splitext(f.filename)[1].lower()
    if ext not in ALLOWED_EXT:
        return jsonify({"ok": False, "error": "Only .eac3 / .ec3 files are allowed"}), 400

    filename = secure_filename(f.filename)
    f.save(os.path.join(AUDIO_DIR, filename))
    files = refresh_tracks()
    print("[UPLOAD] saved {}".format(filename))
    return jsonify({"ok": True, "tracks": files})


# -----------------------------------------------------------------------
# /api/play — play a specific track, or resume the current one
# -----------------------------------------------------------------------
@app.route("/api/play", methods=["POST"])
def play():
    data = request.get_json(force=True) or {}
    track = data.get("track")
    try:
        if track:
            selected = playlist.select(track)
            if not selected:
                return jsonify({"ok": False, "error": "Track not found"}), 404
            mpv.load(os.path.join(AUDIO_DIR, selected))
            mpv.play()
        else:
            current = playlist.current()
            if not current:
                if not playlist.tracks:
                    return jsonify({"ok": False, "error": "No tracks available"}), 400
                playlist.pos = 0
                current = playlist.current()
                mpv.load(os.path.join(AUDIO_DIR, current))
            mpv.play()
        print("[PLAY] {}".format(playlist.current()))
        return jsonify({"ok": True, "current": playlist.current()})
    except Exception as e:
        print("[ERROR] play: {}".format(e))
        return jsonify({"ok": False, "error": str(e)}), 500


# -----------------------------------------------------------------------
# /api/pause — toggle pause/resume of current track
# -----------------------------------------------------------------------
@app.route("/api/pause", methods=["POST"])
def pause():
    mpv.toggle_pause()
    paused = mpv.is_paused()
    print("[PAUSE] paused={}".format(paused))
    return jsonify({"ok": True, "paused": paused})


# -----------------------------------------------------------------------
# /api/stop — stop playback entirely (does not advance the playlist)
# -----------------------------------------------------------------------
@app.route("/api/stop", methods=["POST"])
def stop():
    mpv.stop()
    print("[STOP]")
    return jsonify({"ok": True})


# -----------------------------------------------------------------------
# /api/next  /  /api/previous
# -----------------------------------------------------------------------
@app.route("/api/next", methods=["POST"])
def next_track():
    nxt = playlist.next()
    if nxt:
        mpv.load(os.path.join(AUDIO_DIR, nxt))
        mpv.play()
        print("[NEXT] {}".format(nxt))
        return jsonify({"ok": True, "current": nxt})
    return jsonify({"ok": False, "error": "End of playlist"}), 200


@app.route("/api/previous", methods=["POST"])
def previous_track():
    prv = playlist.previous()
    if prv:
        mpv.load(os.path.join(AUDIO_DIR, prv))
        mpv.play()
        print("[PREV] {}".format(prv))
        return jsonify({"ok": True, "current": prv})
    return jsonify({"ok": False, "error": "No previous track"}), 200


# -----------------------------------------------------------------------
# /api/repeat — mode: "off" | "one" | "all"
# -----------------------------------------------------------------------
@app.route("/api/repeat", methods=["POST"])
def repeat():
    data = request.get_json(force=True) or {}
    mode = data.get("mode", "off")
    playlist.set_repeat(mode)
    mpv.set_loop_file(mode == Playlist.REPEAT_ONE)
    print("[REPEAT] {}".format(playlist.repeat))
    return jsonify({"ok": True, "repeat": playlist.repeat})


# -----------------------------------------------------------------------
# /api/shuffle — enabled: bool
# -----------------------------------------------------------------------
@app.route("/api/shuffle", methods=["POST"])
def shuffle():
    data = request.get_json(force=True) or {}
    enabled = bool(data.get("enabled", False))
    playlist.set_shuffle(enabled)
    print("[SHUFFLE] {}".format(playlist.shuffle))
    return jsonify({"ok": True, "shuffle": playlist.shuffle})


# -----------------------------------------------------------------------
# /api/status — polled by the frontend every second to sync the UI
# -----------------------------------------------------------------------
@app.route("/api/status", methods=["GET"])
def status():
    return jsonify({
        "ok": True,
        "current": playlist.current(),
        "paused": mpv.is_paused(),
        "position": mpv.position(),
        "duration": mpv.duration(),
        "repeat": playlist.repeat,
        "shuffle": playlist.shuffle,
    })


if __name__ == "__main__":
    # Separate port from the AVR9 UART-command GUI (which uses 5500),
    # so both can run on the RPi at the same time.
    app.run(debug=False, host="0.0.0.0", port=5500, threaded=True)
