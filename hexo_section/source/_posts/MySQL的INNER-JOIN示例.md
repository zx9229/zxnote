---
title: MySQL的INNER-JOIN示例
categories:
  - MyDefaultCategory
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2020-04-16 18:57:06
---
omit
<!--more-->

```sql
DROP   TEMPORARY TABLE teacher;
CREATE TEMPORARY TABLE teacher(
tid   BIGINT      NOT NULL AUTO_INCREMENT PRIMARY KEY,
tname VARCHAR(32) NOT NULL,
tinfo VARCHAR(32)     NULL
);

DROP   TEMPORARY TABLE course;
CREATE TEMPORARY TABLE course(
cid   BIGINT      NOT NULL AUTO_INCREMENT PRIMARY KEY,
cname VARCHAR(32) NOT NULL,
tid   INT         NOT NULL
);

INSERT INTO teacher(tid,tname)VALUES(3,'张三'),(4,'李四'),(5,'王五'),(6,'赵六');
INSERT INTO course(cid,cname,tid)VALUES(101,'语文',3),(102,'数学',4),(103,'英语',5),(104,'物理',3),(105,'化学',4),(106,'生物',0);

SELECT t.*,c.* FROM teacher t INNER JOIN course c ON t.tid=c.tid;
SELECT t.*,c.* FROM teacher t LEFT  JOIN course c ON t.tid=c.tid;
SELECT t.*,c.* FROM teacher t RIGHT JOIN course c ON t.tid=c.tid;
```
