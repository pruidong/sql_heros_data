/*

7丨什么是SQL函数？为什么使用SQL函数可能会带来问题？

*/

-- 算术函数

-- ******

-- 取绝对值
SELECT ABS(-2);

-- 取余
SELECT MOD(101,3);

-- 四舍五入为指定的小数位数,需要两个参数,分别为字段名称、小数位数
SELECT ROUND(37.25,1);

-- ***

-- 字符串函数

-- 拼接字符串
SELECT CONCAT('abc',123);

-- 计算字段的长度(一个汉字算三个字符,一个数字或字母算一个字符)
SELECT LENGTH('你好');

-- 计算字段长度,汉字、数字、字母都算一个字符
SELECT CHAR_LENGTH('你好');

-- 字符串转小写
SELECT LOWER('MYSQL');

-- 字符串转大写
SELECT UPPER('mysql');

-- 替换函数. 分别为:要替换的表达式或字段名、想要查找被替换的字符串、替换成哪个字符串
SELECT REPLACE('myabc','abc','sql');

-- 截取字符串,分别为:待截取的表达式或字段名、开始截取的位置、想要截取的字符串长度
SELECT SUBSTRING('mysqloracle',1,5);

-- ***

-- 日期函数

-- ***

-- 系统当前日期
SELECT CURRENT_DATE();

-- 系统当前时间,没有具体的日期
SELECT CURRENT_TIME();

-- 系统当前时间,包括具体的日期+时间
SELECT CURRENT_TIMESTAMP();

-- 抽取具体的年、月、日
/*

EXTRACT() | 抽取具体的年、月、日
DATE() | 返回时间的日期部分
YEAR() | 返回时间的年份部分
MONTH() | 返回时间的月份部分
DAY() | 返回时间的天数部分
HOUR() | 返回时间的小时部分
MINUTE() | 返回时间的分钟部分
SECOND() | 返回时间的秒部分

*/
SELECT EXTRACT(YEAR FROM CURRENT_DATE());

-- 返回时间的日期部分
SELECT DATE(CURRENT_TIMESTAMP());

-- 注意: DATE日期格式必须是yyyy-mm-dd的形式.

-- ***

-- 转换函数

-- ***

-- 数据类型转换,参数是一个表达式，分别是原始数据和目标数据类型.

--  会报错.
-- CAST函数在转换数据类型的时候,不会四舍五入.
-- 如果原数值有小数,那么转换为整数类型的时候就会报错.
SELECT CAST(123.123 AS INT); 


SELECT CAST(123.123 AS DECIMAL(8,2));

-- 返回第一个非空值
SELECT COALESCE(null,'aass','bbbb');

-- ***

-- 用SQL函数对王者荣耀英雄数据做处理

-- ***

SELECT name, ROUND(attack_growth,1) FROM heros;

SELECT MAX(hp_max) FROM heros;

SELECT name, hp_max FROM heros WHERE hp_max = (SELECT MAX(hp_max) FROM heros);

SELECT CHAR_LENGTH(name), name FROM heros;

SELECT name, EXTRACT(YEAR FROM birthdate) AS birthdate FROM heros WHERE birthdate is NOT NULL;

SELECT name, YEAR(birthdate) AS birthdate FROM heros WHERE birthdate is NOT NULL;

SELECT * FROM heros WHERE DATE(birthdate)>'2016-10-01';

-- 写法不安全,因为很多时候你无法确认birthdate的数据类型是字符串还是datetime类型.
-- 如果需要对日期部分进行比较,那么使用DATE(birthdate)来进行比较是更安全的.
SELECT * FROM heros WHERE birthdate>'2016-10-01';

SELECT AVG(hp_max), AVG(mp_max), MAX(attack_max) FROM heros WHERE DATE(birthdate)>'2016-10-01';

-- ***

-- 为什么使用SQL函数会带来问题

/*

DBMS的差异性很大,不同的DBMS对SQL函数的支持与语法可能不一样.

*/

-- 关于大小写的规范

/*

命名规范的建议:

1. 关键字和函数名称全部大写;
2. 数据库名、表名、字段名称全部小写;
3. SQL语句必须以分号结尾.

*/


-- 作业: 计算英雄的最大生命平均值
SELECT ROUND(AVG(hp_max),2) FROM heros ;

-- 作业: 显示出所有在2017年之前上线的英雄,如果英雄没有统计上线日期则不显示.
SELECT * FROM heros WHERE YEAR(birthdate)<2017 and birthdate IS NOT NULL;


