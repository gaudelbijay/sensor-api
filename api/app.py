from flask import Flask, render_template, Response
from flask_restful import Api, Resource
from flask_socketio import SocketIO
from time import time

import serial
import cv2
import json


app = Flask(__name__)
api = Api(app)
socketio = SocketIO(app)


class Sensor(Resource):
    def get(self,):
        with open("old.txt","r") as json_file:
            data = json.load(json_file,)
            data = json.loads(data)

            return data, 200


vc = cv2.VideoCapture(0) 
@app.route('/video') 
def index(): 
   """Video streaming .""" 
   return render_template('index.html') 
def gen(): 
   """Video streaming generator function.""" 
   while True: 
       rval, frame = vc.read() 
       cv2.imwrite('pic.jpg', frame) 
       yield (b'--frame\r\n' 
              b'Content-Type: image/jpeg\r\n\r\n' + open('pic.jpg', 'rb').read() + b'\r\n') 
@app.route('/video_feed') 
def video_feed(): 
   """Video streaming route. Put this in the src attribute of an img tag.""" 
   return Response(gen(), 
                   mimetype='multipart/x-mixed-replace; boundary=frame')

api.add_resource(Sensor, "/data")
#api.add_resource(VideoCamera, "/video")

if __name__ == "__main__":
    socketio.run(app, debug=False, host="192.168.1.79",)