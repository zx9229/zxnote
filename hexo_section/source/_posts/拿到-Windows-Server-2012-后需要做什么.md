---
title: 拿到 Windows Server 2012 后需要做什么
date: 2017-11-16 14:54:27
categories:
- MyDefaultCategory
tags:
toc: true
---
当我们拿到一台全新的操作系统后，我们通常要做一些基本操作。

<!-- more -->

当我们拿到一台全新的操作系统(以 Windows Server 2012 为例)后，我们需要做什么？  

## 如果是虚机，立即保存一次快照。  
原因：  
如果我们在这台机器上执行操作失败的话，可以立即回滚过来。  
比如安装Oracle失败，我们可以立即回滚，而不需要苦哈哈的人肉卸载。  

## 禁用 Windows 更新(可选)。  
原因：  
曾经，我们有一台Server开了自动更新，Server一直正常运行。某个周末，公司搬家，我们关闭了Server。搬家完毕，我们开启了Server。貌似由于积累了大量更新，Server启动了好久(一天多)才正常提供服务。类似必须断电的情况还有大厦的例行检修等。  

## 关闭 Windows 防火墙(可选)。  
原因：  
在部署环境/部署服务时，初期进行调试时，大量ping不通，telnet不通，一个安全的方法是设置入站出站规则，不过我选择简单粗暴的关闭防火墙。  

## 开启 telnet 功能。  
原因：略。  

## 开启".NET Framework"功能。  
服务器有哪些".NET Framework"功能，全部开启。  
比如"Windows Server 2012"有".NET Framework 3.5 功能"和".NET Framework 4.5 功能"，那就全部开启。  
原因：  
我在"Windows Server 2012"上安装Oracle时，因为没有安装".NET Framework 3.5 功能"，结果安装失败了。  
我认为很多服务都需要.Net框架。现在不装，以后也是要装的。早些安装的话，还可能少踩一些坑。  
