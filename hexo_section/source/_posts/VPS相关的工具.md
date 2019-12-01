---
title: VPS相关的工具
date: 2017-12-30 12:02:40
categories:
- MyDefaultCategory
tags:
toc: false
---
摘要暂略。  

<!-- more -->

#### UnixBench  

网址: `http://soft.vpser.net/test/unixbench/`  
备注: 如果不需要进行图形测试或者不在图形化界面下测试，则将Makefile文件中 GRAPHICS_TEST = defined 注释掉。  

#### bench.sh  
网址: `https://bench.sh/`  
GitHub上的地址: `https://github.com/teddysun/across/blob/master/bench.sh`  

#### Shadowsocks 一键安装脚本（四合一）

网址: `https://teddysun.com/486.html`

#### 91yun的UML一键脚本  

网址: `https://github.com/91yun/uml`  

#### 91yun的LKL一键脚本  

网址: `https://github.com/91yun/uml/blob/master/lkl/install.sh`  
我拷贝了一份91yun的副本用于学习，我的链接: `https://raw.githubusercontent.com/zx9202/zx_hotchpotch/master/lkl/install.sh`  

#### 一些链接  

该网站总结归类了一些ss的教程:  
[逗比根据地 - 世界那么逗，我想出去看看](https://doub.io/)  
[Shadowsocks指导篇（总结归类）——从无到有，境无止尽！](https://doub.io/ss-jc26/)  

shadowsocks相关:  
```
http://shadowsocks.org/en/index.html
http://shadowsocks.org/en/config/quick-guide.html
http://shadowsocks.org/en/config/advanced.html
http://shadowsocks.org/en/spec/AEAD-Ciphers.html
https://github.com/shadowsocks/shadowsocks-windows/issues/293#issuecomment-132253168
https://github.com/shadowsocks
https://github.com/shadowsocks/shadowsocks
https://github.com/shadowsocks/shadowsocks/wiki
https://github.com/shadowsocks/shadowsocks/wiki/Configuration-via-Config-File
https://github.com/shadowsocks/shadowsocks/wiki/Troubleshooting
```
UML和LKL相关:  
```
http://user-mode-linux.sourceforge.net/source.html
https://github.com/lkl/linux
https://github.com/91yun
https://github.com/91yun/uml
https://github.com/91yun/uml/blob/master/lkl/install.sh
```

[新用户选择VPS主机可用的10个性能测试工具和方法](http://www.laozuo.org/7980.html)  
[VPS性能测试:CPU内存,硬盘IO读写,带宽速度,UnixBench和压力测试](https://www.freehao123.com/vps-cpu-io-unixbench/)  
[OpenVZ下开启BBR拥塞控制](https://www.fanyueciyuan.info/jsxj/OpenVZ_BBR_UML_Alpine_Linux.html/comment-page-1)  
[OpenVZ-TCP_BBR-by-Alpine_Linux](https://github.com/fanyueciyuan/eazy-for-ss/blob/master/openvz-bbr/README.MD)  
[OpenVZ 开启 BBR 之最简方法 – Linux Kernel Library](https://home4love.com/4560.html)  
[折腾搬瓦工–02–搭建shadowsocks服务端](https://wbuntu.com/p/44)  

#### 临时备注  
shadowsocks中的OTA协议有漏洞，已经被弃用了，无需关心这个参数。  
