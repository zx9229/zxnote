---
title: 制作UML的可执行文件vmlinux
date: 2017-12-31 16:29:17
categories:
- MyDefaultCategory
tags:
toc: false
---
摘要暂略。  

<!-- more -->

本文根据`OpenVZ下开启BBR拥塞控制`翻写。参考链接：  
[Building from source](http://user-mode-linux.sourceforge.net/source.html)  
[Configuring your virtual machine](http://user-mode-linux.sourceforge.net/configure.html)  
[OpenVZ下开启BBR拥塞控制](https://www.fanyueciyuan.info/jsxj/OpenVZ_BBR_UML_Alpine_Linux.html)  
[Linux内核个性化配置](http://blog.csdn.net/haoxiangtianxia/article/details/19175849)  

### 去官网寻找某个版本的下载链接  

官网：`https://www.kernel.org/`  
比如我选择了当前(2017-12-31)最新的`stable`版本`4.14.10`。  
链接：`https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.14.10.tar.xz`  

### 下载并解压文件  

```
mkdir  ~/kernel.org.tmp/
cd     ~/kernel.org.tmp/
wget  https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.14.10.tar.xz
tar  -xf  linux-4.14.10.tar.xz
cd        linux-4.14.10
```

### 安装需要的软件和库  

```
# 对于 Ubuntu, 如果要安装 ncurses-devel, 需要输入 libncurses-dev
sudo apt-get -y install libncurses-dev
```

### 配置相关选项  

```
# 基于某些文件, 生成默认配置 (根据控制台的提示也能看出来)
make defconfig ARCH=um

# 弹出配置菜单, 进行手工配置
make menuconfig ARCH=um
```
此时，会弹出菜单，让我们进行选择。  
菜单的操作说明如下所示：  
```
示例: General setup  --->
解释: General setup 有子菜单

示例: IRQ subsystem  ----
解释: IRQ subsystem 有子菜单,同时子菜单为空

按Y: 表示要编译进内核
按N: 表示不编译进内核
按M: 表示编译位模块
按两下Esc: 返回上一级菜单

[*]: 表示选取了该项，编译后的kernel就会有该功能
[ ]: 表示未选取该项，编译后的kernel不会有该功能
<M>: 表示选取了该项，而且是编译成模块module的形式，它会在kernel被载入后被动态地加载，编译成module可以减少kernel image的空间，加快开机速度，方便以后修改
< >: 表示未选取该项，但是该功能被当做module，今后可以在开机后另外载入
```
要开启BBR相关选项，你可能需要按下图勾选：  
```
    UML-specific options  --->
    ===>  [*] Force a static link
    Device Drivers  --->
    ===>  [*] Network device support  --->
          ===>  [*]   Network core driver support
                <*>     Universal TUN/TAP device driver support
[*] Networking support  --->
    ===>  Networking options  --->
          ===>  [*] TCP/IP networking
                [*]   IP: TCP syncookie support
                [*]   TCP: advanced congestion control  --->
                      ===>  <*>   BBR TCP
                                  Default TCP congestion control (BBR)  --->
                                  ===>  (X) BBR
                [*] QoS and/or fair queueing  --->
                ===>  <*>   Quick Fair Queueing scheduler (QFQ)
                      <*>   Controlled Delay AQM (CODEL)
                      <*>   Fair Queue Controlled Delay AQM (FQ_CODEL)
                      <*>   Fair Queue
```
保存后退出菜单。配置会默认存储在`.config`文件中。  
如果你`ls -alh .config`的话，会发现它的最后修改时间是刚刚保存的时间。  

### 构建和瘦身  

```
# 编译可执行文件
make ARCH=um vmlinux

# 删除所有符号和重定位信息(为可执行文件瘦身)
strip  --strip-all  vmlinux
```
不出意外的话，这个文件是可以正常使用了。  

### 备注  

如果想知道内核配置选项的意思，可以从下面的文章里面尝试着搜索：  
[Linux-4.4-x86_64 内核配置选项简介](http://blog.csdn.net/wdsfup/article/details/52302142)  
[2.6.15.5内核配置选项(Kernel Box) 完全手册](http://linux.chinaunix.net/techdoc/beginner/2010/01/24/1155553.shtml)  

```
/usr/bin/ld: cannot find -lxxx
意思是编译过程找不到对应库文件, 其中, -lxxx 表示链接库文件 libxxx.so
比如 /usr/bin/ld: cannot find -lutil 就是找不到 libutil.so 文件, 那么我们直接搜索这个库的名字就行了
```
