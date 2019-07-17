/*

15丨初识事务隔离：隔离的级别有哪些，它们都解决了哪些异常问题？

*/

-- 事务并发处理可能存在的异常都有哪些?


-- ----------------------------
-- Table structure for heros_temp
-- ----------------------------
DROP TABLE IF EXISTS `heros_temp`;
CREATE TABLE `heros_temp`  (
  `id` int(11) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of heros_temp
-- ----------------------------
INSERT INTO `heros_temp` VALUES (1, '张飞');
INSERT INTO `heros_temp` VALUES (2, '关羽');
INSERT INTO `heros_temp` VALUES (3, '刘备');

-- SQL> 开头表示为使用命令行操作.
SQL> BEGIN;
SQL> INSERT INTO heros_temp values(4, '吕布');
SQL> SELECT * FROM heros_temp;

/*

脏读: 还没提交事务,其余人已经看到没提交的数据.

*/

SQL> SELECT name FROM heros_temp WHERE id = 1;


SQL> BEGIN;
SQL> UPDATE heros_temp SET name = '张翼德' WHERE id = 1;


SQL> SELECT name FROM heros_temp WHERE id = 1;


/*

不可重复读: 同一条记录,两次读取的结果不同.

*/

SQL> SELECT * FROM heros_temp;

SQL> BEGIN;
SQL> INSERT INTO heros_temp values(4, '吕布');


SQL> SELECT * FROM heros_temp;


/*

脏读：读到了其他事务还没有提交的数据。

不可重复读：对某数据进行读取，发现两次读取的结果不同，也就是说没有读到相同的内容。这是因为有其他事务对这个数据同时进行了修改或删除。

幻读：事务 A 根据条件查询得到了 N 条数据，但此时事务 B 更改或者增加了 M 条符合事务 A 查询条件的数据，这样当事务 A 再次进行查询的时候发现会有 N+M 条数据，产生了幻读。

*/

-- 事务的隔离级别有哪些

/*

------------------------------------------------------
隔离级别名称 					| 脏读 | 不可重复读 | 幻读
------------------------------------------------------
读未提交(READ UNCOMMITTED)  |允许  | 允许      | 允许
读已提交(READ COMMITTED)	    |禁止  | 允许      | 允许
可重复读(REPEATABLE READ)  	 |禁止  | 禁止      | 允许
可串行化(SERIALIZABLE)		 |禁止	| 禁止      | 禁止
------------------------------------------------------



1. 读未提交，也就是允许读到未提交的数据，这种情况下查询是不会使用锁的，可能会产生脏读、不可重复读、幻读等情况。

2. 读已提交就是只能读到已经提交的内容，可以避免脏读的产生，属于 RDBMS 中常见的默认隔离级别（比如说 Oracle 和 SQL Server），但如果想要避免不可重复读或者幻读，就需要我们在 SQL 查询的时候编写带加锁的 SQL 语句。

3. 可重复读，保证一个事务在相同查询条件下两次查询得到的数据结果是一致的，可以避免不可重复读和脏读，但无法避免幻读。MySQL 默认的隔离级别就是可重复读。

4. 可串行化，将事务进行串行化，也就是在一个队列中按照顺序执行，可串行化是最高级别的隔离等级，可以解决事务读取中所有可能出现的异常情况，但是它牺牲了系统的并发性。

*/


-- 使用MySQL客户端来模拟三种异常

-- mysql> 为mysql客户端的提示.
--  ./mysql -h localhost -uroot -p 登录MySQL客户端.在MySQL的安装路径的bin目录下面执行.

mysql> SHOW VARIABLES LIKE 'transaction_isolation';

-- 在老版本中,比如我的:5.7.11 中,上面的语句应该为下面的这样:
mysql> SHOW VARIABLES LIKE 'tx_isolation';

mysql> SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

mysql> SET autocommit = 0;

mysql> SHOW VARIABLES LIKE 'autocommit';

-- 模拟'脏读'

-- 客户端2,不要提交事务.

BEGIN;
INSERT INTO heros_temp values(4, '吕布');

-- 客户端1

SELECT * FROM heros_temp;

-- 客户端1中读取了客户端2未提交的新英雄'吕布',实际上客户端2可能马上回滚,从而造成了'脏读'.

-- 模拟'不可重复读'


mysql> BEGIN;
mysql> UPDATE heros_temp SET name = '张翼德' WHERE id = 1;

-- 对于客户端1来说,同一条查询语句出现了'不可重复读'.

-- 模拟'幻读'

-- 客户端1

SELECT * FROM heros_temp;

-- 客户端2,不要提交事务.

BEGIN;
INSERT INTO heros_temp values(4, '吕布');

-- 查询某一个范围的数据行变多了或者少了





/*

不可重复读 VS 幻读的区别：


不可重复读是同一条记录的内容被修改了，重点在于UPDATE或DELETE
幻读是查询某一个范围的数据行变多了或者少了，重点在于INSERT
*/

