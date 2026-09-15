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

CHANGE (this revision): tracks are read LIVE from a folder that
already exists on the Pi (default /home/jasminuser/dolby) instead of
an upload-only folder inside the app. The folder path is editable
from the GUI (Settings panel) and persisted in player_config.json so
it survives restarts. No file upload from the iPad is used or needed.
"""

import os
from flask import Flask, request, jsonify, render_template
from flask_cors import CORS

import config
from player import MPVController, Playlist

ALLOWED_EXT = {".eac3", ".ec3"}

app = Flask(__name__, static_folder="static")
CORS(app)

playlist = Playlist()


def get_audio_dir():
    return config.get_audio_dir()


def refresh_tracks():
    """Re-scan the configured audio folder. Returns (files, error)."""
    audio_dir = get_audio_dir()
    if not os.path.isdir(audio_dir):
        playlist.set_tracks([])
        return [], "Folder not found: {}".format(audio_dir)
    try:
        files = sorted(
            f for f in os.listdir(audio_dir)
            if os.path.splitext(f)[1].lower() in ALLOWED_EXT
        )
    except OSError as e:
        playlist.set_tracks([])
        return [], "Cannot read folder {}: {}".format(audio_dir, e)
    playlist.set_tracks(files)
    return files, None


def _on_track_end():
    """Fired from mpv's event thread when a track finishes naturally
    (not when the user hits Stop). Advances according to repeat/shuffle."""
    nxt = playlist.next()
    if nxt:
        mpv.load(os.path.join(get_audio_dir(), nxt))
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
# /api/tracks — list available .eac3 files in the configured Pi folder
# -----------------------------------------------------------------------
@app.route("/api/tracks", methods=["GET"])
def get_tracks():
    files, error = refresh_tracks()
    return jsonify({
        "ok": error is None,
        "tracks": files,
        "current": playlist.current(),
        "audio_dir": get_audio_dir(),
        "error": error,
    })


# -----------------------------------------------------------------------
# /api/settings — GET current folder path, POST to change it
# -----------------------------------------------------------------------
@app.route("/api/settings", methods=["GET"])
def get_settings():
    return jsonify({"ok": True, "audio_dir": get_audio_dir()})


@app.route("/api/settings", methods=["POST"])
def set_settings():
    data = request.get_json(force=True) or {}
    new_dir = (data.get("audio_dir") or "").strip()
    if not new_dir:
        return jsonify({"ok": False, "error": "Path cannot be empty"}), 400
    if not os.path.isabs(new_dir):
        return jsonify({"ok": False, "error": "Path must be absolute, e.g. /home/jasminuser/dolby"}), 400
    if not os.path.isdir(new_dir):
        return jsonify({"ok": False, "error": "Folder does not exist on the Pi: {}".format(new_dir)}), 400
    if not os.access(new_dir, os.R_OK):
        return jsonify({"ok": False, "error": "Folder exists but is not readable (permissions): {}".format(new_dir)}), 400

    mpv.stop()
    config.set_audio_dir(new_dir)
    files, error = refresh_tracks()
    print("[SETTINGS] audio_dir set to {}".format(new_dir))
    return jsonify({"ok": True, "audio_dir": new_dir, "tracks": files, "error": error})


# -----------------------------------------------------------------------
# /api/play — play a specific track, or resume the current one
# -----------------------------------------------------------------------
@app.route("/api/play", methods=["POST"])
def play():
    data = request.get_json(force=True) or {}
    track = data.get("track")
    audio_dir = get_audio_dir()
    try:
        if track:
            selected = playlist.select(track)
            if not selected:
                return jsonify({"ok": False, "error": "Track not found"}), 404
            mpv.load(os.path.join(audio_dir, selected))
            mpv.play()
        else:
            current = playlist.current()
            if not current:
                if not playlist.tracks:
                    return jsonify({"ok": False, "error": "No tracks available in {}".format(audio_dir)}), 400
                playlist.pos = 0
                current = playlist.current()
                mpv.load(os.path.join(audio_dir, current))
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
        mpv.load(os.path.join(get_audio_dir(), nxt))
        mpv.play()
        print("[NEXT] {}".format(nxt))
        return jsonify({"ok": True, "current": nxt})
    return jsonify({"ok": False, "error": "End of playlist"}), 200


@app.route("/api/previous", methods=["POST"])
def previous_track():
    prv = playlist.previous()
    if prv:
        mpv.load(os.path.join(get_audio_dir(), prv))
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
        "audio_dir": get_audio_dir(),
    })


if __name__ == "__main__":
    # Separate port from the AVR9 UART-command GUI (which uses 5500),
    # so both can run on the RPi at the same time.
    app.run(debug=False, host="0.0.0.0", port=5600, threaded=True)
