---
title: MySQL的INFILE和OUTFILE相关
categories:
  - SQL
  - MySQL
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2019-04-30 17:19:44
tags:
---
略
<!-- more -->

猜测(TERMINATED(字段分隔符),ENCLOSED(字段包围符),ESCAPED(转义字符))的行为。  
可以字段分隔符(,)字段包围符(")转义字符(|)：
```
CREATE TABLE `tb_test` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `f1` TEXT NULL DEFAULT NULL,
    `f2` TEXT NULL DEFAULT NULL,
    `f3` TEXT NULL DEFAULT NULL,
    PRIMARY KEY (`id`)
);

SELECT * FROM `tb_test` INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/tb_test.txt'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '|'
LINES  TERMINATED BY '\r\n';

LOAD DATA  INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/tb_test.txt'
INTO TABLE `tb_test`
FIELDS TERMINATED BY ','            ENCLOSED BY '"' ESCAPED BY '|'
LINES  TERMINATED BY '\r\n';

SHOW VARIABLES LIKE '%SECURE%';
```
无字段包围符：转义字符会转义 某个字段里面的 字段分隔符和转义字符，可能还有特殊字符。  
有字段包围符：转义字符会转义 某个字段里面的 字段包围符和转义字符，可能还有特殊字符。  
要想OUTFILE和writer的行为一致，需要escapechar和quotechar一致。
