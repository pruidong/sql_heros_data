/*

09丨子查询：子查询的种类都有哪些，如何提高子查询的性能？

*/

-- **

-- 什么是关联子查询，什么是非关联子查询

/*
子查询从数据表中查询了数据结果,如果这个数据结果只执行一次,然后这个数据结果作为主查询的条件进行执行,那么这样的子查询叫做非关联子查询.

如果子查询需要执行多次,即采用循环的方式,先从外部查询开始,每次都传入子查询进行查询,然后再将结果反馈给外部,这种嵌套的执行方式就称为关联子查询.

*/


SELECT player_name, height FROM player WHERE height = (SELECT max(height) FROM player);

SELECT player_name, height, team_id FROM player AS a WHERE height > (SELECT avg(height) FROM player AS b WHERE a.team_id = b.team_id);

-- **

-- EXIST 子查询

-- **

SELECT player_id, team_id, player_name FROM player WHERE EXISTS (SELECT player_id FROM player_score WHERE player.player_id = player_score.player_id);

SELECT player_id, team_id, player_name FROM player WHERE NOT EXISTS (SELECT player_id FROM player_score WHERE player.player_id = player_score.player_id);

-- **

-- 集合比较子查询

-- **

SELECT player_id, team_id, player_name FROM player WHERE player_id in (SELECT player_id FROM player_score WHERE player.player_id = player_score.player_id);

SELECT player_id, player_name, height FROM player WHERE height > ANY (SELECT height FROM player WHERE team_id = 1002);

SELECT player_id, player_name, height FROM player WHERE height > ALL (SELECT height FROM player WHERE team_id = 1002);

-- **

-- 将子查询作为计算字段

-- **

SELECT team_name, (SELECT count(*) FROM player WHERE player.team_id = team.team_id) AS player_num FROM team;

-- 作业: 请你使用子查询,编写SQL语句,得到场均得分大于20的球员。
-- 场均得分从player_score表中获取,同时你需要输出球员的ID、球员姓名以及所在球队的ID信息.

-- ** 



