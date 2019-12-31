---
title: MySQL相关记录
date: 2017-10-25 19:34:24
categories:
  - SQL
  - MySQL
tags:
  - MyDefaultTag
mathjax: false
toc: false
---

MySQL的一些最基本的信息

<!-- more -->

## MySQL  

#### 查看所有用户  
```
SELECT Host,User FROM mysql.user;
```
#### 查看所有数据库  
注: 对于MySQL而言, "database数据库"和"schema模式"是同一件事.
```
SHOW DATABASES;
SHOW SCHEMAS;
```
#### 创建数据库名  
```
CREATE DATABASE 数据库名;
```
#### 切换当前数据库  
```
USE 数据库名;
```
#### 显示当前数据库的所有表名
```
SHOW TABLES;
```
#### 查看建表语句  
```
SHOW CREATE TABLE schemas_name.table_name;
```
#### 将A表的数据upsert到B表中  
```
REPLACE INTO schemas_name.table_B (SELECT * FROM schemas_name.table_A);
REPLACE INTO schemas_name.table_B (field_1,field_2,field_3) SELECT field_1,field_2,field_3 FROM schemas_name.table_A WHERE field_1=VALUE1;
```
#### 自动创建新表B,并将表A中的数据插入到表B中  
```
CREATE TABLE schemas_name.table_B AS SELECT * FROM schemas_name.table_A;
```
#### 查询EVENTS
```
SELECT * FROM mysql.event;
SELECT * FROM information_schema.events;
```
#### 开启外部访问权限
```
SELECT *          FROM mysql.user;
SELECT host, user FROM mysql.user;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '某用户的(新)密码' WITH GRANT OPTION;
```
然后你可能会看到如下警告，大意是不赞成这样做，未来会把这个操作移除：
```
1 warning(s): 1287 Using GRANT for creating new user is deprecated and will be removed in future release. Create new user with CREATE USER statement.
1 warning(s): 1287 Using GRANT statement to modify existing user's properties other than privileges is deprecated and will be removed in future release. Use ALTER USER statement for this operation.
```

