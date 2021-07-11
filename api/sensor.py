import json
import serial
import sqlite3
ser = serial.Serial("/dev/ttyACM0", 9600, timeout=1)
ser.flush()


while True:
    if ser.in_waiting>0:
        line = ser.readline().decode("utf-8").rstrip()
        #line = json.dumps(line)
        print(line)
        with open("new.txt", "w") as out_file:
            json.dump(line, out_file)
    
        with open("old.txt", "w") as to_old:
            with open('new.txt', 'r') as json_file:
                data = json.load(json_file)
            json.dump(data, to_old)
