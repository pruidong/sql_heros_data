/*

16丨游标：当我们需要逐条处理数据时，该怎么做？

*/

-- 什么是游标

SELECT id, name, hp_max FROM heros WHERE hp_max > 8500;

-- 如何使用游标

-- 1. 定义游标

-- 适用于MySQL,SQLServer,DB2,MariaDB.
DECLARE cursor_name CURSOR FOR select_statement;

-- Oracle或者PostgreSQL.

DECLARE cursor_name CURSOR IS select_statement;


DECLARE cur_hero CURSOR FOR SELECT hp_max FROM heros;

-- 2. 打开游标

OPEN cursor_name;

-- 3. 从游标中取得数据

FETCH cursor_name INTO var_name ...


-- 4. 关闭游标

CLOSE cursor_name;

-- 5. 释放游标

DEALLOCATE PREPARE;



CREATE PROCEDURE `calc_hp_max`()
BEGIN
       -- 创建接收游标的变量
       DECLARE hp INT;  
       -- 创建总数变量 
       DECLARE hp_sum INT DEFAULT 0;
       -- 创建结束标志变量  
       DECLARE done INT DEFAULT false;
       -- 定义游标     
       DECLARE cur_hero CURSOR FOR SELECT hp_max FROM heros;
       
       OPEN cur_hero;
       read_loop:LOOP 
       FETCH cur_hero INTO hp;
       SET hp_sum = hp_sum + hp;
       END LOOP;
       CLOSE cur_hero;
       SELECT hp_sum;
       DEALLOCATE PREPARE cur_hero;
END


DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = true;  


CREATE PROCEDURE `calc_hp_max`()
BEGIN
       -- 创建接收游标的变量
       DECLARE hp INT;  

       -- 创建总数变量 
       DECLARE hp_sum INT DEFAULT 0;
       -- 创建结束标志变量  
     DECLARE done INT DEFAULT false;
       -- 定义游标     
       DECLARE cur_hero CURSOR FOR SELECT hp_max FROM heros;
       -- 指定游标循环结束时的返回值  
     DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = true;  
       
       OPEN cur_hero;
       read_loop:LOOP 
       FETCH cur_hero INTO hp;
       -- 判断游标的循环是否结束  
       IF done THEN  
                     LEAVE read_loop;
       END IF; 
              
       SET hp_sum = hp_sum + hp;
       END LOOP;
       CLOSE cur_hero;
       SELECT hp_sum;
       DEALLOCATE PREPARE cur_hero;
END


-- 使用游标来解决一些常见的问题

SELECT SUM(hp_max) FROM heros;


CREATE PROCEDURE `alter_attack_growth`()
BEGIN
       -- 创建接收游标的变量
       DECLARE temp_id INT;  
       DECLARE temp_growth, temp_max, temp_start, temp_diff FLOAT;  

       -- 创建结束标志变量  
       DECLARE done INT DEFAULT false;
       -- 定义游标     
       DECLARE cur_hero CURSOR FOR SELECT id, attack_growth, attack_max, attack_start FROM heros;
       -- 指定游标循环结束时的返回值  
       DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = true;  
       
       OPEN cur_hero;  
       FETCH cur_hero INTO temp_id, temp_growth, temp_max, temp_start;
       REPEAT
                     IF NOT done THEN
                            SET temp_diff = temp_max - temp_start;
                            IF temp_growth < 5 THEN
                                   IF temp_diff > 200 THEN
                                          SET temp_growth = temp_growth * 1.1;
                                   ELSEIF temp_diff >= 150 AND temp_diff <=200 THEN
                                          SET temp_growth = temp_growth * 1.08;
                                   ELSEIF temp_diff < 150 THEN
                                          SET temp_growth = temp_growth * 1.07;
                                   END IF;                       
                            ELSEIF temp_growth >=5 AND temp_growth <=10 THEN
                                   SET temp_growth = temp_growth * 1.05;
                            END IF;
                            UPDATE heros SET attack_growth = ROUND(temp_growth,3) WHERE id = temp_id;
                     END IF;
       FETCH cur_hero INTO temp_id, temp_growth, temp_max, temp_start;
       UNTIL done = true END REPEAT;
       
       CLOSE cur_hero;
       DEALLOCATE PREPARE cur_hero;
END


SELECT heros.id, heros.attack_growth, heros_copy1.attack_growth FROM heros JOIN heros_copy1 WHERE heros.id = heros_copy1.id






