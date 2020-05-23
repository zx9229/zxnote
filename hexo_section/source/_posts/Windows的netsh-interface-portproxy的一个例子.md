---
title: Windows的netsh-interface-portproxy的一个例子
categories:
  - Windows
toc: false
date: 2018-08-22 20:31:59
tags:
---
搜索`Netsh commands for interface portproxy`或`Netsh interface portproxy commands`可能找到相关文章。

<!-- more -->

[Netsh commands for Interface Portproxy](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2003/cc776297(v=ws.10))。  
[Netsh commands for interface portproxy](https://docs.microsoft.com/en-us/windows-server/networking/technologies/netsh/netsh-interface-portproxy)。  
[netsh interface portproxy的一个简单例子](https://blog.csdn.net/u013600225/article/details/52088196)。  
下面是一个简单的例子：
```golang
//显示所有 portproxy 参数，包括 v4tov4、v4tov6、v6tov4 和 v6tov6 的端口/地址对。
C:\>netsh interface portproxy show all
//因为没有配置过它，所以没有东西可以显示。
 
//添加配置: 本机监听10022端口,当有socket连接到10022端口时,本机就连接到192.168.2.254的22端口,本机的10022端口可以接受的连接地址为"*",使用的协议为tcp,当前仅支持传输控制协议 (TCP)。
C:\>netsh interface portproxy add v4tov4 listenport=10022 connectaddress=192.168.2.254 connectport=22 listenaddress=* protocol=tcp
//添加完毕。
 
//显示所有。
C:\>netsh interface portproxy show all
 
侦听 ipv4:                 连接到 ipv4:
 
地址            端口        地址            端口
--------------- ----------  --------------- ----------
*               10022       192.168.2.254   22
 
//删除配置: 本机的监听端口为10022,10022端口接受的连接地址为"*",使用的协议为tcp,当前仅支持TCP协议。
C:\>netsh interface portproxy delete v4tov4 listenport=10022 listenaddress=* protocol=tcp
//删除完毕。
 
//显示所有。
C:\>netsh interface portproxy show all
//因为所有的配置均已删除，所以没有东西可以显示。
 
//查看帮助信息。
C:\>netsh interface portproxy /?
//略。
 
//查看帮助信息。
C:\>netsh interface /?
//略。
 
//查看帮助信息。
C:\>netsh /?
//略。
```
