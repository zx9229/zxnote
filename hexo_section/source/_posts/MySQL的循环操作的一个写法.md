---
title: MySQL的循环操作的一个写法
categories:
  - SQL
  - MySQL
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2020-01-17 16:58:12
---
omit
<!--more-->

```sql
DELIMITER $$
DROP PROCEDURE IF EXISTS `proTest`;
$$
CREATE DEFINER=CURRENT_USER PROCEDURE `proTest`
(
    OUT o_ret_code INT,
    OUT o_ret_mesg VARCHAR(32)
)
label: BEGIN

DECLARE v_done INT DEFAULT 0;
DECLARE v_id   INT;
DECLARE v_data VARCHAR(8);
DECLARE v_ctrl VARCHAR(8);

DECLARE cursor_src CURSOR FOR
    SELECT `id`, `data`, `ctrl` FROM t_src;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;

DROP TEMPORARY TABLE IF EXISTS t_src, t_dst;
CREATE TEMPORARY TABLE t_src(`id` INT NOT NULL AUTO_INCREMENT, `data` VARCHAR(8), `ctrl` VARCHAR(8), PRIMARY KEY (`id`) );
CREATE TEMPORARY TABLE t_dst(`id` INT NOT NULL AUTO_INCREMENT, `data` VARCHAR(8), `ctrl` VARCHAR(8), PRIMARY KEY (`id`) );

INSERT INTO t_src (`data`,`ctrl`) VALUES ('赵',''), ('钱','C'), ('孙',''),('李','C'),('周',''),('吴','B'),('郑',''),('王','');

START TRANSACTION;

SET o_ret_code = 0, o_ret_mesg = 'SUCCESS';

OPEN cursor_src;

loop_cycle1: LOOP
    FETCH cursor_src INTO v_id, v_data, v_ctrl;

    IF v_done <> 0 THEN
        LEAVE loop_cycle1;
    END IF;

    IF v_ctrl = 'C' THEN -- continue
        ITERATE loop_cycle1;
    END IF;
    IF v_ctrl = 'B' THEN -- break
        SET o_ret_code = 0, o_ret_mesg = CONCAT("break when data(",v_data,")");
        LEAVE   loop_cycle1;
    END IF;

    INSERT INTO t_dst(`id`,`data`,`ctrl`) SELECT v_id, v_data, v_ctrl;
END LOOP;

CLOSE cursor_src;

COMMIT;

END;
$$
DELIMITER ;
```
