import time 
import spidev
import BlynkLib

BLYNK_AUTH = "80MhvX7QcuA7tXH8WZcpIRo1zQhV8Jgl"
bus = 0
device = 1

spi = spidev.SpiDev()
spi.open(bus, device)

spi.max_speed_hz = 2000000
spi.mode = 0b00

#macros
MUTE_ON = [0x9D,0x00,0x02,0x04,0x01,0x04]
MUTE_OFF = [0x9D,0x00,0x02,0x04,0x00,0x04]


blynk = BlynkLib.Blynk(BLYNK_AUTH,heartbeat=10)

@blynk.on("V0")
def v0_write_handler(value):
    if int(value[0]) == 1:
        i=16
        print("Mute On:{}".format(value[0]))
        while(i!=0):
            spi.writebytes2([0x9D,0x00,0x02,int(i),int(value[0]),0x04])
            i=i-1
    else:
        print("Mute Off".format(value[0]))
        j=16
        while(j!=0):
            spi.writebytes2([0x9D,0x00,0x02,int(j),int(value[0]),0x04])
            j=j-1

@blynk.on("V1")
def v1_write_handler(value):
    print("volume:{}".format(value[0]))
    cmd_vol = [0x19,0x00,int(value[0]),0x04]
    spi.writebytes2(cmd_vol)
    
@blynk.on("V2")
def v2_write_handler(value):
    print("Bass:{}".format(value[0]))
    cmd_bass = [0x03,0x00,int(value[0]),0x04]
    spi.writebytes2(cmd_bass)

@blynk.on("V3")
def v3_write_handler(value):
    print("Bal level:{}".format(value[0]))
    cmd_bal_lev = [0x06,0x00,int(value[0]),0x04]
    spi.writebytes2(cmd_bal_lev)

@blynk.on("V4")
def v4_write_handler(value):
    print("Fader level:{}".format(value[0]))
    cmd_fade_lev = [0x07,0x00,int(value[0]),0x04]
    spi.writebytes2(cmd_fade_lev)

@blynk.on("V5")
def v5_write_handler(value):
    print("MID level:{}".format(value[0]))
    cmd_mid_lev = [0x05,0x00,int(value[0]),0x04]
    spi.writebytes2(cmd_mid_lev)

@blynk.on("V6")
def v6_write_handler(value):
    print("Treble level:{}".format(value[0]))
    cmd_treble_lev = [0x04,0x00,int(value[0]),0x04]
    spi.writebytes2(cmd_treble_lev)

@blynk.on("V7")
def v7_write_handler(value):
    print("individual mute:{}".format(value[0]))
    cmd_ind_mute = [0x9D,0x00,0x02,0x0C,int(value[0]),0x04]
    spi.writebytes2(cmd_ind_mute)                


while True:
    blynk.run()
