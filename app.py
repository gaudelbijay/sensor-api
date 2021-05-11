from flask import Flask
from flask_restful import Api, Resource
import sqlite3


app = Flask(__name__)
api = Api(app)

class Sensor(Resource):
    def get(self,):
        connection = sqlite3.connect("data.db")
        cursor = connection.cursor()
        datas = []
        query = "SELECT * FROM sensors"
        for row in cursor.execute(query):
            datas.append({"temperature": row[0], "humidity": row[1], "ph": row[2]}) 
        connection.close()
        return datas[0],200


api.add_resource(Sensor, "/data")

if __name__ == "__main__":
    app.run(debug=False, host="127.0.0.1", port=5000)