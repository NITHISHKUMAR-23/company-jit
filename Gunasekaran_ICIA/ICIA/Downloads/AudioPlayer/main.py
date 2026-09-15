from flask import Flask, render_template, jsonify, request
import os
import subprocess
import threading
import time
import logging

from config import (
    HOST,
    PORT,
    DEBUG,
    KODI_AE_SINK,
    ALSA_BUFFER_SIZE,
    KODI_STARTUP_TIMEOUT,
    KODI_MONITOR_INTERVAL,
    PLAYBACK_MONITOR_INTERVAL
)

from playlist import Playlist
from kodi_controller import KodiController

app = Flask(__name__)

# --------------------------------------------------------
# Logging
# --------------------------------------------------------

if not os.path.exists("logs"):
    os.makedirs("logs")

logging.basicConfig(
    filename="logs/player.log",
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s"
)

playlist = Playlist()

kodi = KodiController()

playlist.load()

#
# Background status
#

kodi_connected = False

last_state = "stopped"


# --------------------------------------------------------
# Start Kodi
# --------------------------------------------------------

def start_kodi():

    logging.info("Starting Kodi")

    try:

        env = os.environ.copy()

        env["KODI_AE_SINK"] = KODI_AE_SINK

        env["ALSA_BUFFER_SIZE"] = ALSA_BUFFER_SIZE

        subprocess.Popen(
            ["kodi"],
            env=env,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL
        )

        #
        # Wait up to 15 seconds
        #

        for _ in range(15):

            if kodi.ping():

                logging.info("Kodi Started")

                return True

            time.sleep(1)

        logging.error("Kodi startup timeout.")

        return False

    except Exception as ex:

        logging.exception(ex)

        return False

# --------------------------------------------------------
# Kodi Monitor
# --------------------------------------------------------

def kodi_monitor():

    global kodi_connected

    while True:

        connected = kodi.ping()

        if connected != kodi_connected:

            kodi_connected = connected

            if connected:

                logging.info("Kodi Connected")

            else:

                logging.warning("Kodi Disconnected")
        KODI_MONITOR_INTERVAL = 3
        time.sleep(KODI_MONITOR_INTERVAL)


# --------------------------------------------------------
# Playback Monitor
# --------------------------------------------------------

def playback_monitor():

    global last_state

    while True:

        try:

            status = kodi.status()

            state = status.get("state", "stopped")

            #
            # Playback completed
            #

            if last_state == "playing" and state == "stopped":

                logging.info("Song Completed")

                path = playlist.on_song_finished()

                if path:

                    logging.info(
                        "Auto Next : %s",
                        playlist.current()
                    )

                    kodi.play_file(path)

            last_state = state

        except Exception as ex:

            logging.error(ex)
        PLAYBACK_MONITOR_INTERVAL = 1
        time.sleep(PLAYBACK_MONITOR_INTERVAL)






# --------------------------------------------------------
# Home Page
# --------------------------------------------------------

@app.route("/")
def index():
    return render_template("index.html")


# --------------------------------------------------------
# Get Audio Files
# --------------------------------------------------------

@app.route("/audio", methods=["GET"])
def audio():

    playlist.load()

    return jsonify(
        playlist.get_all()
    )


# --------------------------------------------------------
# Get Playlist Information
# --------------------------------------------------------

@app.route("/playlist", methods=["GET"])
def playlist_info():

    return jsonify(
        playlist.info()
    )


# --------------------------------------------------------
# Select Folder
# --------------------------------------------------------

@app.route("/folder", methods=["POST"])
def folder():

    data = request.json

    folder = data["folder"]

    playlist.set_folder(folder)

    return jsonify(
        playlist.get_all()
    )


# --------------------------------------------------------
# Play
# --------------------------------------------------------

@app.route("/play", methods=["POST"])
def play():

    data = request.json

    filename = data["file"]

    # path = playlist.select(filename)
    path = playlist.play_selected_file(filename)

    if path is None:

        return jsonify({
            "success": False,
            "message": "File not found"
        })

    try:


        kodi.play_file(path)
        logging.info(
            "Playing : %s",
            filename
        )

    except Exception as ex:

        logging.error(ex)

        return jsonify({

            "success": False,

            "message": str(ex)

        })

    return jsonify({
        "success": True
    })


