---
title: MySQL-Installer-Archived-Versions相关
categories:
  - SQL
  - MySQL
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2019-08-31 17:34:39
---
略
<!-- more -->

[MySQL :: Download MySQL Community Server (Archived Versions)](https://downloads.mysql.com/archives/community/)。本链接极易失效。MySQL的下载链接很容易失效。  
[MySql 5.8 解压版安装步骤](https://blog.csdn.net/E_xiake/article/details/84951002)。  
[5.8 Running Multiple MySQL Instances on One Machine](https://dev.mysql.com/doc/refman/8.0/en/multiple-servers.html)。  

#### 下载
如果想下载Windows下的"MySQL Installer (Archived Versions)"，一般应选择带有`MySQL Community (GPL) Downloads`、`MySQL Community Server`、`Windows (x86, 64-bit), ZIP Archive`、`Windows (x86, 64-bit), ZIP Archive  Debug Binaries & Test Suite`等类似字眼的链接。  
[mysql-8.0.18-winx64.zip](https://dev.mysql.com/downloads/file/?id=490026)。  
[mysql-8.0.18-winx64-debug-test.zip](https://dev.mysql.com/downloads/file/?id=490027)。  

#### 安装

* 总结
解压`mysql-8.0.18-winx64.zip`并使其能匹配到`G:\mysql_archived_version\mysql-8.0.18-winx64\bin\mysql.exe`。  
创建`G:\mysql_archived_version\mysql-8.0.18-winx64\my.ini`并填入下面的内容：
```ini
[mysqld]
# set basedir to your installation path
basedir=G:/mysql_archived_version/mysql-8.0.18-winx64
# set datadir to the location of your data directory
datadir=G:/mysql_archived_version/mysql-8.0.18-winx64/data
# https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html
# https://dev.mysql.com/doc/refman/5.7/en/load-data-local.html
# loose-local-infile = 1
```
打开`cmd`并进入`BASEDIR`并执行`.\bin\mysqld.exe --initialize --console --user=mysql`并记下`root`的临时密码。  
打开`cmd`并进入`BASEDIR`并执行`.\bin\mysqld.exe --console`用于首次启动服务端进程。  
打开`cmd`并进入`BASEDIR`并执行`.\bin\mysqladmin.exe -u root shutdown -p`用于关闭服务端进程，需输入密码。  
打开`cmd`并进入`BASEDIR`并执行`.\bin\mysqld.exe`用于启动服务端进程。  
打开`cmd`并进入`BASEDIR`并执行`.\bin\mysql.exe -u root -p`用于启动客户端进程，需输入密码。  
执行SQL语句`ALTER USER 'root'@'localhost' IDENTIFIED BY 'toor';`可以修改root密码到toor。  
打开`cmd`并进入`BASEDIR`并执行`.\bin\mysqld.exe --install`用于安装服务。  
打开`cmd`并进入`BASEDIR`并执行`.\bin\mysqld.exe --remove`用于删除服务。  

0. 相关链接
[Installing MySQL on Microsoft Windows](https://dev.mysql.com/doc/refman/8.0/en/windows-installation.html)。  
[Installing MySQL on Microsoft Windows Using a noinstall ZIP Archive](https://dev.mysql.com/doc/refman/8.0/en/windows-install-archive.html)。  

1. Extracting the Install Archive
解压安装归档。  

2. Creating an Option File
创建一个配置文件。  
总结：
假定我们的目录和程序可以匹配到`G:\mysql_archived_version\mysql-8.0.18-winx64\bin\mysql.exe`，那么`BASEDIR`是`G:\mysql_archived_version\mysql-8.0.18-winx64`，创建`BASEDIR\my.ini`并写入以下内容：
```ini
[mysqld]
# set basedir to your installation path
basedir=G:/mysql_archived_version/mysql-8.0.18-winx64
# set datadir to the location of your data directory
datadir=G:/mysql_archived_version/mysql-8.0.18-winx64/data
```
更多相关知识如下所述：  
[Creating an Option File](https://dev.mysql.com/doc/refman/8.0/en/windows-create-option-file.html)。  
[Creating an Option File](https://dev.mysql.com/doc/refman/8.0/en/option-files.html)。  
安装目录或数据目录的位置与默认位置不同。  
您需要调整服务器设置，例如内存、缓存、InnoDB配置信息、等。  

|File Name                       |Purpose       |
|:------------------------------:|:------------:|
|%WINDIR%\my.ini, %WINDIR%\my.cnf|Global options|
|C:\my.ini, C:\my.cnf            |Global options|
|BASEDIR\my.ini, BASEDIR\my.cnf  |Global options|
|defaults-extra-file             |The file specified with --defaults-extra-file, if any                        |
|%APPDATA%\MySQL\\.mylogin.cnf   |Login path options (clients only)                                            |
|DATADIR\mysqld-auto.cnf         |System variables persisted with SET PERSIST or SET PERSIST_ONLY (server only)|

其中`BASEDIR`表示MySQL的基本安装目录(BASEDIR represents the MySQL base installation directory.)。  
建议仅使用`my.ini`配置文件。  

3. Selecting a MySQL Server Type
选择MySQL服务器类型。  
这里我个人选择了`mysqld`。  

4. Initializing the Data Directory
初始化数据目录。  
总结：  
进入`BASEDIR`，执行`.\bin\mysqld.exe --initialize --console --user=mysql`。  
更多详细信息：  
初始化数据目录的命令不会覆盖任何现有的mysql模式表，因此在任何情况下都可以安全运行。  
帮助命令`mysqld.exe --verbose --help`。  
[Initializing the Data Directory](https://dev.mysql.com/doc/refman/8.0/en/data-directory-initialization.html)。  
[Starting and Stopping MySQL Automatically](https://dev.mysql.com/doc/refman/8.0/en/automatic-start.html)。  
[Starting MySQL as a Windows Service](https://dev.mysql.com/doc/refman/8.0/en/windows-start-service.html)。  

5. Starting the Server for the First Time
首次启动服务器。  
启动命令`.\bin\mysqld.exe --console`。  

6. Starting MySQL from the Windows Command Line
从Windows命令行启动MySQL。  
启动`.\bin\mysqld.exe`。  
关闭`.\bin\mysqladmin.exe -u root shutdown`。  

7. Customizing the PATH for MySQL Tools
将MySQL的工具程序路径添加到PATH中。  

8. Starting MySQL as a Windows Service
将MySQL作为Windows服务启动。  
安装服务(自动启动)`.\bin\mysqld.exe --install`。  
安装服务(手动启动)`.\bin\mysqld.exe --install-manual`。  
删除服务(　　　　)`.\bin\mysqld.exe --remove`。  
查询服务`sc query state= all | findstr /I 服务名`。  
启动服务`sc  start  服务名`。  
启动服务`net start  服务名`。  
关闭服务`sc  stop   服务名`。  
关闭服务`net stop   服务名`。  
删除服务`sc  delete 服务名`。  

9. Testing The MySQL Installation
测试MySQL安装。  

#### 安装(定制版)

不(往配置文件)配置绝对路径，不修改系统环境配置，  

1. 解压
解压`mysql-8.0.18-winx64.zip`并使其能匹配到`G:\mysql_archived_version\mysql-8.0.18-winx64\bin\mysql.exe`。  

2. 版本库
①创建版本库：(cmd)`git init G:\mysql_archived_version\mysql-8.0.18-winx64\`。  
②查询所有的空文件夹：(sh)`find . -type d -empty`。  
③留痕有效的空文件夹：(sh)`find . -not -path "./.git/*" -type d -empty -exec touch {}/placeholder \;`。  
④提交版本库：(cmd)`git add * && git commit -m "initial submission"`。  
⑤建忽略文件：(cmd)`ECHO /data/>.gitignore`。(只忽略当前目录下的data目录,子目录的data不在忽略范围内)  

3. my.ini
创建`G:\mysql_archived_version\mysql-8.0.18-winx64\my.ini`并填入下面的内容：
```ini
[mysqld]
# The TCP/IP Port the MySQL Server will listen on
port=13306

# set basedir to your installation path
# basedir=.       [经测试,若不指定它的值,程序会自动取值BASEDIR]

# set datadir to the location of your data directory
# datadir=./data  [经测试,若不指定它的值,程序会自动取值BASEDIR/data]

# https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html  (搜索"local_infile")
# https://dev.mysql.com/doc/refman/8.0/en/load-data-local.html
loose-local-infile = 1

# Disabling X Plugin
# https://dev.mysql.com/doc/refman/8.0/en/x-plugin-disabling.html
mysqlx=0
```
4. 初始化数据目录
打开`cmd`并进入`BASEDIR`并执行`.\bin\mysqld.exe --initialize --console --user=mysql`并记下`root`的临时密码。  

5. 启动服务端进程
打开`cmd`并进入`BASEDIR`并执行`.\bin\mysqld.exe --console`用于首次启动服务端进程。  

6. 客户端登录+修改临时密码
打开`cmd`并进入`BASEDIR`并执行`.\bin\mysql.exe -P 端口 -u root -p`用于启动客户端进程，需输入密码。  
执行SQL语句`ALTER USER 'root'@'localhost' IDENTIFIED BY 'toor';`可以修改root密码到toor。  

7. 关闭服务端进程
打开`cmd`并进入`BASEDIR`并执行`.\bin\mysqladmin.exe -P 端口 -u root shutdown -p`用于关闭服务端进程，需输入密码。  

8. 启停服务端进程
启动：打开`cmd`并进入`BASEDIR`并执行`.\bin\mysqld.exe`。(安装服务后,就跳过执行了)  
启动：打开`cmd`并进入`BASEDIR`并执行`.\bin\mysqld.exe --console`。(安装服务后,也能正常执行)  
关闭：打开`cmd`并进入`BASEDIR`并执行`.\bin\mysqladmin.exe -P 端口 -u root shutdown -p`。  

9. 将MySQL作为Windows服务启动
安装服务(自动启动)`.\bin\mysqld.exe --install`。  
安装服务(手动启动)`.\bin\mysqld.exe --install-manual`。  
删除服务(　　　　)`.\bin\mysqld.exe --remove`。  
查询服务`sc query state= all | findstr /I 服务名`。  
启动服务`sc  start  服务名`。  
启动服务`net start  服务名`。  
关闭服务`sc  stop   服务名`。  
关闭服务`net stop   服务名`。  
删除服务`sc  delete 服务名`。  

10. 启停脚本
启动脚本`start.bat`：
```bat
@TITLE [cmd]mysqld.exe  

@SETLOCAL enabledelayedexpansion  
.\bin\mysqld.exe --console  
@IF NOT "!ERRORLEVEL!" == "0" (  
ECHO=  
ECHO -------------------------------------------  
ECHO,  
ECHO executable exit and return !ERRORLEVEL!  
ECHO;  
PAUSE  
)  
```
停止脚本`stop.bat`：
```bat
@TITLE [cmd]mysqladmin.exe  

@SET PORT=13306
@SET PSWD=

@SET /P MANUAL_PORT=please input MySQL port (default %PORT%):  
@IF /I NOT "%MANUAL_PORT%"=="" (  
    SET PORT=%MANUAL_PORT%
)  

@SETLOCAL enabledelayedexpansion  
.\bin\mysqladmin.exe -P %PORT% -u root shutdown -p %PSWD%  
@IF NOT "!ERRORLEVEL!" == "0" (  
ECHO=  
ECHO -------------------------------------------  
ECHO,  
ECHO executable exit and return !ERRORLEVEL!  
ECHO;  
PAUSE  
)  
```

#### 重置root密码

[MySQL 5.7 | How to Reset the Root Password](https://dev.mysql.com/doc/refman/5.7/en/resetting-permissions.html)。  
[MySQL 8.0 | How to Reset the Root Password](https://dev.mysql.com/doc/refman/8.0/en/resetting-permissions.html)。  

1. 关闭MySQL服务端进程(正常)

2. 为`shared-memory-base-name`选一个名字
本例为`smbn`。  

3. 启动MySQL服务端进程(特殊)
命令：`.\bin\mysqld.exe --console --skip-networking --skip-grant-tables --shared-memory --shared-memory-base-name=smbn`。  

4. 启动MySQL客户端进程(特殊)
命令：`.\bin\mysql.exe --shared-memory-base-name=smbn`。  

5. 重置root密码
刷新权限：`FLUSH PRIVILEGES;`，  
修改密码：`ALTER USER 'root'@'localhost' IDENTIFIED BY 'toor';`，  

6. 退出MySQL服务端进程(特殊)
命令：`.\bin\mysqladmin.exe --shared-memory-base-name=smbn -u root shutdown -p`。  

7. 启动MySQL服务端进程(正常)
