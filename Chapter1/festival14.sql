/*

14丨什么是事务处理，如何使用COMMIT和ROLLBACK进行操作？

*/

-- 事务的特性: ACID

/*

我刚才提到了事务的特性：要么完全执行，要么都不执行。不过要对事务进行更深一步的理解，
还要从事务的 4 个特性说起，这 4 个特性用英文字母来表达就是 ACID。

1. A，也就是原子性（Atomicity）。原子的概念就是不可分割，你可以把它理解为组成物质的
基本单位，也是我们进行数据处理操作的基本单位。

2. C，就是一致性（Consistency）。一致性指的就是数据库在进行事务操作后，会由原来的一
致状态，变成另一种一致的状态。也就是说当事务提交后，或者当事务发生回滚后，数据库的
完整性约束不能被破坏。

3. I，就是隔离性（Isolation）。它指的是每个事务都是彼此独立的，不会受到其他事务的执行
影响。也就是说一个事务在提交之前，对其他事务都是不可见的。

4. 最后一个 D，指的是持久性（Durability）。事务提交之后对数据的修改是持久性的，即使在
系统出故障的情况下，比如系统崩溃或者存储介质发生故障，数据的修改依然是有效的。因为
当事务完成，数据库的日志就会被更新，这时可以通过日志，让系统恢复到最后一次成功的更
新状态。


*/


-- 事务的控制

/*

1. START TRANSACTION或者BEGIN,作用是显式开启一个事务.
2. COMMIT: 提交事务,当提交事务后,对数据库的修改是永久性的.
3. ROLLBACK或者ROLLBACK TO [SAVEPOINT],意为回滚事务.意思是撤销正在进行的所有没有提交的修改,或者将事务回滚到某个保存点.
4. SAVEPOINT: 在事务中创建保存点,方便后续针对保存点进行回滚.一个事务中可以存在多个保存点.
5. RELEASE SAVEPOINT: 删除某个保存点.
6. SET TRANSACTION,设置事务的隔离级别.

使用事务有两种方式,分别为隐式事务和显式事务.隐式事务实际上就是自动提交,Oracle默认不自动提交,需要手写COMMIT命令.而MySQL默认自动提交,当然我们可以配置MySQL的参数:

mysql> set autocommit =0;  // 关闭自动提交

mysql> set autocommit =1;  // 开启自动提交



*/

CREATE TABLE test(name varchar(255), PRIMARY KEY (name)) ENGINE=InnoDB;
BEGIN;
INSERT INTO test SELECT '关羽';
COMMIT;
BEGIN;
INSERT INTO test SELECT '张飞';
INSERT INTO test SELECT '张飞';
ROLLBACK;
SELECT * FROM test;


--

CREATE TABLE test(name varchar(255), PRIMARY KEY (name)) ENGINE=InnoDB;
BEGIN;
INSERT INTO test SELECT '关羽';
COMMIT;
INSERT INTO test SELECT '张飞';
INSERT INTO test SELECT '张飞';
ROLLBACK;
SELECT * FROM test;

--

CREATE TABLE test(name varchar(255), PRIMARY KEY (name)) ENGINE=InnoDB;
SET @@completion_type = 1;
BEGIN;
INSERT INTO test SELECT '关羽';
COMMIT;
INSERT INTO test SELECT '张飞';
INSERT INTO test SELECT '张飞';
ROLLBACK;
SELECT * FROM test;

/*

SET @@completion_type = 1;

1. completion=0，这是默认情况。也就是说当我们执行 COMMIT 的时候会提交事务，在执行下一个事务时，还需要我们使用 START TRANSACTION 或者 BEGIN 来开启。
2. completion=1，这种情况下，当我们提交事务后，相当于执行了 COMMIT AND CHAIN，也就是开启一个链式事务，即当我们提交事务之后会开启一个相同隔离级别的事务（隔离级别会在下一节中进行介绍）。
3. completion=2，这种情况下 COMMIT=COMMIT AND RELEASE，也就是当我们提交后，会自动与服务器断开连接。


事务特性的理解：原子性是基础，隔离性是手段，一致性是约束条件，持久性是目的

*/




