---
title: MySQL的binlog相关
categories:
  - SQL
  - MySQL
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2019-11-30 15:19:28
---
omit
<!--more-->

* MySQL的pdf文档
[PDF (US Ltr) (refman-8.0-en.pdf)](https://downloads.mysql.com/docs/refman-8.0-en.pdf)。  
[PDF (A4) (refman-8.0-en.a4.pdf)](https://downloads.mysql.com/docs/refman-8.0-en.a4.pdf)。  

* 几个(没什么用的)官方链接
[5.4.4 The Binary Log](https://dev.mysql.com/doc/refman/8.0/en/binary-log.html)。  
[5.8 Running Multiple MySQL Instances on One Machine](https://dev.mysql.com/doc/refman/8.0/en/multiple-servers.html)。  
[7.5 Point-in-Time (Incremental) Recovery Using the Binary Log](https://dev.mysql.com/doc/refman/8.0/en/point-in-time-recovery.html)。  

* binlog相关的几个链接
[【原创】研发应该懂的binlog知识(上)](https://www.cnblogs.com/rjzheng/p/9721765.html)。  
[Mariadb（Mysql）通过二进制日志实现数据恢复](https://blog.csdn.net/tuesdayma/article/details/80545434)。  
[Mysql使用binlog操作恢复数据解决失误操作](https://blog.csdn.net/qq_39038465/article/details/82015277)。  

* binlog相关的几个命令
查看binlog主要的变量值：`SHOW VARIABLES WHERE variable_name IN ('log_bin','binlog_format','log_bin_basename');`  
查看binlog相关的变量值：`SHOW VARIABLES WHERE variable_name REGEXP 'binlog|log_bin';`  
查看所有二进制文件列表：`SHOW BINARY LOGS;`  
查看当前日志是哪个文件：`SHOW MASTER STATUS;`  
查看指定日志记录的操作：`SHOW BINLOG EVENTS IN 'binlog.000021(日志文件名)';`  
切换binlog到新日志文件：`FLUSH LOGS;`  

* mysqlbinlog.exe
```bat
Usage: mysqlbinlog.exe [options] log-files
  -?, --help          Display this help and exit.
  -d, --database=name List entries for just this database (local log only).
  -r, --result-file=name 
                      Direct output to a given file. With --raw this is a
                      prefix for the file names.
  -j, --start-position=# 
                      Start reading the binlog at position N. Applies to the
                      first binlog passed on the command line.
  --stop-position=#   Stop reading the binlog at position N. Applies to the
                      last binlog passed on the command line.
  -v, --verbose       Reconstruct pseudo-SQL statements out of row events. -v
                      -v adds comments on column data types.
  --include-gtids=name 
                      Print events whose Global Transaction Identifiers were
                      provided.
  --exclude-gtids=name 
                      Print all events but those whose Global Transaction
                      Identifiers were provided.
  --no-defaults       Don't read default options from any option file,
                      except for login file.
```
一个语句：  
`mysqlbinlog.exe --no-defaults --verbose --database=某数据库 --result-file=某结果文件 ./data/binlog.000001`。  
`mysqlbinlog.exe --no-defaults  -v        -d        某数据库  -r           某结果文件 ./data/binlog.000001`。  
如果使用了`--database`那么可能会报警告：  
`WARNING: The option --database has been used. It may filter parts of transactions, but will include the GTIDs in any case. If you want to exclude or include transactions, you should use the options --exclude-gtids or --include-gtids, respectively, instead.`。  

* 示例
```sql
-- 创建数据库
CREATE DATABASE db_1;
CREATE DATABASE db_2;
-- 创建数据表
CREATE TABLE db_1.cash_info(
id      BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
user_id VARCHAR(32)     NOT NULL UNIQUE COMMENT '用户ID',
balance DECIMAL(30,10)  NOT NULL        COMMENT '余额'
);
CREATE TABLE db_2.cash_flow(
id      BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
user_id VARCHAR(32)     NOT NULL COMMENT '用户ID',
in_out  INT             NOT NULL COMMENT '入金:1;出金:2;',
amount  DECIMAL(30,10)  NOT NULL COMMENT '金额',
balance DECIMAL(30,10)  NOT NULL COMMENT '余额',
remark  VARCHAR(256)        NULL COMMENT '备注'
);
-- 创建存储过程
DELIMITER //
DROP PROCEDURE IF EXISTS db_2.pro_cash_flow;
//
CREATE PROCEDURE db_2.pro_cash_flow(
IN  i_user_id VARCHAR(32),
IN  i_in_out  INT,
IN  i_amount  DECIMAL(30,10),
IN  i_remark  VARCHAR(512),
OUT o_code    INT,
OUT o_message VARCHAR(256)
)
label:BEGIN
SET o_code    = 0;
SET o_message = 'SUCCESS';
IF i_in_out NOT IN (1,2) THEN
    SET o_code    = 1;
    SET o_message = CONCAT('invalid in_out=',i_in_out);
    LEAVE label;
END IF;
START TRANSACTION;
IF NOT EXISTS(SELECT 1 FROM db_1.cash_info WHERE user_id=i_user_id)THEN
    SET o_code    = 1;
    SET o_message = CONCAT('invalid user_id=',i_user_id);
    ROLLBACK;
    LEAVE label;
END IF;
UPDATE db_1.cash_info SET balance = balance + (3-2*i_in_out)*i_amount WHERE user_id=i_user_id;
INSERT INTO db_2.cash_flow(user_id,in_out,amount,balance,remark)VALUES(i_user_id,i_in_out,i_amount,(SELECT balance FROM db_1.cash_info WHERE user_id=i_user_id),i_remark);
COMMIT;
END;
//
DELIMITER ;
```
然后进行如下操作
```sql
-- 刷新和更换binlog
FLUSH LOGS;
SHOW MASTER STATUS;
SHOW BINLOG EVENTS IN 'binlog文件名';
-- 查询数据的语句
SELECT * FROM db_1.cash_info;
SELECT * FROM db_2.cash_flow;
-- 添加用户
INSERT INTO db_1.cash_info(user_id,balance)VALUES('test',0);
-- 用户入金
CALL db_2.pro_cash_flow('test', 1, 20, '入金', @o_code, @o_message);
SELECT @o_code, @o_message;
-- 【cmd】备份db_2库
mysqldump.exe -P 端口 -u root -p --events --routines --triggers -r ./dump.dump --databases db_2
-- 用户出金
CALL db_2.pro_cash_flow('test', 2, 10, '出金', @o_code, @o_message);
SELECT @o_code, @o_message;
-- 用户入金
CALL db_2.pro_cash_flow('test', 1, 15, '入金', @o_code, @o_message);
SELECT @o_code, @o_message;
```

* 
`ERROR 1418 (HY000): This function has none of DETERMINISTIC, NO SQL, or READS SQL DATA in its declaration and binary logging is enabled (you *might* want to use the less safe log_bin_trust_function_creators variable)`。  
[24.7 Stored Program Binary Logging](https://dev.mysql.com/doc/refman/8.0/en/stored-programs-logging.html)，  
由[binlog_format](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_format)可知，`binlog_format`的默认值是`ROW`，有效值为`ROW`、`STATEMENT`、`MIXED`共3个。  
我阅读了链接，然后有如下理解：  
当`binlog_format`为`STATEMENT`时，若要根据log恢复数据库，如果某函数在前后两次执行的结果不一致，则恢复后的数据就很可能有问题，如果`ROW`就没有这个问题；如果`SHOW VARIABLES WHERE variable_name='binlog_format'`是`ROW`，那么可以选择`SET GLOBAL log_bin_trust_function_creators = 1`以跳过检查。  
