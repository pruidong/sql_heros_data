/*

11丨SQL99是如何使用连接的，与SQL92的区别是什么？

*/

-- ** 

-- 交叉连接

SELECT * FROM player CROSS JOIN team;

-- SELECT * FROM t1 CROSS JOIN t2 CROSS JOIN t3;

-- **

-- 自然连接

-- SQL92

SELECT player_id, a.team_id, player_name, height, team_name FROM player as a, team as b WHERE a.team_id = b.team_id;

-- SQL99

SELECT player_id, team_id, player_name, height, team_name FROM player NATURAL JOIN team 

-- **

-- ON连接

SELECT player_id, player.team_id, player_name, height, team_name FROM player JOIN team ON player.team_id = team.team_id；

SELECT p.player_name, p.height, h.height_level FROM player as p JOIN height_grades as h ON height BETWEEN h.height_lowest AND h.height_highest

-- USING连接

SELECT player_id, team_id, player_name, height, team_name FROM player JOIN team USING(team_id)


-- **

-- 外连接

-- 1. 左外连接

-- SQL92

-- SELECT * FROM player, team where player.team_id = team.team_id(+)

-- SQL99 

SELECT * FROM player LEFT JOIN team ON player.team_id = team.team_id;

-- 2. 右外连接

-- SQL92

-- SELECT * FROM player, team where player.team_id(+) = team.team_id

-- SQL99

SELECT * FROM player RIGHT JOIN team ON player.team_id = team.team_id

-- 3. 全外连接

-- SQL99

-- MySQL不支持.
SELECT * FROM player FULL JOIN team ON player.team_id = team.team_id;

-- **

-- 自连接

-- SQL92

SELECT b.player_name, b.height FROM player as a , player as b WHERE a.player_name = '布雷克 - 格里芬' and a.height < b.height;

-- SQL99

SELECT b.player_name, b.height FROM player as a JOIN player as b ON a.player_name = '布雷克 - 格里芬' and a.height < b.height;

-- **

-- 不同DBMS中使用连接需要注意的地方

-- 1. 不是所有的DBMS都支持全外连接;
-- 2. Oracle 没有表别名 AS
-- 3. SQLite的外连接只有左连接

---- 连接的性能问题注意事项

--- 1. 控制连接表的数量
--- 2. 在连接时不要忘记WHERE语句
--- 3. 使用自连接而不是子查询

-- **

-- 作业: 请你编写SQL查询语句,查询不同身高级别(对应height_grades表)对应的球员数量(对应player表).


select B.height_level,COUNT(*) from player  a left join height_grades b on a.height between b.height_lowest and b.height_highest group by b.height_level

/*

完整的SELECT语句内部执行顺序是：
	1、FROM子句组装数据（包括通过ON进行连接）
	2、WHERE子句进行条件筛选
	3、GROUP BY分组
	4、使用聚集函数进行计算；
	5、HAVING筛选分组；
	6、计算所有的表达式；
	7、SELECT 的字段；
	8、ORDER BY排序
	9、LIMIT筛选

*/
