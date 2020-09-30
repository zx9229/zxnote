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

### 安装到了用户目录
如果是`Win10`，如果你安装`python`到`C:\Program Files\`目录下，可能因为权限不够，无法把包安装到正常的`site-packages`下，此时，程序会自动将其安装到用户目录下，如下所示：
```
C:\Users\admin> python -m pip install pyecharts
Defaulting to user installation because normal site-packages is not writeable
...(略)...
WARNING: You are using pip version 20.1.1; however, version 20.2.3 is available.
You should consider upgrading via the 'C:\Program Files\Python37\python.exe -m pip install --upgrade pip' command.
```
此时，你可以选择安装`python`到一个自定义目录(比如`C:\program_files_me\`)下，这个时候，就可以把包安装到正常目录下了。
```
C:\Users\admin> python -m pip install pyecharts
...(略)...
WARNING: You are using pip version 20.1.1; however, version 20.2.3 is available.
You should consider upgrading via the 'C:\program_files_me\Python37\python.exe -m pip install --upgrade pip' command.
```
