---
title: MySQL数据库表设计的一个建议
categories:
  - SQL
  - MySQL
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2019-11-30 17:21:08
---
omit
<!--more-->

可以搜索"MySQL规约（阿里巴巴）"查看详情。  
表必备三字段: id, gmt_create, gmt_modified.  
说明：其中id必为主键，类型为unsigned bigint、单表时自增、步长为1。gmt_create和gmt_modified的类型均为date_time类型。  
备注：数据库表设计阶段中有个最佳实践，需要在每个表中预留创建时间create_time，修改时间update_time字段。  
下面是一个示例：
```sql
CREATE TABLE tb_test(
`id`          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
`tkey`        VARCHAR(512)        NULL UNIQUE,
`tvalue`      VARCHAR(512)        NULL,
`insert_time` DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
`update_time` DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
`update_tim2` DATETIME            NULL DEFAULT NULL              ON UPDATE CURRENT_TIMESTAMP
);
-- 可知UNIQUE无法对NULL保持唯一.
INSERT tb_test(tkey,tvalue)VALUES(NULL,'v1'),(NULL,'v2'),('k3','v3'),('k4','v4');
SELECT * FROM tb_test;
-- update_time自动赋值.
UPDATE tb_test SET tvalue='v3_1' WHERE tkey='k3';
SELECT * FROM tb_test;
-- 若指定了update_time的值，则使用指定值.
UPDATE tb_test SET tvalue='v3_2',update_time='2006-01-02 15:04:05' WHERE tkey='k3';
SELECT * FROM tb_test;
-- 若未真正修改，update_time的值不变.
UPDATE tb_test SET tvalue='v3_2' WHERE tkey='k3';
SELECT * FROM tb_test;
-- update_time自动赋值.
UPDATE tb_test SET tvalue='v3_3' WHERE tkey='k3';
SELECT * FROM tb_test;
```
为"tb_test"创建触发器：
```sql
DELIMITER //
DROP TRIGGER IF EXISTS `trg_tb_test_after_insert`;
//
CREATE TRIGGER `trg_tb_test_after_insert` AFTER INSERT ON `tb_test` FOR EACH ROW
BEGIN
-- TODO:call log_do8('tb_test','INSERT',new.id,new.tkey,new.tvalue,new.insert_time,new.update_time,new.update_tim2);
END;
//
DROP TRIGGER IF EXISTS `trg_tb_test_after_update`;
//
CREATE TRIGGER `trg_tb_test_after_update` AFTER UPDATE ON `tb_test` FOR EACH ROW
BEGIN
-- TODO:call log_do8('tb_test','UPDATE',new.id,new.tkey,new.tvalue,new.insert_time,new.update_time,new.update_tim2);
END;
//
DROP TRIGGER IF EXISTS `trg_tb_test_after_delete`;
//
CREATE TRIGGER `trg_tb_test_after_delete` AFTER DELETE ON `tb_test` FOR EACH ROW
BEGIN
-- TODO:call log_do8('tb_test','DELETE',old.id,old.tkey,old.tvalue,old.insert_time,old.update_time,old.update_tim2);
END;
//
DELIMITER ;
```
`LOAD DATA`的`REPLACE`是先删除再插入，所以不会触发`UPDATE`。  
假定路径为`./temp.csv`的文件的内容如下：
```
id,tkey,tvalue
3,k3,v3_load_data
4,k4,v4_load_data
```
那么执行`LOAD DATA`命令，并查看触发器的留痕情况，也能验证这个猜测：
```sql
LOAD DATA 
LOCAL 
INFILE './temp.csv' 
REPLACE 
INTO TABLE `tb_test` 
FIELDS TERMINATED BY ','  ENCLOSED BY '' ESCAPED BY '' 
LINES  TERMINATED BY '\n' STARTING BY '' 
IGNORE 1 LINES 
(id,tkey,tvalue);
```
