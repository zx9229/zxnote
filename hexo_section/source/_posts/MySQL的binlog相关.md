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
  --no-defaults       Don't read default options from any option file,
                      except for login file.
```
一个语句：  
`mysqlbinlog.exe --no-defaults --verbose --database=某数据库 --result-file=某结果文件  ../data/mysql-bin.000001`
