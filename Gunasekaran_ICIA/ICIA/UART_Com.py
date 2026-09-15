import serial
import time

# Open UART ports
uart0 = serial.Serial('/dev/ttyUSB0', baudrate=115200, timeout=1)
time.sleep(0.5)
CMD_ID =0x30000000
CMD_PARAM = 0xA30A0000
#CMD_PARAM = b'\xA1\x0A\x00\x00'
msg0 =  CMD_ID.to_bytes(4,'big') + CMD_PARAM.to_bytes(4,'big')
uart0.write(msg0)
print(f"Sent: {msg0.strip()}")


