---
title: Windows-Subsystem-for-Linux相关
categories:
  - Windows
toc: false
date: 2019-07-19 23:34:22
tags:
---
略。
<!-- more -->

[Linux 安装指南适用于 Windows 10 的 Windows 子系统](https://docs.microsoft.com/zh-cn/windows/wsl/install-win10)。  
[Windows Server 上安装 Linux 子系统](https://docs.microsoft.com/zh-cn/windows/wsl/install-on-server)。  
[WSL 2 | Microsoft Docs](https://docs.microsoft.com/zh-cn/windows/wsl/wsl2-index)。  
[安装 WSL 2 | Microsoft Docs](https://docs.microsoft.com/zh-cn/windows/wsl/wsl2-install)。  
[管理和配置适用于 Linux 的 Windows 子系统](https://docs.microsoft.com/zh-cn/windows/wsl/wsl-config)。  

* 临时
`wsl -l , wsl --list`：`列出了可用于 WSL 提供 Linux 分发版。 如果列出的分发，它已安装并且可供使用。`。  
`wsl --list --all`：`列出所有分布区，包括那些不是当前可用。 它们可能是正在安装，卸载，或处于中断状态。`。  
`wsl --list --running`：`列出当前正在运行的所有分布区。`。  
`终止所有 WSL 实例使用wsl --shutdown命令`。  
`wsl -s <DistributionName>， wsl --setdefault <DistributionName>`：`设置为默认分发<DistributionName>。`。  
`--distribution, -d <DistributionName>`：`运行指定的分发。`。  

* 临时2
`yum install redhat-lsb-core`然后可以`lsb_release`。  

* WSL的ubuntu启动ssh
`sudo apt install openssh-server`。  
`sudo vi /etc/ssh/sshd_config`
```
user@host:~$ diff /etc/ssh/sshd_config*
13c13
< Port 22
---
> #Port 22
56c56
< PasswordAuthentication yes
---
> PasswordAuthentication no
user@host:~$
```
`sudo service ssh start`。  
`sudo apt-get install expect`。  
