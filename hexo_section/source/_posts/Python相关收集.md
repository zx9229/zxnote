---
title: Python相关收集
categories:
  - Python
toc: false
date: 2018-07-13 14:59:25
tags:
---
摘要暂略。
<!-- more -->

[Unofficial Windows Binaries for Python Extension Packages](https://www.lfd.uci.edu/~gohlke/pythonlibs/)  

### Linux安装Python35
先用epel-release，找不到python35的话，再用ius。
用ius的步骤
```
wget --output-document=auto_install_ius.sh  https://setup.ius.io/
bash auto_install_ius.sh
yum list | grep python35
yum list | grep python35 | grep setuptools
```

### Python安装第三方包
安装pandas:  
`pip install pandas -i http://pypi.douban.com/simple --trusted-host pypi.douban.com`，  
安装pymssql:  
从`https://www.lfd.uci.edu/~gohlke/pythonlibs/#pymssql`下载指定版本的`whl`文件(比如`pymssql‑2.1.4‑cp38‑cp38‑win_amd64.whl`)，并安装它:  
`pip install C:\pymssql‑2.1.4‑cp38‑cp38‑win_amd64.whl`，  

### pymysql报错
`RuntimeError: cryptography is required for sha256_password or caching_sha2_password`，  
`sha256_password`和`caching_sha2_password`这两个加密算法需要用到`cryptography`，  
`pip install cryptography`，  

### pandas和sqlalchemy
pandas主要是以sqlalchemy方式与数据库建立链接，  

### sqlalchemy连接MySQL并执行LoadDataLocalInfile报错
[LOAD DATA LOCAL INFILE sqlalchemy和python到mysql db - 算法网](http://ddrv.cn/a/355066)，  
`MySQLdb._exceptions.OperationalError: (2000, 'Load data local infile forbidden')`，  
原来`sqlalchemy.create_engine("mysql://用户:密码@主机:端口/数据库?charset=utf8")`，  
变成`sqlalchemy.create_engine("mysql://用户:密码@主机:端口/数据库?charset=utf8&local_infile=1")`，  

### convert list to dict
```python
src_list = [i for i in range(9)]
dst_dict = {i: i*10 for i in src_list}
dst_dict = zip([i for i in src_list], [i*10 for i in src_list])
print(src_list, dst_dict)
```
