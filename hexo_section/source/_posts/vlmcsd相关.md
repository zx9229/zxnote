---
title: vlmcsd相关
categories:
  - Windows
toc: false
date: 2019-01-25 14:40:17
tags:
---
KMS服务器模拟器。
<!-- more -->

* 几个链接  
[Releases · Wind4/vlmcsd](https://github.com/Wind4/vlmcsd/releases)。  
[vlmcs - a client for testing and/or charging KMS servers](https://github.com/Wind4/vlmcsd/blob/master/man/vlmcs.1)。  
[vlmcsd - a fully Microsoft compatible KMS server](https://github.com/Wind4/vlmcsd/blob/master/man/vlmcsd.8)。  
[vlmcsdmulti - a multi-call binary containing vlmcs(1) and vlmcsd(8)](https://github.com/Wind4/vlmcsd/blob/master/man/vlmcsdmulti.1)。  

* 几点说明  
Github上有它的版本库，版本库里面有man文件夹，它里面有文档。  
如果我们要在Windows下运行的话，可以直接运行`binaries\Windows\intel\vlmcsd-Windows-x64.exe`程序，此时它会默认监听`1688`端口。  
<label style="color:red">**`vlmcsd.exe`可执行程序运行在本机上，并且为本机激活，很可能无法成功激活。如果放到另一台机器上，应当可以成功激活。**</label>  
`vlmcsd.exe --help`可以查看程序的帮助说明。  

* 使用步骤  
`W269N-WFGWX-YVC9B-4J6C9-T83GX : Windows 10 Professional`，  
`NPPR9-FWDCX-D2C8J-H872K-2YT43 : Windows 10 Enterprise`。  
```
slmgr.vbs /skms localhost:1688
slmgr.vbs /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
slmgr.vbs /ato
```

* 其他说明  
[Vlmcsd源码（开源KMS激活服务端/客户端）](https://03k.org/vlmcsd.html)。  
并没有复杂的参数，一般来说直接执行二进制文件vlmcsd就行了，默认端口是1688 ，你可以用-p参数来指定监听端口，  
有三种版本，一个是服务端vlmcsd，客户端vlmcs，服务端+客户端muti，客户端是用来检测kms服务的，  

[打造自己的KMS服务器 | Hardie 在线博客](https://www.hardie.me/打造自己的KMS服务器/)。  
