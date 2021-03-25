---
title: git相关的收集贴
categories:
  - 版本控制
  - git
toc: false
date: 2018-06-22 18:51:33
tags:
---
使用git的过程中，遇见了一些问题，然后收集到此。
<!-- more -->

### 首次使用Git时的设置
我们在首次commit时，可能会看到下面的提示：
```
*** Please tell me who you are.

Run

  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

to set your account's default identity.
Omit --global to set the identity only in this repository.

fatal: unable to auto-detect email address (got 'root@bwgkvm.(none)')
```
首次使用git时，建议如下设置：
```
git config --global user.email "zx@example.com"
git config --global user.name  "zx"
# 提交检出均不转换LF和CRLF
git config --global core.autocrlf false
# 允许提交包含混合换行符的文件
git config --global core.safecrlf false
```

### 在Windows下应当安装Git到哪个目录

Git安装包(比如`Git-2.18.0-64-bit.exe`)会默认安装到`C:\Program Files\Git`或`C:\Program Files (x86)\Git`下。  
此时路径包含了空格等特殊字符。如果用Git配合MinGW编译程序时，可能会遇到问题。  
因此建议安装Git到`C:\Program_Files_x64\Git`或`C:\Program_Files_x86\Git`下。  
总之路径不要有空格等特殊字符。下面是一个异常的例子：
```
$ make
...(略)...
C:/Program Files/Git/usr/bin/sh.exe  --tag=CXX  ...(略)...
/usr/bin/sh: line 1: C:/Program: No such file or directory
...(略)...
```

### 获取更多提示信息  

设置环境变量，获取更多提示信息：
```
# Windows
set GIT_CURL_VERBOSE=1
set GIT_TRACE_PACKET=2

# Unix
export GIT_CURL_VERBOSE=1
export GIT_TRACE_PACKET=2
```
参见[Unknown SSL protocol error in connection](https://stackoverflow.com/questions/20491027/unknown-ssl-protocol-error-in-connection)。

### GIT_DISCOVERY_ACROSS_FILESYSTEM not set
```
[test@localhost ~]$ git add -f config.json
fatal: Not a git repository (or any parent up to mount point /home)
Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).
[test@localhost ~]$
```
原因：你`git init`的目录(`.git`文件夹所在的目录)和"(要add的那个文件)所在的目录"不在同一个挂载点上。  
解决：`设置一个环境变量 GIT_DISCOVERY_ACROSS_FILESYSTEM=1 即可`。  

### 取消已经暂存的文件
[Git - 撤消操作](https://git-scm.com/book/zh/v2/Git-基础-撤消操作)。  
`git status 命令提示了你`怎么撤销操作：
```
[test@localhost ~]$ git add .
[test@localhost ~]$ git status
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
#
#	new file:   config.json
#	new file:   temp.log
#
[test@localhost ~]$ git rm --cached temp.log
rm 'temp.log'
[test@localhost ~]$ git status
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
#
#	new file:   config.json
#
[test@localhost ~]$
```

### git查看有哪些作者提交了信息
`git log | grep Author | sort | uniq`  

### git查看指定作者提交的信息  
`git log --author=作者1 --author='作者2' --author="作者3"`  
