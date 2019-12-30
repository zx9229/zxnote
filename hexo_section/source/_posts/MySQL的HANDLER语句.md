---
title: MySQL的HANDLER语句
categories:
  - SQL
  - MySQL
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2019-12-23 19:07:35
---
omit
<!--more-->

[DECLARE ... HANDLER Statement](https://dev.mysql.com/doc/refman/8.0/en/declare-handler.html)。  
[GET DIAGNOSTICS Statement](https://dev.mysql.com/doc/refman/8.0/en/get-diagnostics.html)。  

```sql
-- 13.6.7.2 DECLARE ... HANDLER Statement
-- https://dev.mysql.com/doc/refman/8.0/en/declare-handler.html
-- 13.6.7.3 GET DIAGNOSTICS Statement
-- https://dev.mysql.com/doc/refman/8.0/en/get-diagnostics.html
DELIMITER //
DROP PROCEDURE IF EXISTS proTest;
//
CREATE DEFINER=CURRENT_USER PROCEDURE proTest
(
    OUT o_code    INT,
    OUT o_message VARCHAR(256)
)
procedure_label:BEGIN

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
    GET DIAGNOSTICS CONDITION 1
    o_code    = RETURNED_SQLSTATE,
    o_message = MESSAGE_TEXT;
    ROLLBACK; -- 不论有没有开启事务,均无脑ROLLBACK.
END;

SET o_code = 0, o_message = 'SUCCESS';

START TRANSACTION;

DROP   TEMPORARY TABLE IF EXISTS tb_test;
CREATE TEMPORARY TABLE tb_test(k INT, UNIQUE INDEX(k));

INSERT INTO tb_test(k) VALUES(1);
INSERT INTO tb_test(k) VALUES(1); -- 抛异常.
INSERT INTO tb_test(k) VALUES(2);

COMMIT;

END procedure_label;
//
DELIMITER ;
```
