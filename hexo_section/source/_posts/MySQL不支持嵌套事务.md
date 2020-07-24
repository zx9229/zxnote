---
title: MySQL不支持嵌套事务
categories:
  - SQL
  - MySQL
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2020-07-24 18:37:22
---
omit
<!--more-->

MySQL不支持嵌套事务。示例如下：
```SQL
-- ============================================================================
DROP TABLE IF EXISTS tb_test_base;
CREATE TABLE tb_test_base( -- 基础表
`id`          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
`name`        VARCHAR(32)     NOT NULL UNIQUE,
`data`        VARCHAR(256)    NOT NULL DEFAULT '',
`insert_time` DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
`update_time` DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
-- ============================================================================
DROP TABLE IF EXISTS tb_test_extension;
CREATE TABLE tb_test_extension( -- 扩展表
`id`          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
`name`        VARCHAR(32)     NOT NULL UNIQUE,
`data`        VARCHAR(256)    NOT NULL DEFAULT '',
`insert_time` DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
`update_time` DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
-- ============================================================================
DROP TABLE IF EXISTS tb_test_log;
CREATE TABLE tb_test_log( -- 日志表
`id`          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
`table_name`  VARCHAR(128)    NOT NULL DEFAULT '',
`field_1`     VARCHAR(256)        NULL,
`field_2`     VARCHAR(256)        NULL,
`insert_time` DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
`update_time` DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
-- ============================================================================
INSERT INTO tb_test_base     (name,data)VALUES('a1','data'),('b2','data');
INSERT INTO tb_test_extension(name,data)VALUES('a1','data');
-- ============================================================================
-- 单个存储过程里面存在嵌套的事务,失效
DELIMITER //
DROP PROCEDURE IF EXISTS `proModifyTotal`;
//
CREATE DEFINER=CURRENT_USER PROCEDURE `proModifyTotal`
(
    IN  i_name VARCHAR(32),
    OUT o_code INT,
    OUT o_mesg VARCHAR(256)
)
procedure_label: BEGIN

DECLARE v_data_base VARCHAR(256);
DECLARE v_data_ext  VARCHAR(256);

SET v_data_base = CONCAT(i_name, '_base_', NOW());
SET v_data_ext  = CONCAT(i_name, '_ext__', NOW());

START TRANSACTION; -- 外部事务

START TRANSACTION; -- 内部事务1
IF EXISTS(SELECT 1 FROM tb_test_base WHERE name=i_name) THEN
    UPDATE tb_test_base SET name=i_name, data=v_data_base WHERE name=i_name;
    INSERT INTO tb_test_log(table_name,field_1,field_2)VALUES('tb_test_base',i_name,v_data_base);
    SET o_code = 0;
    COMMIT; -- 内部事务1
ELSE
    SET o_code = 1;
    SET o_mesg = CONCAT('name=',i_name,' not exists in tb_test_base');
    ROLLBACK; -- 内部事务1
END IF;

IF o_code <> 0 THEN
    ROLLBACK; -- 外部事务
END IF;

START TRANSACTION; -- 内部事务2
IF EXISTS(SELECT 1 FROM tb_test_extension WHERE name=i_name) THEN
    UPDATE tb_test_extension SET name=i_name, data=v_data_ext WHERE name=i_name;
    INSERT INTO tb_test_log(table_name,field_1,field_2)VALUES('tb_test_extension',i_name,v_data_ext);
    SET o_code = 0;
    COMMIT; -- 内部事务2
ELSE
    SET o_code = 1;
    SET o_mesg = CONCAT('name=',i_name,' not exists in tb_test_extension');
    ROLLBACK; -- 内部事务2
END IF;

IF o_code <> 0 THEN
    ROLLBACK; -- 外部事务
END IF;

COMMIT; -- 外部事务

END procedure_label;
//
DELIMITER ;
-- ============================================================================
DELIMITER //
DROP PROCEDURE IF EXISTS `proModifyBase`;
//
CREATE DEFINER=CURRENT_USER PROCEDURE `proModifyBase`
(
    IN  i_name VARCHAR(32),
    OUT o_code INT,
    OUT o_mesg VARCHAR(256)
)
procedure_label: BEGIN

DECLARE v_data_base VARCHAR(256);

SET v_data_base = CONCAT(i_name, '_base_', NOW());

START TRANSACTION; -- 事务1
IF EXISTS(SELECT 1 FROM tb_test_base WHERE name=i_name) THEN
    UPDATE tb_test_base SET name=i_name, data=v_data_base WHERE name=i_name;
    INSERT INTO tb_test_log(table_name,field_1,field_2)VALUES('tb_test_base',i_name,v_data_base);
    SET o_code = 0;
    SET o_mesg = 'SUCCESS';
    COMMIT; -- 事务1
ELSE
    SET o_code = 1;
    SET o_mesg = CONCAT('name=',i_name,' not exists in tb_test_base');
    ROLLBACK; -- 事务1
END IF;

END procedure_label;
//
DELIMITER ;
-- ============================================================================
DELIMITER //
DROP PROCEDURE IF EXISTS `proModifyExt`;
//
CREATE DEFINER=CURRENT_USER PROCEDURE `proModifyExt`
(
    IN  i_name VARCHAR(32),
    OUT o_code INT,
    OUT o_mesg VARCHAR(256)
)
procedure_label: BEGIN

DECLARE v_data_ext  VARCHAR(256);

SET v_data_ext  = CONCAT(i_name,'_ext__',NOW());

START TRANSACTION; -- 事务2
IF EXISTS(SELECT 1 FROM tb_test_extension WHERE name=i_name) THEN
    UPDATE tb_test_extension SET name=i_name, data=v_data_ext WHERE name=i_name;
    INSERT INTO tb_test_log(table_name,field_1,field_2)VALUES('tb_test_extension',i_name,v_data_ext);
    SET o_code = 0;
    COMMIT; -- 事务2
ELSE
    SET o_code = 1;
    SET o_mesg = CONCAT('name=',i_name,' not exists in tb_test_extension');
    ROLLBACK; -- 事务2
END IF;

END procedure_label;
//
DELIMITER ;
-- ============================================================================
-- 多个存储过程共同组成了嵌套的事务,失效
DELIMITER //
DROP PROCEDURE IF EXISTS `proModifyBatch`;
//
CREATE DEFINER=CURRENT_USER PROCEDURE `proModifyBatch`
(
    IN  i_name VARCHAR(32),
    OUT o_code INT,
    OUT o_mesg VARCHAR(256)
)
procedure_label: BEGIN

START TRANSACTION; -- 外部事务

CALL proModifyBase(i_name, o_code, o_mesg);
IF o_code <>0 THEN
    ROLLBACK; -- 外部事务
END IF;

CALL proModifyExt(i_name, o_code, o_mesg);
IF o_code <>0 THEN
    ROLLBACK; -- 外部事务
END IF;

COMMIT;

END procedure_label;
//
DELIMITER ;
-- ============================================================================
SELECT * FROM tb_test_log;
CALL proModifyTotal('b2', @o_c, @o_m);
SELECT @o_c, @o_m;
SELECT * FROM tb_test_log;
CALL proModifyBatch('b2', @o_c, @o_m);
SELECT @o_c, @o_m;
SELECT * FROM tb_test_log;
-- ============================================================================
```