#### 备份和恢复
[MySQL导出数据库、数据库表结构、存储过程及函数【用】](https://www.cnblogs.com/qlqwjy/p/8325823.html)。
```
mysqldump.exe --host=127.0.0.1 --port=3306 --user=root --password=toor --result-file=./sql.sql  --databases dbName
mysql.exe     --host=127.0.0.1 --port=3306 --user=root --password=toor             < ./sql.sql
```
①同时导出结构以及数据时可同时省略-d和-t
②同时 不 导出结构和数据可使用-ntd
③只导出存储过程和函数可使用-R -ntd
④`导出所有(结构&数据&存储过程&函数&事件&触发器)`使用-R -E(相当于①，省略了-d -t;触发器默认导出)
⑤只导出结构&函数&事件&触发器使用 -R -E -d

#### 导入和导出
导出
```
Usage: mysqldump [OPTIONS] database [tables]
OR     mysqldump [OPTIONS] --databases [OPTIONS] DB1 [DB2 DB3...]
OR     mysqldump [OPTIONS] --all-databases [OPTIONS]
  -n, --no-create-db  Suppress the CREATE DATABASE ... IF EXISTS statement that
                      normally is output for each dumped database if
                      --all-databases or --databases is given.
  -t, --no-create-info 
                      Don't write table creation info.
  -d, --no-data       No row information.
  -E, --events        Dump events.
  -R, --routines      Dump stored routines (functions and procedures).
  -N, --no-set-names  Same as --skip-set-charset.
  -r, --result-file=name 
  --triggers          Dump triggers for each dumped table.
                      (Defaults to on; use --skip-triggers to disable.)
  -F, --flush-logs    Flush logs file in server before starting dump.
  --master-data[=#]   可选值为1和2.
  --single-transaction (满足一些条件时)在mysqldump的时候不锁表.
  --replace           Use REPLACE INTO instead of INSERT INTO.(用REPLACE代替INSERT)
  --ignore-table=name Do not dump the specified table.
  
导出某数据库(db_test)的某些表(tb_user,tb_info),(默认导出结构(建表语句,触发器)和数据):
mysqldump.exe -h127.0.0.1 -P3306 -uroot -ptoor -r./sql.sql                    db_test tb_user tb_info
导出某数据库(db_test)的某些表(tb_user,tb_info),(默认导出结构(建表语句,触发器)和数据),(REPLACE):
mysqldump.exe -h127.0.0.1 -P3306 -uroot -ptoor -r./sql.sql  --replace         db_test tb_user tb_info
导出某数据库(db_test)的某些表(tb_user,tb_info),仅导出结构(建表语句,触发器):
mysqldump.exe -h127.0.0.1 -P3306 -uroot -ptoor -r./sql.sql -d      --triggers db_test tb_user tb_info
导出某数据库(db_test)的某些表(tb_user,tb_info),仅导出数据:
mysqldump.exe -h127.0.0.1 -P3306 -uroot -ptoor -r./sql.sql -t --skip-triggers db_test tb_user tb_info
导出某数据库(db_test)的所有(建表语句&触发器&数据&存储过程&函数&事件):
mysqldump.exe -h127.0.0.1 -P3306 -uroot -ptoor -r./sql.sql -E -R --databases  db_test
```
导入
```
Usage: mysql.exe [OPTIONS] [database]
  -D, --database=name Database to use.
  --default-character-set=name 
                      Set the default character set.
往某数据库(db_test)导入数据:
mysql.exe     -h127.0.0.1 -P3306 -uroot -ptoor --default-character-set=utf8  -Ddb_test < ./sql.sql
```

#### 分析命令
`Explain`。

#### processlist
`show processlist`。

#### 修改密码
```
老做法: SET PASSWORD FOR <user> = PASSWORD('<plaintext_password>')    不建议了.
新做法: SET PASSWORD FOR <user> = '<plaintext_password>'
```
比如修改root的密码为toor可以`SET PASSWORD FOR root@localhost = 'toor'`。

#### 查看MySQL的所有的表
```SQL
SELECT `table_schema`,`table_name` FROM `information_schema`.`tables`;
SELECT `TABLE_SCHEMA`,`TABLE_NAME`,`COLUMN_NAME`,`COLUMN_TYPE`,`COLUMN_KEY` FROM `INFORMATION_SCHEMA`.`Columns`;
```

#### LOAD DATA
[LOAD DATA Syntax](https://dev.mysql.com/doc/refman/5.7/en/load-data.html)。  
```SQL
LOAD DATA
    [LOW_PRIORITY | CONCURRENT] [LOCAL]
    INFILE 'file_name'
    [REPLACE | IGNORE] -- 遇到重复的时候的处理方法，替换或者是忽略.
    INTO TABLE tbl_name
    [PARTITION (partition_name [, partition_name] ...)] -- (?)分区选择.
    [CHARACTER SET charset_name] -- (?)字符集.
    [{FIELDS | COLUMNS}
        [TERMINATED BY 'string']          -- 字段之间分隔符号.
        [[OPTIONALLY] ENCLOSED BY 'char'] -- 字段被包含在char中间.
        [ESCAPED BY 'char']               -- 通过char进行转义.
    ]
    [LINES
        [STARTING BY 'string']   -- 忽略开头是string的行.
        [TERMINATED BY 'string'] -- 行分隔符.
    ]
    [IGNORE number {LINES | ROWS}] -- 忽略行.
    [(col_name_or_user_var
        [, col_name_or_user_var] ...)] -- 目的表的表字段名或者用户变量名.
    [SET col_name={expr | DEFAULT},
        [, col_name={expr | DEFAULT}] ...] -- 设置表字段值.
```
If you specify no FIELDS or LINES clause, the defaults are the same as if you had written this:
```SQL
FIELDS TERMINATED BY '\t' ENCLOSED BY '' ESCAPED BY '\\'
-- 字段被'\t'分隔, 被''环绕,
LINES  TERMINATED BY '\n' STARTING BY ''
```
例子
```SQL
LOAD DATA LOCAL INFILE 'D:/datA.csv' INTO table my_tb FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' (`col_name1`,`col_name2`);
```

#### LIKE忽略大小写和匹配大小写
```SQL
SELECT 'AbCdEfG' LIKE '%abc%'        FROM dual; -- 忽略大小写.
SELECT 'AbCdEfG' LIKE BINARY  '%abc%' FROM dual;
SELECT 'AbCdEfG' LIKE _LATIN1 '%abc%' COLLATE LATIN1_BIN;
SELECT 'AbCdEfG' LIKE _LATIN1 '%abc%' COLLATE LATIN1_GENERAL_CS;
```

* 用DELIMITER重定义MySQL的delimiter
[Defining Stored Programs](https://dev.mysql.com/doc/refman/8.0/en/stored-programs-defining.html)。  
本例还展示了循环操作(LOOP/WHILE)的一个写法。  
```SQL
DELIMITER $$
DROP PROCEDURE IF EXISTS `proTest`;
$$
CREATE PROCEDURE `proTest`(
    OUT o_ret_code INT,
    OUT o_ret_mesg VARCHAR(32)
)
label: BEGIN

DECLARE v_done INT DEFAULT 0;
DECLARE v_id   INT;
DECLARE v_name VARCHAR(32);
DECLARE v_age  INT;

DECLARE cur_req CURSOR FOR
    SELECT `id`, `name`, `age` FROM t_src;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;

DROP TABLE IF EXISTS t_src, t_dst;
CREATE TEMPORARY TABLE t_src(`id` INT NOT NULL AUTO_INCREMENT, `name` VARCHAR(32), `age` INT, PRIMARY KEY (`id`) );
CREATE TEMPORARY TABLE t_dst(`id` INT NOT NULL AUTO_INCREMENT, `name` VARCHAR(32), `age` INT, PRIMARY KEY (`id`) );

INSERT INTO t_src (`id`,`name`,`age`) VALUES (3,'zhang3',33), (4,'li4',44), (5,'wang5',55);
-- INSERT INTO t_dst (`id`,`name`,`age`) VALUES                             (5,'wang5',55);

START TRANSACTION;

SET o_ret_code = 0, o_ret_mesg = 'SUCCESS';

OPEN cur_req;

loop_cycle1: LOOP
    FETCH cur_req INTO v_id, v_name, v_age;

    IF v_done <> 0 THEN
        LEAVE loop_cycle1;
    END IF;

    IF EXISTS (SELECT 1 FROM t_dst WHERE id=v_id) THEN
        SET o_ret_code = -1, o_ret_mesg = CONCAT("id(",v_id,") is exists");
        ROLLBACK;
        LEAVE label;
    END IF;

    INSERT INTO t_dst(`id`,`name`,`age`) SELECT v_id, v_name, v_age;
END LOOP;

COMMIT;

SELECT COUNT(*) INTO o_ret_code FROM t_dst;
SET o_ret_mesg = "COUNT_VALUE";

END;
$$
DELIMITER ;
```
执行`proTest`的命令为`CALL proTest(@r1,@r2);`和`SELECT @r1, @r2;`。

* MySQL备份和恢复
能找到MySQL的`datadir`(一般为`C:\ProgramData\MySQL\MySQL Server 5.7\Data`)，能进入`services.msc`。  
备份：先停止`MySQL`的相关服务，再备份`datadir`，最后启动`MySQL`的相关服务。  
恢复：先停止`MySQL`的相关服务，再还原`datadir`，最后启动`MySQL`的相关服务。  

* MySQL日期和字符串互转
```SQL
SELECT STR_TO_DATE('2006-01-02 15:04:05.123'   ,'%Y-%m-%d %H:%i:%S.%f') FROM dual;
SELECT STR_TO_DATE('2006-01-02 15:04:05.123456','%Y-%m-%d %H:%i:%S.%f') FROM dual;
SELECT DATE_FORMAT(                       NOW(),'%Y-%m-%d %H:%i:%S.%f') FROM dual;
```

* UPDATE临时收集
```SQL
UPDATE dst d, src s 
  SET d.field_1=s.field_a,d.field_2=s.field_b 
  WHERE d.key_1=s.key_a AND d.key_2=s.key_b;
```

* MySQL`LEFT JOIN`多个表
```SQL
SELECT a.password_last_changed, a.User, b.User, c.User 
FROM      mysql.user a 
LEFT JOIN mysql.user b ON a.password_last_changed=b.password_last_changed 
LEFT JOIN mysql.user c ON a.password_last_changed=c.password_last_changed;
```

* 特殊的GROUP
```SQL
SELECT * FROM mysql.user;

SELECT User,COUNT(Host) FROM mysql.user GROUP BY User;

SELECT User,COUNT(Host) FROM(
SELECT IF(User='root','root','NULL')AS User,Host FROM mysql.user
)t GROUP BY User;

SELECT IF(User='root','root','NULL'),COUNT(Host) FROM mysql.user GROUP BY IF(User='root','root','NULL');
SELECT    User                      ,COUNT(Host) FROM mysql.user GROUP BY IF(User='root','root','NULL');

SELECT IF(User='root','root',IF(User='mysql.sys','mysql.sys','NULL')),COUNT(Host) FROM mysql.user GROUP BY IF(User='root','root',IF(User='mysql.sys','sys','NULL'));
SELECT    User                                                       ,COUNT(Host) FROM mysql.user GROUP BY IF(User='root','root',IF(User='mysql.sys','sys','NULL'));
```

* 使用JSON类型
```SQL
-- 建表
CREATE TABLE tb_config(
    `id`          BIGINT        NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `key`         VARCHAR(128)  NOT NULL UNIQUE,
    `text_value`  VARCHAR(1024)     NULL,
    `json_value`  JSON              NULL
);
-- 插入
INSERT INTO tb_config(`key`,`json_value`)VALUES
('DEFAULT_CFG','
{
    "user": "TEST",
    "friend": ["Lucy", "Lili"],
    "phone_number": {
        "13912341234": "中国移动",
        "18612341234": "中国联通"
    }
}');
-- 查询
SELECT JSON_UNQUOTE(             json_value->'$.user' ) FROM tb_config WHERE `key`='DEFAULT_CFG';
SELECT                           json_value->'$.user'   FROM tb_config WHERE `key`='DEFAULT_CFG';
SELECT              JSON_EXTRACT(json_value, '$.user')  FROM tb_config WHERE `key`='DEFAULT_CFG';
SELECT JSON_UNQUOTE(JSON_EXTRACT(json_value, '$.user')) FROM tb_config WHERE `key`='DEFAULT_CFG';
SELECT json_value->'$.phone_number."13912341234"'       FROM tb_config WHERE `key`='DEFAULT_CFG';
SELECT json_value->'$.friend[0]'                        FROM tb_config WHERE `key`='DEFAULT_CFG';
-- 查询
SELECT * FROM tb_config WHERE JSON_CONTAINS(JSON_EXTRACT('["DEFAULT_CFG","test"]','$'),CONCAT('"',`key`,'"'));
```

## MySQL Workbench  
```
执行当前行    : Ctrl+Enter
执行所有/选中 : Ctrl+Shift+Enter
```
