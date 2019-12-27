---
title: python安装cx_Oracle
categories:
  - Python
toc: false
date: 2018-07-03 21:21:09
tags:
---
摘要暂略。
<!-- more -->

现在(2018-07)cx_Oracle不论在Windows还是Linux下，都可以`pip install cx_Oracle`了。  
```shell
# 安装python3
# yum install epel-release
# yum install python34
# yum install python34-devel
# yum install python34-setuptools
# easy_install-3.4 pip
pip install cx_Oracle
pip list | grep -i oracle  # 查看(cx-Oracle)(cx_Oracle)的版本号
```
然后可以使用如下代码进行测试：
```python
import cx_Oracle
host = '192.168.1.101'
port = 1521
SID = 'SID_NAME'
dsn_tns = cx_Oracle.makedsn(host, port, SID)
connection = cx_Oracle.connect('用户名', '密码', dsn_tns)
connection.close()
print("DONE.")
exit(0)
```
首先，你会看到如下错误提示：
```
cx_Oracle.DatabaseError: DPI-1047: 64-bit Oracle Client library cannot be loaded: "libclntsh.so: cannot open shared object file: No such file or directory". See https://oracle.github.io/odpi/doc/installation.html#linux for help
```
很显然需要去`https://oracle.github.io/odpi/doc/installation.html#linux`寻求帮助。  
我本着“能不yum就不yum”的个人偏好，倾向于选择`Oracle Instant Client Zip`。  
我倾向于下载`Oracle 11`的压缩包`instantclient-basic-linux.x64-11.2.0.4.0.zip`，因为
```
Version 12.2 client libraries can connect to Oracle Database 11.2 or greater. Version 12.1 client libraries can connect to Oracle Database 10.2 or greater. Version 11.2 client libraries can connect to Oracle Database 9.2 or greater.
```
所以，(解决这个错误的)全部过程就是
```shell
mkdir -p /opt/oracle_instantclient
mv  ./instantclient-basic-linux.x64-11.2.0.4.0.zip /opt/oracle_instantclient/.
unzip instantclient-basic-linux.x64-11.2.0.4.0.zip
yum install libaio libaio1
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/oracle_instantclient/instantclient_11_2
```
然后执行测试代码，会发现错误
```
cx_Oracle.DatabaseError: ORA-21561: OID generation failed
```
经搜索，原因是“`hostname`显示的主机名和`/etc/hosts`配置文件里的主机名不一致”。你可以`man hostname`和`man hosts`查看帮助文档。  
所以我们可以任改其一。我选择了修改配置文件。备份配置文件并修改后，测试代码正常运行。

最后，cx_Oracle的帮助文档在[Welcome to cx_Oracle’s documentation!](http://cx-oracle.readthedocs.io/en/latest/index.html)。
