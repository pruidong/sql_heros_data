# -*- coding: UTF-8 -*-
import mysql.connector
# 打开数据库连接
db = mysql.connector.connect(
       host="localhost",
       user="root",
       passwd="123456", # 写上你的数据库密码
       database='geektime-sql', 
       auth_plugin='mysql_native_password'
)
# 获取操作游标 
cursor = db.cursor()
# 执行 SQL 语句
# 插入新球员
sql = "INSERT INTO player (team_id, player_name, height) VALUES (%s, %s, %s)"
val = (1003, " 约翰 - 科林斯 ", 2.08)
cursor.execute(sql, val)
db.commit()
print(cursor.rowcount, " 记录插入成功。")
# 关闭游标 & 数据库连接
cursor.close()
db.close()