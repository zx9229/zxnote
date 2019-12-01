---
title: Windows快捷方式、硬链接、软连接、符号链接
categories:
  - Windows
toc: false
date: 2019-01-28 16:21:12
tags:
---
略。
<!-- more -->

[Windows硬链接 软链接 符号链接 快捷方式](http://blog.nsfocus.net/shortcuthard-linkjunction-pointsymbolic-link/)。  

* 快捷方式(shortcut)
[Shortcut (Windows)](https://msdn.microsoft.com/zh-cn/library/ms644697)。  

* 硬链接(Hard Links)
[Hard Links and Junctions](https://docs.microsoft.com/zh-cn/windows/desktop/FileIO/hard-links-and-junctions)。  
只适用于文件，仅用于同一盘符(... references a single file in the same volume.)。  
例如`MKLINK /H  C:\hosts  C:\Windows\System32\drivers\etc\hosts`(`MKLINK /H 符号链接 原文件`)。  

* 软连接(junction / soft link)
[Hard Links and Junctions](https://docs.microsoft.com/zh-cn/windows/desktop/FileIO/hard-links-and-junctions)。  
只适用于目录(... the storage objects it references are separate directories,)。  
不能跨主机，可以跨盘符(and a junction can link directories located on different local volumes on the same computer)。  
例如`MKLINK /J  %USERPROFILE%\go\  D:\Go_GOPATH\`(`MKLINK /J 目录联接 原目录`)。  

* 文件链接(symbolic link)
[Symbolic Links](https://docs.microsoft.com/zh-cn/windows/desktop/FileIO/symbolic-links)。  
[Creating Symbolic Links](https://docs.microsoft.com/zh-cn/windows/desktop/FileIO/creating-symbolic-links)。  

* 速查
文件`MKLINK 　 符号链接  原文件(相对或绝对)`，  
目录`MKLINK /D 符号链接  原目录(相对或绝对)`。  
