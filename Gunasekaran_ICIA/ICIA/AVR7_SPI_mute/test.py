from flask import Flask, request, render_template,jsonify ,Response ,redirect, url_for
import spidev
import time

#INITIALISATIONS
bus = 0
device = 1

spi = spidev.SpiDev()
#spi.open(bus, device)

spi.max_speed_hz = 2000000
spi.mode = 0b00

#Initialization for server and serial communications
app = Flask(__name__, static_folder='static')



#V0 button definition
@app.route('/',methods=['GET','POST'])
def index():
    return render_template('index.html')

#V3 button definition
@app.route('/api/balance_level',methods=['POST'])
def balance_level(value):
    print("Balance level:{}".format(value[0]))
    cmd_bal_lev = [0x06,0x00,int(value[0]),0x04]
    spi.writebytes2(cmd_bal_lev)
    return render_template('index.html')
