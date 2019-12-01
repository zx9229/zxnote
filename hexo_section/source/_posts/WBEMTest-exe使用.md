---
title: WBEMTest.exe使用
categories:
  - Windows
toc: false
date: 2018-11-13 17:42:09
tags:
---
WMI相关
<!-- more -->

#### WBEMTest.exe
[WMI Browsing Tools | Microsoft Docs](https://docs.microsoft.com/en-us/previous-versions/system-center/configuration-manager-2003/cc181099(v=technet.10))。  
`WBEMTest.exe`要不然就按照`WMI Browse Engine Manager Test`进行记忆吧。  
`WBEMTest.exe`要不然还可以`WMI Browse Every Machine Test`进行记忆(浏览每个机器)。  

#### 查询
查询得到系统盘所在硬盘的ID：  
`SELECT DiskIndex FROM Win32_DiskPartition WHERE Bootable = TRUE`。  
假定我们得到的结果是`DiskIndex=0`，查询系统盘所在硬盘的硬盘序列号：  
`SELECT SerialNumber FROM Win32_DiskDrive WHERE Index = 0`。  
然后得到的结果就是硬盘序列号。  
![](WBEMTest.exe.查询.png)  
