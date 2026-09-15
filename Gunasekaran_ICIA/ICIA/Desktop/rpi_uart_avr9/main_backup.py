from flask import Flask, request, render_template,jsonify ,Response ,redirect, url_for
import serial
from time import sleep
from flask_cors import CORS


#serial communications initialisations
ser=serial.Serial(port='/dev/ttyUSB0',baudrate=115200,bytesize=8,parity='N',stopbits=1,timeout=2) #USB0

#Initialization for server and serial communications
app = Flask(__name__, static_folder='static')
CORS(app)
toggle_states = {
    "mute_all": False,
    "spk_1": False,
    "spk_2": False,
    "spk_3": False,
    "spk_4": False,
    "spk_5": False,
    "spk_6": False,
    "spk_7": False,
    "spk_8": False,
    "spk_9": False,
    "spk_10": False,
    "spk_11": False,
    "spk_12": False,
    "spk_13": False,
    "spk_14": False,
    "spk_15": False,
    "spk_16": False,
    "spk_17": False,
    "spk_18": False,
}

#global declarations
cmd_bal = 0x06
cmd_vol = "0x20000022"
cmd_fade = 0x07

#commands for individual volume

 

#Web App GUI
@app.route('/',methods=['GET','POST'])
def index():
    return render_template('index.html')

#Mute_ALL
@app.route('/api/mute_all',methods=['POST'])
def mute_all():
	cmd_mute = "0x20000023"
	mute_cmd_enable = "0x20010040"
	mute_cmd_disable = "0x20010080"
	data = request.get_json()
	toggle_id = data.get('toggleId')
	is_checked = data.get('isChecked')
	if toggle_id == "mute_all":
	    if is_checked == 1:
		    ser.write((mute_cmd_enable + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    else:
		    ser.write((mute_cmd_disable + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    toggle_states[toggle_id] = is_checked
	    return render_template('index.html')
	elif toggle_id == "spk1":
	    # Handle spk_1 toggle task
	    if is_checked == 1:
		    input_cmd = "0x20010000"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    else:
		    input_cmd = "0x20010020"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    return render_template('index.html')
	    
	elif toggle_id == "spk2":
	    # Handle spk_2 toggle task
	    if is_checked == 1:
		    input_cmd = "0x20010001"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    else:
		    input_cmd = "0x20010021"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    return render_template('index.html')
	elif toggle_id == "spk3":
	    # Handle spk_3 toggle task
	    if is_checked == 1:
		    input_cmd = "0x20010002"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    else:
		    input_cmd = "0x20010022"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    return render_template('index.html')
	elif toggle_id == "spk4":
	    # Handle spk_4 toggle task
	    if is_checked == 1:
		    input_cmd = "0x20010003"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    else:
		    input_cmd = "0x20010023"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    return render_template('index.html')
	elif toggle_id == "spk5":
	    # Handle spk_5 toggle task
	    if is_checked == 1:
		    input_cmd = "0x20010004"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    else:
		    input_cmd = "0x20010024"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    return render_template('index.html')
	elif toggle_id == "spk6":
	    # Handle spk_6 toggle task
	    if is_checked == 1:
		    input_cmd = "0x20010005"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    else:
		    input_cmd = "0x20010025"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    return render_template('index.html')
	elif toggle_id == "spk7":
	    # Handle spk_7 toggle task
	    if is_checked == 1:
		    input_cmd = "0x20010006"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    else:
		    input_cmd = "0x20010026"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    return render_template('index.html')
	elif toggle_id == "spk8":
	    # Handle spk_8 toggle task
	    if is_checked == 1:
		    input_cmd = "0x20010007"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    else:
		    input_cmd = "0x20010027"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    return render_template('index.html')
	elif toggle_id == "spk9":
	    # Handle spk_9 toggle task
	    if is_checked == 1:
		    input_cmd = "0x20010008"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    else:
		    input_cmd = "0x20010028"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    return render_template('index.html')
	elif toggle_id == "spk10":
	    # Handle spk_10 toggle task
	    if is_checked == 1:
		    input_cmd = "0x20010009"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    else:
		    input_cmd = "0x20010029"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    return render_template('index.html')
	elif toggle_id == "spk11":
	    # Handle spk_11 toggle task
	    if is_checked == 1:
		    input_cmd = "0x2001000A"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    else:
		    input_cmd = "0x2001002A"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    return render_template('index.html')
	elif toggle_id == "spk12":
	    # Handle spk_12 toggle task
	    if is_checked == 1:
		    input_cmd = "0x2001000B"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    else:
		    input_cmd = "0x2001002B"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    return render_template('index.html')
	elif toggle_id == "spk13":
	    # Handle spk_13 toggle task
	    if is_checked == 1:
		    input_cmd = "0x2001000C"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    else:
		    input_cmd = "0x2001002C"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    return render_template('index.html')
	elif toggle_id == "spk14":
	    # Handle spk_14 toggle task
	    if is_checked == 1:
		    input_cmd = "0x2001000D"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    else:
		    input_cmd = "0x2001002D"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    return render_template('index.html')
	elif toggle_id == "spk15":
	    # Handle spk_15 toggle task
	    if is_checked == 1:
		    input_cmd = "0x2001000E"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    else:
		    input_cmd = "0x2001002E"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    return render_template('index.html')
	elif toggle_id == "spk16":
	    # Handle spk_16 toggle task
	    if is_checked == 1:
		    input_cmd = "0x2001000F"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    else:
		    input_cmd = "0x2001002F"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    return render_template('index.html')
	elif toggle_id == "spk17":
	    # Handle spk_17 toggle task
	    if is_checked == 1:
		    input_cmd = "0x20010010"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    else:
		    input_cmd = "0x20010030"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    return render_template('index.html')
	elif toggle_id == "spk18":
	    # Handle spk_18 toggle task
	    if is_checked == 1:
		    input_cmd = "0x20010011"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    else:
		    input_cmd = "0x20010031"
		    ser.write((input_cmd + '\r').encode('utf-8'))
		    ser.write((cmd_mute + '\r').encode('utf-8'))
	    return render_template('index.html')

#Volume
@app.route('/api/volume',methods=['POST'])
def volume():
    vol_data = "0x2001" + str('{0:04X}'.format(request.json.get('command')))
    print("volume value sent is {}".format(vol_data))
    ser.write((vol_data + '\r').encode('utf-8'))
    ser.write((cmd_vol + '\r').encode('utf-8'))
    response = cmd_vol
    return jsonify(response), render_template('index.html')

#Balance
@app.route('/api/balance_level',methods=['POST'])
def balance():
    data = int(request.json.get('command'))
    data = data+7
    cmd_bal_lev = [cmd_bal,0x00,data,0x04]
    byte_data = bytearray(cmd_bal_lev)
    ser.write(byte_data)
    print("balance value sent is {}".format(data))
    response = cmd_bal_lev
    return render_template('index.html')

#Fader
@app.route('/api/fader',methods=['POST'])
def fader():
    data = int(request.json.get('command'))
    data = data+7
    cmd_fade_lev = [cmd_fade,0x00,data,0x04]
    byte_data = bytearray(cmd_fade_lev)
    ser.write(byte_data)
    print("fader value sent is {}".format(data))
    response = cmd_fade_lev
    return render_template('index.html')


if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0', port=5000)
