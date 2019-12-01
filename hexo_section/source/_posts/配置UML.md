---
title: 配置UML
date: 2017-12-31 16:35:02
categories:
- MyDefaultCategory
tags:
toc: false
---
摘要暂略。  

<!-- more -->

本文根据`OpenVZ下开启BBR拥塞控制`翻写。参考链接：  
[OpenVZ下开启BBR拥塞控制](https://www.fanyueciyuan.info/jsxj/OpenVZ_BBR_UML_Alpine_Linux.html)  
[Configuring your virtual machine](http://user-mode-linux.sourceforge.net/configure.html)  
[91yun的uml的一键脚本自述文档](https://github.com/91yun/uml)  

### 准备  

#### 创建工作目录  

```
mkdir ${HOME}/UML_BBR
cd    ${HOME}/UML_BBR

# (打包并压缩)  tar -Jcvf [目标压缩包名].tar.xz [原文件名/目录名]
# (解压并解包)  tar -Jxvf [原始压缩包名].tar.xz ([或] tar -xf 任何格式的压缩包名)
```

#### 准备vmlinux文件  

手动生成：https://github.com/zx9202/zx9202.github.io/blob/my_blog/source/_posts/制作UML的可执行文件vmlinux.md
下载链接：https://raw.githubusercontent.com/zx9202/zx_hotchpotch/master/UML/vmlinux.tar.xz

#### 准备root_fs文件  

手动生成：https://raw.githubusercontent.com/zx9202/zx_hotchpotch/master/UML/generateAlpineLinuxFile4shadowsocks.sh  
下载链接：https://raw.githubusercontent.com/zx9202/zx_hotchpotch/master/UML/alpine_file.tar.xz

### 设置路由表  

局域网的3类地址段(我总是记不住它,现备注在此)  
```
A类地址: 10.0.0.0--10.255.255.255
B类地址: 172.16.0.0--172.31.255.255 
C类地址: 192.168.0.0--192.168.255.255
```
假定我们的这个vmlinux的虚机的网络信息如下所示：  
虚机的address 192.168.255.2
虚机的netmask 255.255.255.0
虚机的gateway 192.168.255.1
虚机里的程序可能监听65500~65535之间的端口。那么需要如下设置：  
创建一个名为${IFNAME}地址为${IFNAME}的tap设备，并将端口范围为${DEST_PORT}的数据转发到${DEST_ADDR}。  
```
IFNAME="uml-tap"
IFADDR="192.168.255.1/24"
DEST_PORT="65500:65535"
DEST_ADDR="192.168.255.254"


# 猜测(未验证): 如果你的电脑是双网卡, 每个网卡都接入了网线, 都分配了IP地址, 那么应该会有两个default的路由.
# 猜测: 找到默认路由的名字 (D_I => DefaultInterface ?) (0/0 => 0.0.0.0/0 ?)
D_I=$(ip route show exact 0/0 | sort -k 7 | head -n 1 | sed -n 's/^default.* dev \([^ ]*\).*/\1/p')

# 增加一个名为${IFNAME}的模式为"tap"的设备
ip tuntap add ${IFNAME} mode tap

# 给名为${IFNAME}的设备设置一个IP地址
ip address add ${IFADDR} dev ${IFNAME}

# 启动名为${IFNAME}的设备
ip link set ${IFNAME} up

# 动态修改内核运行参数,允许数据包转发(等同于  echo 1 > /proc/sys/net/ipv4/ip_forward )
sysctl -w net.ipv4.ip_forward=1

# (表名)NAT:地址转换,用于网关路由器
# (规则链)FORWARD:处理转发数据包
# (规则链)POSTROUTING:用于源地址转换(SNAT)
# (规则链) PREROUTING:用于目标地址转换(DNAT)
# (动作)ACCEPT:接收数据包
# (动作)MASQUERADE:IP伪装(NAT),用于ADSL
# (动作)DNAT:目标地址转换
iptables --policy FORWARD ACCEPT
iptables --insert FORWARD  --in-interface ${IFNAME} --jump ACCEPT
iptables --insert FORWARD --out-interface ${IFNAME} --jump ACCEPT
iptables --table nat --append POSTROUTING --out-interface ${D_I} --jump MASQUERADE
iptables --table nat --append  PREROUTING  --in-interface ${D_I} --protocol tcp --dport ${DEST_PORT} --jump DNAT --to-destination ${DEST_ADDR}
iptables --table nat --append  PREROUTING  --in-interface ${D_I} --protocol udp --dport ${DEST_PORT} --jump DNAT --to-destination ${DEST_ADDR}


SCREEN_NAME="uml_bbr_zx"            # 为了不和其他人的程序重名, 随便起了一个名字
UML_BLOCK_DEVICE="./alpine_file"    # UML要使用的块设备
UML_CTRL_MEM_AMT="64M"              # UML控制的物理内存
# screen是一款虚拟终端软件. ( -dmS name     Start as daemon: Screen session in detached mode. )
# "mem=128M" will give the UML 128 megabytes of "physical" memory. (将给 UML 128M 的"物理"内存)

screen -dmS ${SCREEN_NAME} ./vmlinux ubda=${UML_BLOCK_DEVICE} rw eth0=tuntap,${IFNAME} mem=${UML_CTRL_MEM_AMT} con=pts con1=fd:0,fd:1
#screen -dmS uml_bbr_zx    ./vmlinux ubda=./alpine_file       rw eth0=tuntap,uml-tap   mem=64M                 con=pts con1=fd:0,fd:1
# 转换变量之后, 就变成了上面这句命令, 因为我个人可能会经常调试它, 所以专门写了一行注释, 方便我个人启动程序.
```
删除${IFNAME}设备：  
```
ip link set ${IFNAME} down
ip tuntap del ${IFNAME} mode tap
```

### screen的一些操作  

怎么用screen操作vmlinux呢？  
用screen操作vmlinux的小虚机的命令是`screen /dev/pts/X`。其中X的取值范围会在启动的时候确定。  
比如某次启动的过程中，屏幕输出如下所示，那么X的取值范围是[17, 22]。  
```
 * Caching service dependencies ... [ ok ]
Virtual console 1 assigned device '/dev/pts/17'
Virtual console 2 assigned device '/dev/pts/18'
Virtual console 3 assigned device '/dev/pts/19'
Virtual console 4 assigned device '/dev/pts/20'
Virtual console 5 assigned device '/dev/pts/21'
Virtual console 6 assigned device '/dev/pts/22'
random: crng init done
```

(在screen会话中的时候)分离会话：  
1. 按下组合键`Ctrl+a`并松开  
2. 此时screen窗口等待命令  
3. 然后按下`d`(detached,分离)并松开  
4. 此时screen会退出会话  

(在screen会话中的时候)杀死会话：  
1. 按下组合键`Ctrl+a`并松开  
2. 此时screen窗口等待命令  
3. 然后按下大写的K(即组合键`Shift+k`)并松开  
4. 此时系统提示是否要杀死会话  
5. 然后按下`y`确认杀死screen会话  
6. 此时screen会杀死会话  

查看会话：`screen -ls`  
进入会话：`screen -r [会话的PID]`  
分离会话：`Ctrl+a`->`d`  
杀死会话：`Ctrl+a`->`Shift+k`->`y`  

### 备注  

杀掉所有的vmlinux进程: `for NUM in $(pidof vmlinux); do kill -9 ${NUM}; done`  
(Alpine Linux)关机: `halt`或`poweroff`  
(Alpine Linux)重启: `reboot`  

udhcpc相关：  
```
Udhcpc is a very small DHCP client program geared towards embedded systems.
The letters are an abbreviation for Micro - DHCP - Client (µDHCPc). 
It was once packaged with a similarly small DHCP server program named udhcpd,
with the package called udhcp.
It is now maintained as part of Busybox.
```
