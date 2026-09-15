from flask import Flask, request, send_file, abort, render_template, jsonify
from flask_cors import CORS
import json
import argparse
import serial
from time import sleep
import struct
import math
import array
import socket
import requests
import subprocess


app = Flask(__name__)

#UART structure
HEADER_H = b'\xAA'
HEADER_L = b'\x55'
FOOTER_H = b'\x55'
FOOTER_L = b'\xAA'
volume_command_id = 0x00000005
volume_param_id = "0x00000005"

# Mode mapping
MODE_NAMES = {
    1: "AudioIQ",
    2: "AudioIQ Plus",
    3: "AudioIQ Unison",
    4: "AudioIQ Unison + DSU"
}

EQUIV_MODE_NAMES = {
    "AudioIQ" : "1_8CH_AIQ_AS",
    "AudioIQ Plus" : "2_8CH_AIQ_PLUS_AS",
    "AudioIQ Unison" : "3_18CH_AIQ_UNISON_FS",
    "AudioIQ Unison + DSU": "4_18CH_AIQ_UNISON_DSU_FS"
}

# State variables
tuning_enabled = False
current_mode = 1
volume = 30  # 0–40 range
ser=serial.Serial(port='/dev/ttyUSB1',baudrate=115200,bytesize=8,parity='N',stopbits=1,timeout=2)   #USB1


MSG_ID = b'\x01\x00\x00\x00'
CONF_HDR_ID = b'\x08\x00\x00\x00'

@app.route("/")
def index():
    return render_template(
        "index.html",
        tuning=tuning_enabled,               # sends current state
        mode=current_mode,
        mode_name=MODE_NAMES[current_mode] if tuning_enabled else "",
        volume=volume
    )

@app.route("/toggle_tuning")
def toggle_tuning():
    global tuning_enabled
    tuning_enabled = not tuning_enabled
    
    DIRAC_ENABLE_ID = b'\x55\x00\x00\x00'
    DIRAC_DISABLE_ID = b'\xAA\x00\x00\x00'
    
    if tuning_enabled:
        payload = MSG_ID + DIRAC_ENABLE_ID
        payload_size = len(payload)
        payload_size_bytes = payload_size.to_bytes(4, byteorder='little')
        payload = payload.ljust(1024, b'\x00')
        crc = calculate_crc(payload_size_bytes + payload)
        crc = struct.pack('B', crc)
        data = HEADER_H + HEADER_L + payload_size_bytes + payload + crc + FOOTER_H + FOOTER_L
        #print(data)
        ser.write(data)
    else:
        payload = MSG_ID + DIRAC_DISABLE_ID
        payload_size = len(payload)
        payload_size_bytes = payload_size.to_bytes(4, byteorder='little')
        payload = payload.ljust(1024, b'\x00')
        crc = calculate_crc(payload_size_bytes + payload)
        crc = struct.pack('B', crc)
        data = HEADER_H + HEADER_L + payload_size_bytes + payload + crc + FOOTER_H + FOOTER_L
        #print(data)
        ser.write(data)
    return jsonify({
        "tuning": tuning_enabled,
        "mode": current_mode,
        "mode_name": MODE_NAMES[current_mode] if tuning_enabled else ""
    })

@app.route('/set_mode/<int:mode>')
def set_mode(mode):
    global current_mode
    if mode in MODE_NAMES:
        current_mode = mode
        raw_name = MODE_NAMES[mode]
        configuration_name = EQUIV_MODE_NAMES.get(raw_name, raw_name)
        payload = MSG_ID + CONF_HDR_ID + configuration_name.encode('utf-8')
        payload_size = len(payload)
        payload_size_bytes = payload_size.to_bytes(4, byteorder='little')
        payload = payload.ljust(1024, b'\x00')
        crc = calculate_crc(payload_size_bytes + payload)
        crc = struct.pack('B', crc)
        data = HEADER_H + HEADER_L + payload_size_bytes + payload + crc + FOOTER_H + FOOTER_L
        #print(data)
        ser.write(data)
        return jsonify({"mode": current_mode, "mode_name": MODE_NAMES[current_mode]})
    else:
        return jsonify({"error": "Invalid mode"}), 400
        
@app.route('/volume/up')
def volume_up():
    global volume
    if volume < 40:  # limit to max 40
        volume += 1
    level = round(20*math.log10(volume))
    struct_value = struct.pack('<f', float(level))
    value = b'\x10\x00\x00\x00\x01\x00\x00\x00\x07\x00\x00\x00\x05\x00\x00\x00'
    value = value + struct_value
    payload = value.ljust(1028, b'\x00')
    crc = calculate_crc(payload)
    crc = struct.pack('B', crc)
    data = HEADER_H + HEADER_L + payload + crc + FOOTER_H + FOOTER_L
    #print(data)
    ser.write(data)
    return jsonify({"volume": volume})

@app.route('/volume/down')
def volume_down():
    global volume
    if volume > 0:  # limit to min 0
        volume -= 1
    level = round(20*math.log10(volume))
    struct_value = struct.pack('<f', float(level))
    value = b'\x10\x00\x00\x00\x01\x00\x00\x00\x07\x00\x00\x00\x05\x00\x00\x00'
    value = value + struct_value
    payload = value.ljust(1028, b'\x00')
    crc = calculate_crc(payload)
    crc = struct.pack('B', crc)
    data = HEADER_H + HEADER_L + payload + crc + FOOTER_H + FOOTER_L
    #print(data)
    ser.write(data)
    return jsonify({"volume": volume})
    
def calculate_crc(data):
    curr_crc = 0xAA
    sum1 = curr_crc & 0xFF
    sum2 = (curr_crc >> 8) & 0xFF
    for byte in data:
        sum1 = (sum1 + byte) % 0xFF
        sum2 = (sum2 + sum1) % 0xFF
    # Return the least significant byte of the CRC result
    return sum1 & 0xFF # Take only the least significant byte

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
