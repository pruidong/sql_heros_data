# -*- coding: UTF-8 -*-
import mysql.connector

db = mysql.connector.connect(
       host="localhost",
       user="root",
       passwd="123456", 
       database='geektime-sql', 
       auth_plugin='mysql_native_password'
)

cursor = db.cursor()
try:
  sql = 'SELECT  name,hp_max from heros where hp_max>6000;'
  cursor.execute(sql)
  data = cursor.fetchall()
  for each_player in data:
    print(each_player)
finally:
  cursor.close()
  db.close()