---
title: iftop相关
categories:
  - Linux
toc: false
date: 2018-11-29 15:26:29
tags:
---
略。
<!-- more -->

```
[root@localhost ~]# iftop -h
iftop: display bandwidth usage on an interface by host

Synopsis: iftop -h | [-npblNBP] [-i interface] [-f filter code]
                               [-F net/mask] [-G net6/mask6]

   -h                  display this message
   -n                  don't do hostname lookups
                    不显示机器名,显示机器的IP地址
   -N                  don't convert port numbers to services
                    不转换端口号到服务(猜: 80端口 => HTTP服务 )
   -p                  run in promiscuous mode (show traffic between other
                       hosts on the same network segment)
   -b                  don't display a bar graph of traffic
   -B                  Display bandwidth in bytes
                    用"字节"而不是"比特"显示带宽
   -i interface        listen on named interface
   -f filter code      use filter code to select packets to count
                       (default: none, but only IP packets are counted)
   -F net/mask         show traffic flows in/out of IPv4 network
                    显示指定IPv4网络的流量(例: -F 192.168.1.0/255.255.255.0 或 -F 192.168.1.0/24 )
   -G net6/mask6       show traffic flows in/out of IPv6 network
   -l                  display and count link-local IPv6 traffic (default: off)
   -P                  show ports as well as hosts
                    显示端口号和主机
   -m limit            sets the upper limit for the bandwidth scale
                    设置带宽范围的上限(例: -m 10M )
   -c config file      specifies an alternative configuration file

iftop, version 1.0pre2
copyright (c) 2002 Paul Warren <pdw@ex-parrot.com> and contributors
[root@localhost ~]#
```
例
```shell
iftop -n -N -P
iftop -nNP -F 192.168.1.0/24 -m 10M
```
安装
```shell
yum install epel-release  # 如果从默认的repo里面找不到iftop就从epel-release里面找.
yum install iftop
```
