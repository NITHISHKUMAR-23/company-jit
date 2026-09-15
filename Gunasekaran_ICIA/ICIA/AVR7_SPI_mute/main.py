from flask import Flask, request, render_template,jsonify ,Response ,redirect, url_for
import spidev
import time

#INITIALISATIONS
bus = 0
device = 1

spi = spidev.SpiDev()
spi.open(bus, device)

spi.max_speed_hz = 2000000
spi.mode = 0b00

#Initialization for server and serial communications
app = Flask(__name__, static_folder='static')



#Web App GUI
@app.route('/',methods=['GET','POST'])
def index():
    return render_template('index.html')

#Mute_ALL
@app.route('/api/mute_all',methods=['POST'])
def mute_all():
	data = int(request.form.get('value','0'))
	if data == 1:
	    i=18
	    while (i!=0):
		    cmd_mute_all_1 = [0x9D,0x00,0x02,int(i),data,0x04]
		    spi.writebytes2(cmd_mute_all_1)
		    i=i-1
	    response = cmd_mute_all_1
	else:
	    j=18
	    while(j!=0):
		    cmd_mute_all_0 = [0x9D,0x00,0x02,int(j),data,0x04]
		    spi.writebytes2(cmd_mute_all_0)
		    j=j-1
	    response = cmd_mute_all_0
	return jsonify(response),render_template('index.html')

#Volume
@app.route('/api/volume',methods=['POST'])
def volume():
    cmd_vol = [0x19,0x00,int(request.json.get('command')),0x04]
    spi.writebytes2(cmd_vol)
    response = cmd_vol
    return jsonify(response),render_template('index.html')

#Balance
@app.route('/api/balance_level',methods=['POST'])
def balance():
    data = int(request.json.get('command'))
    cmd_bal_lev = [0x06,0x00,data,0x04]
    spi.writebytes2(cmd_bal_lev)
    response = cmd_bal_lev
    return jsonify(response),render_template('index.html')

#Fader
@app.route('/api/fader',methods=['POST'])
def fader():
    data = int(request.json.get('command'))
    cmd_fade_lev = [0x07,0x00,data,0x04]
    spi.writebytes2(cmd_fade_lev)
    response = cmd_fade_lev
    return jsonify(response),render_template('index.html')


# Speaker mute channel_1
@app.route('/api/spk1',methods=['POST'])
def spk1():
    data = int(request.form.get('value', '0'))
    cmd_ind_mute = [0x9D,0x00,0x02,0x01,data,0x04]
    spi.writebytes2(cmd_ind_mute)
    response = cmd_ind_mute
    return jsonify(response),render_template('index.html')
	
# Speaker mute channel_2
@app.route('/api/spk2',methods=['POST'])
def spk2():
    data = int(request.form.get('value', '0'))
    cmd_ind_mute = [0x9D,0x00,0x02,0x02,data,0x04]
    spi.writebytes2(cmd_ind_mute)
    response = cmd_ind_mute
    return jsonify(response),render_template('index.html')
	
# Speaker mute channel_3
@app.route('/api/spk3',methods=['POST'])
def spk3():
    data = int(request.form.get('value', '0'))
    cmd_ind_mute = [0x9D,0x00,0x02,0x03,data,0x04]
    spi.writebytes2(cmd_ind_mute)
    response = cmd_ind_mute
    return jsonify(response),render_template('index.html')
	
# Speaker mute channel_4
@app.route('/api/spk4',methods=['POST'])
def spk4():
    data = int(request.form.get('value', '0'))
    cmd_ind_mute = [0x9D,0x00,0x02,0x04,data,0x04]
    spi.writebytes2(cmd_ind_mute)
    response = cmd_ind_mute
    return jsonify(response),render_template('index.html')
	
# Speaker mute channel_5
@app.route('/api/spk5',methods=['POST'])
def spk5():
    data = int(request.form.get('value', '0'))
    cmd_ind_mute = [0x9D,0x00,0x02,0x05,data,0x04]
    spi.writebytes2(cmd_ind_mute)
    response = cmd_ind_mute
    return jsonify(response),render_template('index.html')
	
# Speaker mute channel_6
@app.route('/api/spk6',methods=['POST'])
def spk6():
    data = int(request.form.get('value', '0'))
    cmd_ind_mute = [0x9D,0x00,0x02,0x06,data,0x04]
    spi.writebytes2(cmd_ind_mute)
    response = cmd_ind_mute
    return jsonify(response),render_template('index.html')
	
