---
title: rsync相关
categories:
  - Linux
toc: false
date: 2019-05-07 17:17:51
tags:
---
略。
<!-- more -->

### 参考链接
[11.Rsync数据同步备份](http://www.sunrisenan.com/docs/linux/linux-1an6ias469r21)。  
[rsync增量备份](https://blog.51cto.com/13272050/2094687)。  
[rsync同步服务的总结(Linux与windows双向)](https://www.jianshu.com/p/bb9f53750b3e)。  
[使用cwRsync实现windows下文件定时同步](https://www.cnblogs.com/xwdreamer/p/3361647.html)。  
[cwRsync提示password file must be owned by root when running as root的解决方法](https://www.jb51.net/article/71728.htm)。  

### 下载Windows版的程序
搜索下面的名字可以从网上找到对应的安装包。  
服务端程序：`cwRsyncServer_4.1.0_Installer.exe`，MD5：`C6381F1C0965A2E8860361AD65948D46`。  
客户端程序：`cwRsync_4.1.0_Installer.exe`，MD5：`A45FDBC757B04DCCA26AFC6F8BDD0B77`。  
[我的下载地址](cwRsyncServer_4.1.0_Installer.7z)。  

### 安装RsyncServer

#### 安装
安装`cwRsyncServer_4.1.0_Installer.exe`，无脑下一步，即可。  

#### 配置
服务程序的配置文件一般为`C:\Program Files (x86)\ICW\rsyncd.conf`，你可以如下配置：
```
use chroot = false
strict modes = false
hosts allow = *
log file = rsyncd.log
port = 60873  # 指定端口号(默认监听TCP的873端口).
uid = 0  # 不指定uid.【@ERROR: invalid uid nobody】.
gid = 0  # 不指定gid.【@ERROR: invalid gid nobody】.

# Module definitions
# Remember cygwin naming conventions : c:\work becomes /cygwin/c/work
#
[test]
path = /cygdrive/c/work
read only = false
transfer logging = yes

[moduleTEST]
# 这个模块使用的目录(/cygdrive/d/test 是 D:\test)
path = /cygdrive/d/test
read only = false
transfer logging = yes
# 认证用户名.
auth users = ping
# 认证用户的用户名和密码存储位置.
secrets file = /cygdrive/c/rsyncd.conf.secrets

# 对于(secrets file)的说明:
# This parameter specifies the name of a file that contains the username:password pairs used for authenticating this module.
# Any line starting with a hash (#) is considered a comment and is skipped.
# chmod.exe -c 600           /cygdrive/c/rsyncd.conf.secrets
# chown.exe -c administrator /cygdrive/c/rsyncd.conf.secrets
#    ls.exe -l               /cygdrive/c/rsyncd.conf.secrets
# 所以, 我们可以创建 C:\rsyncd.conf.secrets 文件, 并填入下面的内容:
# ping:pong
# root:toor
# user:resu
```
#### 配置的后续操作
从上面的配置可知，它有`test`和`moduleTEST`共2个模块。  
`test`模块的目录为`/cygdrive/c/work`即`C:\work`。  
`moduleTEST`模块的目录为`/cygdrive/d/test`即`D:\test`。  
`moduleTEST`有用户`ping`和存储用户名和密码的文件`/cygdrive/c/rsyncd.conf.secrets`即`C:\rsyncd.conf.secrets`。  
我们生成这个文件`echo ping:pong>C:\rsyncd.conf.secrets`。  

#### 启动服务
执行`services.msc`打开服务页面，手动启动服务名称为`RsyncServer`的服务。  

#### 安装客户端
安装`cwRsync_4.1.0_Installer.exe`，无脑下一步，即可。  

#### 文档
一般在`C:\Program Files (x86)\ICW\doc\rsyncd.conf.html`。  
或处于`C:\Program Files (x86)\cwRsync\doc\rsync.html`。  
你可以`rsync.exe --help | findstr /C:"rsync [OPTION]"`查看简要用法。  
下面是rsync的语法(rsync三种工作方式)：
```
Local:  rsync [OPTION...] SRC... [DEST]

Access via remote shell:
  Pull: rsync [OPTION...] [USER@]HOST:SRC... [DEST]
  Push: rsync [OPTION...] SRC... [USER@]HOST:DEST

Access via rsync daemon:
  Pull: rsync [OPTION...] [USER@]HOST::SRC... [DEST]
        rsync [OPTION...] rsync://[USER@]HOST[:PORT]/SRC... [DEST]
  Push: rsync [OPTION...] SRC... [USER@]HOST::DEST
        rsync [OPTION...] SRC... rsync://[USER@]HOST[:PORT]/DEST
```

#### rsync的一些参数
```
-a, --archive               归档模式; equals -rlptgoD (no -H,-A,-X)
-r, --recursive             递归到目录中去.
    --remove-source-files   发送者移除同步结束的文件(不移除目录).
```

#### 几个例子
假如`C:\work`和`D:\test`的内容一致，均如下所示：
```
C:\work
└─Sounds
    │  sound_1.m4a
    │  sound_2.m4a
    │
    └─CallRecord
            call_1.m4a
            call_2.m4a
```
`rsync [OPTION...] rsync://[USER@]HOST[:PORT]/SRC... [DEST]`。  
对于IP`localhost`端口`60873`模块`test`，我想拉取它下面的`Sounds`文件夹到自己的`D:\test_test`下面：  
即匹配`/cygdrive/c/work/Sounds`(`C:\work\Sounds`)到`D:\test_test\Sounds`。  
`rsync.exe -r rsync://localhost:60873/test/Sounds  /cygdrive/d/test_test/`。  
同时删除源文件：  
`rsync.exe -r rsync://localhost:60873/test/Sounds  /cygdrive/d/test_test/ --remove-source-files`。  
对于IP`localhost`端口`60873`模块`moduleTEST`用户`ping`密码`pong`，我想拉取它的数据到自己的`D:\test_test`下：
`echo pong|rsync.exe -r rsync://ping@localhost:60873/moduleTEST  /cygdrive/d/test_test/`。  
