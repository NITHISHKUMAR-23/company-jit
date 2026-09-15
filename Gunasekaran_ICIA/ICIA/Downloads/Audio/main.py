from flask import Flask, render_template, jsonify
import os
from flask import Flask, request, render_template,jsonify ,Response ,redirect, url_for
import serial
from time import sleep
from flask_cors import CORS

#serial communications initialisations
ser=serial.Serial(port='/dev/ttyUSB0',baudrate=115200,bytesize=8,parity='N',stopbits=1,timeout=2) #USB0
app = Flask(__name__)

AUDIO_PATH = "/home/jasminuser"


@app.route("/")
def index():
    return render_template("audio.html")


@app.route("/audio_list")
def audio_list():

    files = []

    for file in os.listdir(AUDIO_PATH):
        if file.endswith(".mkv"):
            files.append(file)

    return jsonify(files)


if __name__ == "__main__":
    app.run(
        host="0.0.0.0",
        port=6000
    )