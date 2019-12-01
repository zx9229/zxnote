---
title: Linux和USB无线网卡驱动
categories:
  - Linux
toc: false
date: 2018-11-15 00:29:06
tags:
---
临时记录。
<!-- more -->

[LinuxMint编译内核驱动无线网卡](http://www.mintos.org/hardware/compile-kernel-wireless.html)。  
[List of Wi-Fi Device IDs in Linux - WikiDevi](https://wikidevi.com/wiki/List_of_Wi-Fi_Device_IDs_in_Linux)。  
文件`/var/lib/usbutils/usb.ids`。  
[www.linux-usb.org/usb.ids](http://www.linux-usb.org/usb.ids)。  
[如何给Linux安装Realtek无线驱动？](https://trafficmgr.net/archive/2016/linux-realtek-wireless-driver/)。  
[360 / 小米 / 百度 随身wifi Ubuntu 下作为无线网卡使用](http://www.cnblogs.com/platero/p/4417458.html)。  
[Linux中显示系统中USB信息的lsusb命](https://blog.csdn.net/lxb00321/article/details/80429448)。  
[elementary os添加PPA源时提示出错](http://blog.sina.com.cn/s/blog_8b7c83790101fgls.html)。  
[wifi driver: mt7601u not work on 16.04](https://bugs.launchpad.net/ubuntu/+source/usb-modeswitch-data/+bug/1716301)。  
[driver mt7601 is unable to initialize](https://github.com/kuba-moo/mt7601u/issues/64)。  
```
apt-get install linux-headers-$(uname -r)
apt-get install linux-headers-generic
apt-get install build-essential
apt-get install linux-source
apt-get install kali-linux-all
find /usr/lib/modules/ -type l -name build
cat /etc/issue
uname -a
```

#### PPA
`PPA`是`Personal Package Archives`首字母简写。  
[Kali Linux add PPA repository add-apt-repository](https://www.blackmoreops.com/2014/02/21/kali-linux-add-ppa-repository-add-apt-repository/)。  
```
/etc/apt/sources.list
man sources.list
```
