import sqlite3

connection = sqlite3.connect("data.db")
cursor = connection.cursor() # TODO
create_table = "CREATE TABLE sensors (temperature real, humidity real, ph real)"
cursor.execute(create_table)
insert_value = "INSERT INTO sensors VALUES (?,?,?)"
cursor.execute(insert_value, (15, 23, 35)) #TODO
connection.commit()
connection.close()
