---
title: RaspberryPi3B+使用串口终端控制
categories:
  - RaspberryPi
toc: false
date: 2018-11-17 00:00:32
tags:
---
用UART控制树莓派。
<!-- more -->


参考链接：  
[［科普］为什么主机模式不能用笔记本做显示器？](https://tieba.baidu.com/p/5477669540)。  
[树莓派3硬件串口的使用及编程](http://etrd.org/2017/01/29/树莓派3硬件串口的使用及编程/)。  
用UART直接供电的话，可能因为电源不稳导致红灯闪烁，经观察，红灯灭的时候屏幕右上角有黄色闪电标志，红灯亮的时候黄色闪电消失。

#### 我的操作环境
`RaspberryPi3B+`安装了`kali-linux-2018.4-rpi3-nexmon.img.xz`。CP2102的USB转串口模块，4条杜邦线。  
镜像的`SHA256`为`ae953fbbe5d161baab321f5a9cd4e1899789b4e924aee015516db5787f3a16f5`。


#### 树莓派3代串口的麻烦
树莓派从大的方向来说一共出了3代，每一代的CPU外设基本相同，但内核不同，外设里面一共包含两个串口，一个称之为硬件串口（`/dev/ttyAMA0`），一个称之为mini串口（`/dev/ttyS0`）。硬件串口由硬件实现，有单独的波特率时钟源，性能高、可靠，mini串口性能低，功能也简单，并且没有波特率专用的时钟源而是由CPU内核时钟提供，因此mini串口有个致命的弱点是：波特率受到内核时钟的影响。内核若在智能调整功耗降低主频时，相应的这个mini串口的波特率便受到牵连了，虽然你可以固定内核的时钟频率，但这显然不符合低碳、节能的口号。在所有的树莓派板卡中都通过排针将一个串口引出来了，目前除了树莓派3代以外 ，引出的串口默认是CPU的那个硬件串口。而在树莓派3代中，由于板载蓝牙模块，因此这个硬件串口被默认分配给与蓝牙模块通信了，而把那个mini串口默认分配给了排针引出的GPIO Tx Rx，如果我们需要通过UART外接模块，默认情况下必须得使用性能很低的mini串口了，而且随着内核主频的变化，还会造成波特率的变化导致通信的失败，几乎很难使用。所以我们希望恢复硬件串口与GPIO Tx Rx的映射关系，使得我们能够通过GPIO使用高性能的硬件串口来连接我们的串口设备。


#### 查看串口的映射关系
```
root@kali:~# ls -l /dev/serial*
lrwxrwxrwx 1 root root 7 Jun 22 11:11 /dev/serial0 -> ttyS0
lrwxrwxrwx 1 root root 5 Jun 22 11:11 /dev/serial1 -> ttyAMA0
root@kali:~#
```
可知，serial0映射到ttyS0，ttyAMA0映射到serial1。


#### 查看文档指引
打开`/boot/overlays/README`文件，应当可以看到如下内容
```
...(略)...

Using Overlays
==============

Overlays are loaded using the "dtoverlay" directive. As an example, consider
the popular lirc-rpi module, the Linux Infrared Remote Control driver. In the
pre-DT world this would be loaded from /etc/modules, with an explicit
"modprobe lirc-rpi" command, or programmatically by lircd. With DT enabled,
this becomes a line in config.txt:

    dtoverlay=lirc-rpi

This causes the file /boot/overlays/lirc-rpi.dtbo to be loaded. By
default it will use GPIOs 17 (out) and 18 (in), but this can be modified using
DT parameters:

    dtoverlay=lirc-rpi,gpio_out_pin=17,gpio_in_pin=13

Parameters always have default values, although in some cases (e.g. "w1-gpio")
it is necessary to provided multiple overlays in order to get the desired
behaviour. See the list of overlays below for a description of the parameters
and their defaults.

...(略)...

Name:   pi3-miniuart-bt
Info:   Switch Pi3 Bluetooth function to use the mini-UART (ttyS0) and restore
        UART0/ttyAMA0 over GPIOs 14 & 15. Note that this may reduce the maximum
        usable baudrate.
        N.B. It is also necessary to edit /lib/systemd/system/hciuart.service
        and replace ttyAMA0 with ttyS0, unless you have a system with udev rules
        that create /dev/serial0 and /dev/serial1, in which case use
        /dev/serial1 instead because it will always be correct. Furthermore,
        you must also set core_freq=250 in config.txt or the miniuart will not
        work.
Load:   dtoverlay=pi3-miniuart-bt
Params: <None>

...(略)...
```
总结一下就是，要切换蓝牙功能到`mini-UART (ttyS0)`恢复`UART0/ttyAMA0`到`GPIOs 14 & 15`，需要：
1. 在`/boot/config.txt`文件中需要有一行内容为`dtoverlay=pi3-miniuart-bt`。
2. 在`/boot/config.txt`文件中需要有一行内容为`core_freq=250`。
3. 让`/lib/systemd/system/hciuart.service`加载`ttyS0`。


#### 让`/lib/systemd/system/hciuart.service`加载`ttyS0`
我们操作完1和2并重启，然后查看修改后的串口映射关系：
```
root@kali:~# ls -l /dev/serial*
lrwxrwxrwx 1 root root 7 Jun 22 11:11 /dev/serial0 -> ttyAMA0
lrwxrwxrwx 1 root root 5 Jun 22 11:11 /dev/serial1 -> ttyS0
root@kali:~#
```
可知`serial1`映射到`ttyS0`了。所以让`hciuart.service`加载`ttyS0`或`serial1`都行。  
查看`hciuart.service`的具体内容：
```
root@kali:~# cat /lib/systemd/system/hciuart.service
[Unit]
Description=Configure Bluetooth Modems connected by UART
ConditionPathIsDirectory=/proc/device-tree/soc/gpio@7e200000/bt_pins
Before=bluetooth.service
After=dev-serial1.device

[Service]
Type=forking
ExecStart=/usr/bin/btuart
Restart=on-failure

[Install]
WantedBy=multi-user.target
root@kali:~#
root@kali:~# cat /usr/bin/btuart
#!/bin/sh

HCIATTACH=/usr/bin/hciattach
SERIAL=`grep Serial /proc/cpuinfo | cut -c19-`
B1=`echo $SERIAL | cut -c3-4`
B2=`echo $SERIAL | cut -c5-6`
B3=`echo $SERIAL | cut -c7-8`
BDADDR=`printf b8:27:eb:%02x:%02x:%02x $((0x$B1 ^ 0xaa)) $((0x$B2 ^ 0xaa)) $((0x$B3 ^ 0xaa))`

if [ "$(cat /proc/device-tree/aliases/uart0)" = "$(cat /proc/device-tree/aliases/serial1)" ] ; then
	if [ "$(wc -c /proc/device-tree/soc/gpio@7e200000/uart0_pins/brcm\,pins | cut -f 1 -d ' ')" = "16" ] ; then
		$HCIATTACH /dev/serial1 bcm43xx 3000000 flow - $BDADDR
	else
		$HCIATTACH /dev/serial1 bcm43xx 921600 noflow - $BDADDR
	fi
else
	$HCIATTACH /dev/serial1 bcm43xx 460800 noflow - $BDADDR
fi
root@kali:~#
```
可知`hciuart.service`的行为就是加载`serial1`，我们无需更改，保持默认即可。


#### 操作总结

在Linux下的操作是：
1. 在`/boot/config.txt`文件中需要有一行内容为`dtoverlay=pi3-miniuart-bt`。
2. 在`/boot/config.txt`文件中需要有一行内容为`core_freq=250`。

在Windows下的操作是：
1. 在`存储卡目录:\config.txt`文件中需要有一行内容为`dtoverlay=pi3-miniuart-bt`。
2. 在`存储卡目录:\config.txt`文件中需要有一行内容为`core_freq=250`。


#### 确定引脚的位置
我们需要找到`RaspberryPi3B+`的`TXD`和`RXD`和`GND`和`+5V`共4个引脚的位置。可以参考以下链接：  
[Schematics(电路图) - Raspberry Pi Documentation](https://www.raspberrypi.org/documentation/hardware/raspberrypi/schematics/README.md)。  
[rpi_SCH_3bplus_1p0_reduced.pdf](https://www.raspberrypi.org/documentation/hardware/raspberrypi/schematics/rpi_SCH_3bplus_1p0_reduced.pdf)。  
[树莓派 40Pin 引脚对照表](http://shumeipai.nxez.com/raspberry-pi-pins-version-40)。  


#### RaspberryPi对接UART
用杜邦线连接两者。Pi的`TXD`连UART的`RXD`、Pi的`RXD`连UART的`TXD`、Pi的`GND`连UART的`GND`、Pi的`+5V`连UART的`+5V`。


#### 测试
查看`/boot/cmdline.txt`或`存储卡目录:\cmdline.txt`文件，得到串口速率(一般是115200)。  
将UART插入电脑的USB口，用putty设置正确的速率和串口号并打开它。我们就能用控制台操作树莓派了。
