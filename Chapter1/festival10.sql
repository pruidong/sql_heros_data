/*

常用的SQL标准有哪些，在SQL92中是如何使用连接的？

*/

-- ** 

-- 笛卡尔积

/*

笛卡尔乘积是一个数学运算.假设我有两个集合X和Y，那么X和Y的笛卡尔积就是X和Y的所有可能组合，也就是第一个对象来自于X，第二个对象来自于Y的所有可能.

*/

SELECT * FROM player;

SELECT * FROM team;


SELECT * FROM player, team;

-- **

-- 等值连接

-- 两张表的等值连接就是用两张表中都存在的列进行连接。

SELECT player_id, player.team_id, player_name, height, team_name FROM player, team WHERE player.team_id = team.team_id;

SELECT player_id, a.team_id, player_name, height, team_name FROM player AS a, team AS b WHERE a.team_id = b.team_id;

-- **

-- 非等值连接

-- 当我们进行多表查询的时候，如果连接多个表的条件是等号时，就是等值连接，其他的运算符连接就是非等值查询。


SELECT p.player_name, p.height, h.height_level FROM player AS p, height_grades AS h WHERE p.height BETWEEN h.height_lowest AND h.height_highest;


-- **

-- 外连接

-- 左连接

SELECT * FROM player LEFT JOIN team on player.team_id = team.team_id;

-- 右链接

SELECT * FROM player RIGHT JOIN team on player.team_id = team.team_id;


-- **

-- 自连接

-- ** 

SELECT b.player_name, b.height FROM player as a , player as b WHERE a.player_name = '布雷克 - 格里芬' and a.height < b.height;

SELECT height FROM player WHERE player_name = '布雷克 - 格里芬';

SELECT player_name, height FROM player WHERE height > 2.08;

-- **
