/*

13丨什么是存储过程，在实际项目中用得多么？

*/

-- 什么是存储过程,如何创建一个存储过程

-- 定义一个存储过程

/*
CREATE PROCEDURE 存储过程名称 ([参数列表])
BEGIN
    需要执行的语句
END    
*/


CREATE PROCEDURE `add_num`(IN n INT)
BEGIN
       DECLARE i INT;
       DECLARE sum INT;
       
       SET i = 1;
       SET sum = 0;
       WHILE i <= n DO
              SET sum = sum + i;
              SET i = i +1;
       END WHILE;
       SELECT sum;
END


-- 

DELIMITER //
CREATE PROCEDURE `add_num1`(IN n INT)
BEGIN
       DECLARE i INT;
       DECLARE sum INT;
       
       SET i = 1;
       SET sum = 0;
       WHILE i <= n DO
              SET sum = sum + i;
              SET i = i +1;
       END WHILE;
       SELECT sum;
END //
DELIMITER ;


-- 

CREATE PROCEDURE `get_hero_scores`(
       OUT max_max_hp FLOAT,
       OUT min_max_mp FLOAT,
       OUT avg_max_attack FLOAT,  
       s VARCHAR(255)
       )
BEGIN
       SELECT MAX(hp_max), MIN(mp_max), AVG(attack_max) FROM heros WHERE role_main = s INTO max_max_hp, min_max_mp, avg_max_attack;
END


-- 要一起执行:

CALL get_hero_scores(@max_max_hp, @min_max_mp, @avg_max_attack, '战士');
SELECT @max_max_hp, @min_max_mp, @avg_max_attack;

-- **

-- 流控制语句


CASE 
    WHEN expression1 THEN ...
    WHEN expression2 THEN ...
    ...
    ELSE 
    --ELSE 语句可以加，也可以不加。加的话代表的所有条件都不满足时采用的方式。
END


-- 作业

定义:

DELIMITER //
CREATE PROCEDURE `get_sum_score`(
       OUT sum_max_hp FLOAT,
       s VARCHAR(255)
       )
BEGIN
       SELECT SUM(hp_max) FROM heros WHERE role_main = s INTO sum_max_hp;
end //
DELIMITER ;


查询: 

call get_sum_score(@sum_hp_max,'坦克');
select @sum_hp_max;

查询结果:

@sum_hp_max|
-----------|
      83124|


查询2:

call get_sum_score(@sum_hp_max,'战士');
select @sum_hp_max;

查询结果:

@sum_hp_max|
-----------|
     124873|









