# --------------------------------------------------------
# Pause / Resume
# --------------------------------------------------------

@app.route("/pause", methods=["POST"])
def pause():

    # kodi.play_pause()
    try:

        kodi.play_pause()

        logging.info("Pause/Resume")

    except Exception as ex:

        logging.error(ex)

    return jsonify({
        "success": True
    })


# --------------------------------------------------------
# Stop
# --------------------------------------------------------

@app.route("/stop", methods=["POST"])
def stop():

    # kodi.stop()
    try:

        kodi.stop()

        logging.info("Stop")

    except Exception as ex:

        logging.error(ex)

    return jsonify({
        "success": True
    })


# --------------------------------------------------------
# Next
# --------------------------------------------------------

@app.route("/next", methods=["POST"])
def next_song():

    path = playlist.on_user_next()

    if path is None:

        return jsonify({
            "success": False
        })

    kodi.play_file(path)
    logging.info(
        "Next : %s",
        playlist.current()
    )

    return jsonify({
        "success": True,
        "file": playlist.current()
    })


# --------------------------------------------------------
# Previous
# --------------------------------------------------------

@app.route("/previous", methods=["POST"])
def previous_song():

    path = playlist.on_user_previous()

    if path is None:

        return jsonify({
            "success": False
        })

    kodi.play_file(path)
    logging.info(
        "Previous : %s",
        playlist.current()
    )
    return jsonify({
        "success": True,
        "file": playlist.current()
    })


# --------------------------------------------------------
# Repeat Mode
# --------------------------------------------------------

@app.route("/repeat", methods=["POST"])
def repeat():

    data = request.json

    mode = int(data["mode"])
    logging.info(

        "Repeat Mode : %d",

        mode

    )
    playlist.set_play_mode(mode)

    return jsonify({
        "success": True
    })


# --------------------------------------------------------
# Shuffle
# --------------------------------------------------------

@app.route("/shuffle", methods=["POST"])
def shuffle():

    data = request.json

    enable = data["enable"]

    if enable:
        logging.info("Shuffle Enabled")
        playlist.enable_shuffle()

    else:
        logging.info("Shuffle Disabled")
        playlist.disable_shuffle()

    return jsonify({
        "success": True
    })


# --------------------------------------------------------
# Status
# --------------------------------------------------------

@app.route("/status", methods=["GET"])
def status():

    try:

        status = kodi.status()

    except Exception:

        status = {
            "state": "stopped"
        }

    status["current_file"] = playlist.current()

    status["playlist_count"] = playlist.count()

    status["shuffle"] = playlist.shuffle

    status["repeat_mode"] = playlist.play_mode

    status["kodi_connected"] = kodi_connected

    return jsonify(status)


# --------------------------------------------------------
# Refresh Folder
# --------------------------------------------------------

@app.route("/refresh", methods=["GET"])
def refresh():
    logging.info("Folder Refreshed")
    playlist.load()

    return jsonify({
        "success": True,
        "files": playlist.get_all()
    })


# --------------------------------------------------------
# Ping Kodi
# --------------------------------------------------------

@app.route("/ping", methods=["GET"])
def ping():

    return jsonify({
        "connected": kodi.ping()
    })


# --------------------------------------------------------
# Application
# --------------------------------------------------------

if __name__ == "__main__":

    print("----------------------------------")
    print("Audio Player Started")
    print("----------------------------------")

    #
    # Start Kodi if required
    #

    if not kodi.ping():

        print("Kodi not running.")

        if start_kodi():
            logging.info("Kodi started")
        else:
            logging.error("Kodi failed")

    #
    # Start monitoring threads
    #

    threading.Thread(
        target=kodi_monitor,
        daemon=True
    ).start()

    threading.Thread(
        target=playback_monitor,
        daemon=True
    ).start()

    print("Kodi Connected :", kodi.ping())

    logging.info("Application Started")
    try:
        app.run(

        host=HOST,

        port=PORT,

        debug=DEBUG)


    finally:

        logging.info("Kodi Connected : %s", kodi_connected)