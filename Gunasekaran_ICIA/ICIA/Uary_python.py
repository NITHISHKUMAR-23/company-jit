import serial
import time
 
# Open UART ports
uart0 = serial.Serial('/dev/ttyUSB0', baudrate=115200, timeout=1)
uart1 = serial.Serial('/dev/ttyUSB1', baudrate=115200, timeout=1)
uart2 = serial.Serial('/dev/ttyUSB2', baudrate=115200, timeout=1)
 
count = 0
 
while True:
    msg0 = f"UART0 Message {count}\r\n"
    msg1 = f"UART1 Message {count}\r\n"
    msg2 = f"UART2 Message {count}\r\n"
 
    uart0.write(msg0.encode())
    uart1.write(msg1.encode())
    uart2.write(msg2.encode())
 
    print(f"Sent: {msg0.strip()}")
    print(f"Sent: {msg1.strip()}")
    print(f"Sent: {msg2.strip()}")
 
    count += 1
    time.sleep(1)
