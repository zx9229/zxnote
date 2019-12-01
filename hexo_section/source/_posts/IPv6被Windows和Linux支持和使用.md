---
title: IPv6被Windows和Linux支持和使用
categories:
  - MyDefaultCategory
toc: false
date: 2018-11-01 15:25:01
tags:
---
摘要暂略。  
<!-- more -->

#### Windows使用Teredo
[Windows: 如何配置IPv6隧道](https://lesca.me/archives/how-to-build-ipv6-tunnel-on-windows.html)。
```bat
REM 清空隧道配置
netsh interface ipv6 set teredo disable
netsh interface ipv6 6to4 set state disable
netsh interface ipv6 isatap set state disable
REM 设置
netsh interface ipv6 set teredo enterpriseclient teredo.ipv6.microsoft.com 60 clientport=default
REM 查看状态
netsh interface ipv6 show teredo
```

#### Windows使用tunnelbroker
[Hurricane Electric Free IPv6 Tunnel Broker](https://www.tunnelbroker.net/)。  
[基于隧道使用IPv6](http://blog.sina.com.cn/s/blog_715e0d5a01016709.html)。  
适用对象：任何有独立公共IP，或在家里使用NAT的童鞋。如果在家使用NAT，需注意局域网不能有超过一台PC使用这个tunnel。你的外网IP需要允许别人ping通，否则tunnelbroker不会接受建立tunnel的请求。  
登录`www.tunnelbroker.net`->`Create Regular Tunnel`->找到`You are viewing from`的值并填入`IPv4 Endpoint (Your side)`中->选择`Available Tunnel Servers`->`Create Tunnel`->`Example Configurations`->在`Select Your OS`中选择对应的Windows版本以查看相关命令。  
假定我的`You are viewing from`是`172.82.152.3`，那么我可能得到如下信息：
```
* IPv6 Tunnel Endpoints
Server IPv4 Address:                   209.51.161.14
Server IPv6 Address:         2001:470:1f06:6b8::1/64
Client IPv4 Address:                    172.82.152.3    我的公网IPv4地址
Client IPv6 Address:         2001:470:1f06:6b8::2/64    分给我的IPv6地址
* Routed IPv6 Prefixes
Routed /64:                   2001:470:1f07:6b8::/64
Routed /48:                               Assign /48
* DNS Resolvers
Anycast IPv6 Caching Nameserver:      2001:470:20::2
Anycast IPv4 Caching Nameserver:         74.82.42.42
```
假定我的`Select Your OS`是`Windows Vista/2008/7/8`，那么我可能得到如下信息：
```bat
netsh interface teredo set state disabled
netsh interface ipv6 add v6v4tunnel interface=IP6Tunnel 172.82.152.3 209.51.161.14
netsh interface ipv6 add address IP6Tunnel 2001:470:1f06:6b8::2
netsh interface ipv6 add route ::/0 IP6Tunnel 2001:470:1f06:6b8::1
```
假定我是NAT，我的主机的内网地址是`192.168.1.101`，那么我需要将第二行命令中的`172.82.152.3`替换为`192.168.1.101`。然后执行命令即可。

#### KVM使用tunnelbroker
[给搬瓦工 KVM 版 VPS 配置 IPv6 支持（基于 Linux CentOS 7）](https://www.bandwagonhost.net/2144.html)。  
登录`www.tunnelbroker.net`->`Create Regular Tunnel`->将KVM的VPS的公网地址填入`IPv4 Endpoint (Your side)`中->选择`Available Tunnel Servers`->`Create Tunnel`->`Example Configurations`->在`Select Your OS`中选择对应的Linux版本以查看相关命令。  
假定我的KVM的VPS的公网地址是`172.82.152.3`并选择`Select Your OS`为`Linux-net-tools`，那么我可能得到如下信息：
```shell
ifconfig sit0 up
ifconfig sit0 inet6 tunnel ::209.51.161.14
ifconfig sit1 up
ifconfig sit1 inet6 add 2001:470:1f06:6b8::2/64
route -A inet6 add ::/0 dev sit1
```
直接执行命令即可。

#### OpenVZ使用tunnelbroker
[IPv6 tunnel on OpenVZ](https://www.cybermilitia.net/2013/07/22/ipv6-tunnel-on-openvz/)。  
暂略。
