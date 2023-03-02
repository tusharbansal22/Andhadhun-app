from serial import Serial
import time


#from serial.tools import list_ports
#port = list(list_ports.comports())
#for p in port:
#    print(p.device)

    
arduinoData=Serial('/dev/cu.usbmodem11401',9600)
#Enter your port

time.sleep(2)
arduinoData.write(b'5000')
    
