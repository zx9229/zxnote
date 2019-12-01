---
title: go-sqlite3在Windows下的使用
categories:
  - Go
toc: false
date: 2019-01-26 22:25:39
tags:
---
在Windows下使用go-sqlite3。
<!-- more -->

本文参考了[《⑨也懂系列：MinGW-w64安装教程》著名C/C++编译器GCC的Windows版本](http://rsreland.net/archives/1760)。

* 安装 go-sqlite3 遇阻
在Windows下安装`go-sqlite3`时，报错信息如下所示：
```
D:\>go get -u -v github.com/mattn/go-sqlite3
github.com/mattn/go-sqlite3 (download)
github.com/mattn/go-sqlite3
# github.com/mattn/go-sqlite3
exec: "gcc": executable file not found in %PATH%

D:\>echo %errorlevel%
2

D:\>
```
所以我要能在Windows下面运行gcc才行。然后我选择了`mingw-w64`。

* 下载 mingw-w64
进入( https://sourceforge.net/projects/mingw-w64/files/ )，你应当能找到
```
x86_64-posix-sjlj
x86_64-posix-seh
x86_64-win32-sjlj
x86_64-win32-seh
i686-posix-sjlj
i686-posix-dwarf
i686-win32-sjlj
i686-win32-dwarf
```
对于`sjlj`，你可以搜索`基于setjmp/longjmp(SJLJ)的异常处理`了解详情。
对于`seh`，你可以搜索`结构化异常处理(Structured Exception Handling, SEH)`了解详情。
我不知道应该选择什么，同时考虑到SEH是Win32操作系统提供的一个功能，我的又是x64的操作系统，所我选择了`x86_64-posix-seh`。
我选择了当时最新的版本，下载链接：[x86_64-7.3.0-release-posix-seh-rt_v5-rev0.7z](https://jaist.dl.sourceforge.net/project/mingw-w64/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/7.3.0/threads-posix/seh/x86_64-7.3.0-release-posix-seh-rt_v5-rev0.7z)。  

* 安装 mingw-w64
假设我们将其解压后，它匹配到路径`C:\x86_64-7.3.0-release-posix-seh-rt_v5-rev0\mingw64\bin\gcc.exe`。  
我个人比较建议创建一个`WINGW_BIN_PATH`的环境变量，其值为`C:\x86_64-7.3.0-release-posix-seh-rt_v5-rev0\mingw64\bin`。  
然后我们将`%WINGW_BIN_PATH%`添加到`PATH`中，这样的话，以后也方便改动。  

* 安装 go-sqlite3
然后我们再次安装go-sqlite3，如下所示：
```
D:\>go get -u -v github.com/mattn/go-sqlite3
github.com/mattn/go-sqlite3 (download)
github.com/mattn/go-sqlite3

D:\>echo %errorlevel%
0

D:\>
```
我们可以用`SQLiteStudio.exe`打开sqlite文件，查看内容。
