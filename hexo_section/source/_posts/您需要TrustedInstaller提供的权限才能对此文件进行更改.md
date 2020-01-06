---
title: 您需要TrustedInstaller提供的权限才能对此文件进行更改
categories:
  - Windows
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2020-01-04 11:42:55
---
omit
<!--more-->

命令：
```bat
REM 修改
TAKEOWN /F C:\Windows\System32\zh-CN\termsrv.dll.mui /A
ICACLS C:\Windows\System32\zh-CN\termsrv.dll.mui /grant:r Administrators:F
REM 还原
ICACLS C:\Windows\System32\zh-CN\termsrv.dll.mui /setowner "NT SERVICE\TrustedInstaller"
ICACLS C:\Windows\System32\zh-CN\termsrv.dll.mui /grant:r Administrators:RX
```
![文件访问被拒绝](TrustedInstaller_0.png)  
![属性_原始](TrustedInstaller_1.png)  
![属性_修改_所有者](TrustedInstaller_2.png)  
![属性_修改_权限](TrustedInstaller_3.png)  
![属性_还原_修改者](TrustedInstaller_4.png)  
![属性_还原_权限](TrustedInstaller_5.png)  
