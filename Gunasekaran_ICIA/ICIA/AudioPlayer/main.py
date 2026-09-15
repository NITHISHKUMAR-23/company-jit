from flask import Flask, render_template, jsonify, request

from config import (
    HOST,
    PORT,
    DEBUG
)

from playlist import Playlist
from kodi_controller import KodiController

app = Flask(__name__)

playlist = Playlist()
kodi = KodiController()

playlist.load()


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

    path = playlist.select(filename)

    if path is None:

        return jsonify({
            "success": False,
            "message": "File not found"
        })

    kodi.play_file(path)

    return jsonify({
        "success": True
    })


# --------------------------------------------------------
# Pause / Resume
# --------------------------------------------------------

@app.route("/pause", methods=["POST"])
def pause():
    pass
    # kodi.play_pause()
    #
    # return jsonify({
    #     "success": True
    # })


# --------------------------------------------------------
# Stop
# --------------------------------------------------------

@app.route("/stop", methods=["POST"])
def stop():
    pass
    # kodi.stop()
    #
    # return jsonify({
    #     "success": True
    # })


# --------------------------------------------------------
# Next
# --------------------------------------------------------

@app.route("/next", methods=["POST"])
def next_song():
    pass
    # path = playlist.next()
    #
    # if path is None:
    #
    #     return jsonify({
    #         "success": False
    #     })
    #
    # kodi.play_file(path)
    #
    # return jsonify({
    #     "success": True,
    #     "file": playlist.current()
    # })


# --------------------------------------------------------
# Previous
# --------------------------------------------------------

@app.route("/previous", methods=["POST"])
def previous_song():
    pass
    # path = playlist.previous()
    #
    # if path is None:
    #
    #     return jsonify({
    #         "success": False
    #     })
    #
    # kodi.play_file(path)
    #
    # return jsonify({
    #     "success": True,
    #     "file": playlist.current()
    # })


# --------------------------------------------------------
# Repeat Mode
# --------------------------------------------------------

@app.route("/repeat", methods=["POST"])
def repeat():
    pass
    # data = request.json
    #
    # mode = int(data["mode"])
    #
    # playlist.set_play_mode(mode)
    #
    # return jsonify({
    #     "success": True
    # })


# --------------------------------------------------------
# Shuffle
# --------------------------------------------------------

@app.route("/shuffle", methods=["POST"])
def shuffle():
    pass
    # data = request.json
    #
    # enable = data["enable"]
    #
    # if enable:
    #
    #     playlist.enable_shuffle()
    #
    # else:
    #
    #     playlist.disable_shuffle()
    #
    # return jsonify({
    #     "success": True
    # })


# --------------------------------------------------------
# Status
# --------------------------------------------------------

@app.route("/status", methods=["GET"])
def status():

    status = kodi.status()

    status["current_file"] = playlist.current()

    return jsonify(status)


# --------------------------------------------------------
# Refresh Folder
# --------------------------------------------------------

@app.route("/refresh", methods=["GET"])
def refresh():

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

    print("Kodi Connected :", kodi.ping())

    app.run(
        host=HOST,
        port=PORT,
        debug=DEBUG
    )