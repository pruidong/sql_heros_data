/*

08丨什么是SQL的聚集函数，如何利用它们汇总表的数据？

*/

-- 聚集函数都有哪些

/*

COUNT():总行数
MAX():最大值
MIN():最小值
SUM():求和
AVG():平均值

*/

-- **

SELECT COUNT(*) FROM heros WHERE hp_max > 6000;


SELECT COUNT(role_assist) FROM heros WHERE hp_max > 6000;

-- COUNT(*)只统计数据行数,不管某个字段是否为NULL.
-- COUNT(role_assist)会忽略为NULL的数据行.

SELECT MAX(hp_max) FROM heros WHERE role_main = '射手' or role_assist = '射手';

SELECT COUNT(*), AVG(hp_max), MAX(mp_max), MIN(attack_max), SUM(defense_max) FROM heros WHERE role_main = '射手' or role_assist = '射手';

-- AVG,MAX,MIN等聚集函数会自动忽略值为NULL的数据行,MAX和MIN函数月可以用于字符串类型数据的统计,如果是英文字母,则按照A-Z的顺序排列,越往后,数值越大.
-- 如果是汉字则按照全拼拼音进行排列.

SELECT MIN(CONVERT(name USING gbk)), MAX(CONVERT(name USING gbk)) FROM heros;

SELECT COUNT(DISTINCT hp_max) FROM heros;

SELECT ROUND(AVG(DISTINCT hp_max), 2) FROM heros;

-- **

-- 如何对数据进行分组,并进行聚集统计

SELECT COUNT(*), role_main FROM heros GROUP BY role_main;

SELECT COUNT(*), role_assist FROM heros GROUP BY role_assist;

SELECT COUNT(*) as num, role_main, role_assist FROM heros GROUP BY role_main, role_assist ORDER BY num desc;

-- 如何使用HAVING过滤分组,它与WHERE的区别是什么?

SELECT COUNT(*) as num, role_main, role_assist FROM heros GROUP BY role_main, role_assist HAVING num > 5 ORDER BY num DESC

SELECT COUNT(*) as num, role_main, role_assist FROM heros WHERE hp_max > 6000 GROUP BY role_main, role_assist HAVING num > 5 ORDER BY num DESC

-- **

-- 作业

-- **

/*

1. 筛选最大生命值大于 6000 的英雄，按照主要定位进行分组，选择分组英雄数量大于 5 的分组，按照分组英雄数从高到低进行排序，并显示每个分组的英雄数量、主要定位和平均最大生命值。

*/

select count(*) as num,role_main,AVG(hp_max) from heros where hp_max>6000 group by role_main having num>5 order by num desc;

-- 

/*

2. 筛选最大生命值与最大法力值之和大于 7000 的英雄，按照攻击范围来进行分组，显示分组的英雄数量，以及分组英雄的最大生命值与法力值之和的平均值、最大值和最小值，并按照分组英雄数从高到低进行排序，其中聚集函数的结果包括小数点后两位。

*/

select count(*) as num,round(avg(hp_max+mp_max),2) as avgnum,round(max(hp_max+mp_max),2) as maxnum,round(min(hp_max+mp_max),2) as minnum from heros where (hp_max+mp_max)>7000 group by attack_range  order by num desc;





