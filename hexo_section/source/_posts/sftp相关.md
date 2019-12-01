---
title: sftp相关
categories:
  - Linux
toc: false
date: 2018-10-26 11:33:38
tags:
---
摘要暂略。

<!-- more -->


`Windows`下可以使用`WinSCP`连接该服务程序。  
`Linux`下可以使用`sshpass`为`sftp`填入密码：`sshpass -p 密码 sftp -P 端口     用户名@主机:远程文件名 本地文件名`。  
`Linux`下可以使用`sshpass`为`sftp`填入密码：`sshpass -p 密码 sftp -oPort=端口 用户名@主机:远程文件名 本地文件名`。  
```
sshpass -p 密码 sftp -oPort=端口 用户@主机地址  <<-EOF
一些命令
EOF
```
比如
```
sshpass -p 密码 sftp -oPort=端口 用户@192.168.2.247  <<-EOF
get read_me.txt
EOF
```
