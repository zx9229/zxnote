---
title: MySQL创建日志数据库表打印日志
categories:
  - SQL
  - MySQL
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2019-05-28 19:14:49
---
略。
<!-- more -->
```SQL
DELIMITER //
DROP PROCEDURE IF EXISTS `log_do`;
//
CREATE PROCEDURE `log_do`(
    IN i_f1 VARCHAR(512),
    IN i_f2 VARCHAR(512),
    IN i_f3 VARCHAR(512),
    IN i_f4 VARCHAR(512),
    IN i_f5 VARCHAR(512),
    IN i_f6 VARCHAR(512),
    IN i_f7 VARCHAR(512),
    IN i_f8 VARCHAR(512),
    IN i_f9 VARCHAR(512)
)
label: BEGIN
START TRANSACTION;
IF NOT EXISTS(SELECT `table_schema`,`table_name` FROM `information_schema`.`tables` WHERE `table_name`='log_tb')THEN
    CREATE TABLE log_tb(
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `tm` TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP(6),
    `f1` VARCHAR(512),
    `f2` VARCHAR(512),
    `f3` VARCHAR(512),
    `f4` VARCHAR(512),
    `f6` VARCHAR(512),
    `f7` VARCHAR(512),
    `f8` VARCHAR(512),
    `f9` VARCHAR(512)
    );
END IF;
INSERT INTO log_tb(`f1`,`f2`,`f3`,`f4`,`f6`,`f7`,`f8`,`f9`)VALUES(i_f1,i_f2,i_f3,i_f4,i_f6,i_f7,i_f8,i_f9);
COMMIT;
END label;
-- ****************************************************************************
//
DROP PROCEDURE IF EXISTS `log_do1`;
//
CREATE PROCEDURE `log_do1`(
    IN i_f1 VARCHAR(512)
)
BEGIN
CALL log_do(i_f1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
END;
-- ****************************************************************************
//
DROP PROCEDURE IF EXISTS `log_do2`;
//
CREATE PROCEDURE `log_do2`(
    IN i_f1 VARCHAR(512),
    IN i_f2 VARCHAR(512)
)
BEGIN
CALL log_do(i_f1,i_f2,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
END;
-- ****************************************************************************
//
DROP PROCEDURE IF EXISTS `log_do3`;
//
CREATE PROCEDURE `log_do3`(
    IN i_f1 VARCHAR(512),
    IN i_f2 VARCHAR(512),
    IN i_f3 VARCHAR(512)
)
BEGIN
CALL log_do(i_f1,i_f2,i_f3,NULL,NULL,NULL,NULL,NULL,NULL);
END;
-- ****************************************************************************
//
DROP PROCEDURE IF EXISTS `log_do4`;
//
CREATE PROCEDURE `log_do4`(
    IN i_f1 VARCHAR(512),
    IN i_f2 VARCHAR(512),
    IN i_f3 VARCHAR(512),
    IN i_f4 VARCHAR(512)
)
BEGIN
CALL log_do(i_f1,i_f2,i_f3,i_f4,NULL,NULL,NULL,NULL,NULL);
END;
-- ****************************************************************************
//
DROP PROCEDURE IF EXISTS `log_do5`;
//
CREATE PROCEDURE `log_do5`(
    IN i_f1 VARCHAR(512),
    IN i_f2 VARCHAR(512),
    IN i_f3 VARCHAR(512),
    IN i_f4 VARCHAR(512),
    IN i_f5 VARCHAR(512)
)
BEGIN
CALL log_do(i_f1,i_f2,i_f3,i_f4,i_f5,NULL,NULL,NULL,NULL);
END;
-- ****************************************************************************
//
DROP PROCEDURE IF EXISTS `log_do6`;
//
CREATE PROCEDURE `log_do6`(
    IN i_f1 VARCHAR(512),
    IN i_f2 VARCHAR(512),
    IN i_f3 VARCHAR(512),
    IN i_f4 VARCHAR(512),
    IN i_f5 VARCHAR(512),
    IN i_f6 VARCHAR(512)
)
BEGIN
CALL log_do(i_f1,i_f2,i_f3,i_f4,i_f5,i_f6,NULL,NULL,NULL);
END;
-- ****************************************************************************
//
DROP PROCEDURE IF EXISTS `log_do7`;
//
CREATE PROCEDURE `log_do7`(
    IN i_f1 VARCHAR(512),
    IN i_f2 VARCHAR(512),
    IN i_f3 VARCHAR(512),
    IN i_f4 VARCHAR(512),
    IN i_f5 VARCHAR(512),
    IN i_f6 VARCHAR(512),
    IN i_f7 VARCHAR(512)
)
BEGIN
CALL log_do(i_f1,i_f2,i_f3,i_f4,i_f5,i_f6,i_f7,NULL,NULL);
END;
-- ****************************************************************************
//
DROP PROCEDURE IF EXISTS `log_do8`;
//
CREATE PROCEDURE `log_do8`(
    IN i_f1 VARCHAR(512),
    IN i_f2 VARCHAR(512),
    IN i_f3 VARCHAR(512),
    IN i_f4 VARCHAR(512),
    IN i_f5 VARCHAR(512),
    IN i_f6 VARCHAR(512),
    IN i_f7 VARCHAR(512),
    IN i_f8 VARCHAR(512)
)
BEGIN
CALL log_do(i_f1,i_f2,i_f3,i_f4,i_f5,i_f6,i_f7,i_f8,NULL);
END;
//
DELIMITER ;
```
清理语句
```SQL
DELIMITER //
DROP     TABLE IF EXISTS `log_tb`;
DROP PROCEDURE IF EXISTS `log_do`;
DROP PROCEDURE IF EXISTS `log_do1`;
DROP PROCEDURE IF EXISTS `log_do2`;
DROP PROCEDURE IF EXISTS `log_do3`;
DROP PROCEDURE IF EXISTS `log_do4`;
DROP PROCEDURE IF EXISTS `log_do5`;
DROP PROCEDURE IF EXISTS `log_do6`;
DROP PROCEDURE IF EXISTS `log_do7`;
DROP PROCEDURE IF EXISTS `log_do8`;
//
DELIMITER ;
```