# Speaker mute channel_7
@app.route('/api/spk7',methods=['POST'])
def spk7():
    data = int(request.form.get('value', '0'))
    cmd_ind_mute = [0x9D,0x00,0x02,0x07,data,0x04]
    spi.writebytes2(cmd_ind_mute)
    response = cmd_ind_mute
    return jsonify(response),render_template('index.html')
	

# Speaker mute channel_8
@app.route('/api/spk8',methods=['POST'])
def spk8():
    data = int(request.form.get('value', '0'))
    cmd_ind_mute = [0x9D,0x00,0x02,0x08,data,0x04]
    spi.writebytes2(cmd_ind_mute)
    response = cmd_ind_mute
    return jsonify(response),render_template('index.html')
	
# Speaker mute channel_9
@app.route('/api/spk9',methods=['POST'])
def spk9():
    data = int(request.form.get('value', '0'))
    cmd_ind_mute = [0x9D,0x00,0x02,0x09,data,0x04]
    spi.writebytes2(cmd_ind_mute)
    response = cmd_ind_mute
    return jsonify(response),render_template('index.html')
	
# Speaker mute channel_10
@app.route('/api/spk10',methods=['POST'])
def spk10():
    data = int(request.form.get('value', '0'))
    cmd_ind_mute = [0x9D,0x00,0x02,0x0A,data,0x04]
    spi.writebytes2(cmd_ind_mute)
    response = cmd_ind_mute
    return jsonify(response),render_template('index.html')
	
# Speaker mute channel_11
@app.route('/api/spk11',methods=['POST'])
def spk11():
    data = int(request.form.get('value', '0'))
    cmd_ind_mute = [0x9D,0x00,0x02,0x0B,data,0x04]
    spi.writebytes2(cmd_ind_mute)
    response = cmd_ind_mute
    return jsonify(response),render_template('index.html')
	
# Speaker mute channel_12
@app.route('/api/spk12',methods=['POST'])
def spk12():
    data = int(request.form.get('value', '0'))
    cmd_ind_mute = [0x9D,0x00,0x02,0x0C,data,0x04]
    spi.writebytes2(cmd_ind_mute)
    response = cmd_ind_mute
    return jsonify(response),render_template('index.html')
	
# Speaker mute channel_13
@app.route('/api/spk13',methods=['POST'])
def spk13():
    data = int(request.form.get('value', '0'))
    cmd_ind_mute = [0x9D,0x00,0x02,0x0D,data,0x04]
    spi.writebytes2(cmd_ind_mute)
    response = cmd_ind_mute
    return jsonify(response),render_template('index.html')
	
# Speaker mute channel_14
@app.route('/api/spk14',methods=['POST'])
def spk14():
    data = int(request.form.get('value', '0'))
    cmd_ind_mute = [0x9D,0x00,0x02,0x0E,data,0x04]
    spi.writebytes2(cmd_ind_mute)
    response = cmd_ind_mute
    return jsonify(response),render_template('index.html')
	
# Speaker mute channel_15
@app.route('/api/spk15',methods=['POST'])
def spk15():
    data = int(request.form.get('value', '0'))
    cmd_ind_mute = [0x9D,0x00,0x02,0x0F,data,0x04]
    spi.writebytes2(cmd_ind_mute)
    response = cmd_ind_mute
    return jsonify(response),render_template('index.html')
	
# Speaker mute channel_16
@app.route('/api/spk16',methods=['POST'])
def spk16():
    data = int(request.form.get('value', '0'))
    cmd_ind_mute = [0x9D,0x00,0x02,0x10,data,0x04]
    spi.writebytes2(cmd_ind_mute)
    response = cmd_ind_mute
    return jsonify(response),render_template('index.html')
	
# Speaker mute channel_17
@app.route('/api/spk17',methods=['POST'])
def spk17():
    data = int(request.form.get('value', '0'))
    cmd_ind_mute = [0x9D,0x00,0x02,0x11,data,0x04]
    spi.writebytes2(cmd_ind_mute)
    response = cmd_ind_mute
    return jsonify(response),render_template('index.html')
	
# Speaker mute channel_18
@app.route('/api/spk18',methods=['POST'])
def spk18():
    data = int(request.form.get('value', '0'))
    cmd_ind_mute = [0x9D,0x00,0x02,0x12,data,0x04]
    spi.writebytes2(cmd_ind_mute)
    response = cmd_ind_mute
    return jsonify(response),render_template('index.html')
    


if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0', port=5000)
