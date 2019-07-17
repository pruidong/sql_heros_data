/*

12丨视图在SQL中的作用是什么，它是怎样工作的？

*/

-- **

-- 如何创建，更新和删除视图

--- 创建视图: CREATE VIEW

---- 创建视图的语法:

CREATE VIEW view_name AS
SELECT column1, column2
FROM table
WHERE condition

-- 创建视图:

CREATE VIEW player_above_avg_height AS
SELECT player_id, height
FROM player
WHERE height > (SELECT AVG(height) from player);

-- 查询:

SELECT * FROM player_above_avg_height;

--- 嵌套视图

CREATE VIEW player_above_above_avg_height AS
SELECT player_id, height
FROM player
WHERE height > (SELECT AVG(height) from player_above_avg_height);


-- 修改视图:ALTER VIEW

-- 语法:

ALTER VIEW view_name AS
SELECT column1, column2
FROM table
WHERE condition;

-- 示例:

ALTER VIEW player_above_avg_height AS
SELECT player_id, player_name, height
FROM player
WHERE height > (SELECT AVG(height) from player);

SELECT * FROM player_above_avg_height;


--- 删除视图:DROP VIEW

-- 语法:

DROP VIEW view_name;

-- 示例:

DROP VIEW player_above_avg_height

--- SQLite不支持视图的修改,仅支持只读视图.也就是如果要修改,则只能先DROP然后CREATE.

-- 如何使用视图简化SQL操作

--- 利用视图完成复杂的连接

CREATE VIEW player_height_grades AS
SELECT p.player_name, p.height, h.height_level
FROM player as p JOIN height_grades as h
ON height BETWEEN h.height_lowest AND h.height_highest;

SELECT * FROM player_height_grades WHERE height >= 1.90 AND height <= 2.08;


-- 利用视图对数据进行格式化

CREATE VIEW player_team AS 
SELECT CONCAT(player_name, '(' , team.team_name , ')') AS player_team FROM player JOIN team WHERE player.team_id = team.team_id;

SELECT * FROM player_team;

-- 使用视图与计算字段

CREATE VIEW game_player_score AS
SELECT game_id, player_id, (shoot_hits-shoot_3_hits)*2 AS shoot_2_points, shoot_3_hits*3 AS shoot_3_points, shoot_p_hits AS shoot_p_points, score  FROM player_score；

SELECT * FROM game_player_score;

-- 视图是虚拟表,有些RDBMS不支持对视图创建索引.

