---
title: RaspberryPi3B+安装KaliLinux相关
categories:
  - RaspberryPi
toc: false
date: 2018-11-10 21:18:24
tags:
---
RaspberryPi3B+ 安装 Kali Linux 的一些注意点。
<!-- more -->

#### 下载镜像
树莓派`RaspberryPi3B+`是arm架构。arm的系统镜像一般以`img`为后缀。  
选择Linux系统的时候，请不要选择arm64的系统镜像，因为arm64的软件包不好找。  
以Debian操作系统为例，基本上都是`*_armhf.deb`的软件包。安装deb包的命令：`dpkg -i <package.deb>`。  
下面是我当时使用的系统镜像：
```
     Name: Kali Linux RaspberryPi 2 and 3
  Torrent: https://images.offensive-security.com/arm-images/kali-linux-2018.4-rpi3-nexmon.img.xz.torrent
  Version: 2018.4
SHA256Sum: ae953fbbe5d161baab321f5a9cd4e1899789b4e924aee015516db5787f3a16f5
```
你还可以从以下链接下载镜像试用：
[Raspberry Pi Downloads - Software for the Raspberry Pi](https://www.raspberrypi.org/downloads/)。  
[Kali Linux ARM Images](https://www.offensive-security.com/kali-linux-arm-images/)。  
另外，`Kali Linux`还为安卓手机定制了一个`Kali NetHunter`系统：
```
Looking for our Mobile Penetration testing platform Kali NetHunter?
Kali NetHunter is an Android penetration testing platform for Nexus and OnePlus devices built on top of Kali Linux, which includes some special and unique features for compatible Android mobile devices.
```

#### 制作镜像
重置SD卡，可以用`SD Memory Card Formatter - SD Association`。可能`USBOOT_1.70`(选择“用0重置参数”，然后点击“开始”让软件工作)也行。  
烧录img的软件[Win32 Disk Imager](https://sourceforge.net/projects/win32diskimager/)。  

#### 启动系统
略。

#### 设置root用户自动登录
[树莓派3b kali liunx 自动登录](https://blog.csdn.net/xiaochou1994/article/details/81416653)。  
每次启动系统后，图形界面上都会有一个登陆窗口。现在我们设置root用户自动登录系统。  
查看桌面系统。可以`env`或`echo $DESKTOP_SESSION`或`echo $GDMSESSION`等命令找一下。如果是`lightdm-xsession`，可以用下面的方法：  
先修改`/etc/lightdm/lightdm.conf`文件。  
修改`#autologin-user=`为`autologin-user=root`。  
如下所示：
```
[Seat:*]
# ...(略)...
#autologin-user=
autologin-user=root
# ...(略)...
```
再修改`/etc/pam.d/lightdm-autologin`文件。  
注释掉`auth      required pam_succeed_if.so user != root quiet_success`以允许root登录。  
如下所示：
```
# Allow access without authentication
# auth    required pam_succeed_if.so user != root quiet_success
auth      required pam_permit.so
```
这样`reboot`之后应当可以发现root用户自动登录了。

#### 切换图形界面和字符界面
```shell
# 查看当前值
systemctl get-default
# 切换至字符界面
systemctl set-default multi-user.target
# 切换至图形界面
systemctl set-default graphical.target
# (字符界面)下启动(图形界面)
init 5
```

#### 我常用的的一些快捷键和操作
搜索快捷键：`Alt+F3`和`Alt+F2`。  
禁用vim的VISUAL模式：`:set mouse=`；可以`:help mouse`查看详细内容。  
重置网络
```shell
/etc/init.d/networking restart
service networking restart
```

#### Kali Linux 的网络
Kali Linux 默认使用 NetworkManager 而不是 wpa_supplicant 管理无线网络。  
有用户Login的时候，才有网络连接，用户Logout之后网络会断开。  
在图形界面下让root用户自动登录系统可以变相的自动接入WIFI网络。  
nmtui 是一个基于 curses 的图形化前端，控制 NetworkManager 之用。  
你可以搜索`NetworkManager 用户连接 系统连接`查看更多相关信息。  

#### nmcli的一些用法
```
nmcli device     status
nmcli connection show
nmcli connection up   <NAME>
nmcli connection down <NAME>
nmcli connection del  <NAME>
```
例子
```
root@kali:~# nmcli dev status
DEVICE  TYPE      STATE      CONNECTION 
wlan0   wifi      connected  wifi_12345  
eth0    ethernet  unmanaged  --         
lo      loopback  unmanaged  --         
root@kali:~# nmcli connection show
NAME        UUID                                  TYPE  DEVICE 
wifi_12345  ebf017b0-c25c-46be-8aaf-d26296337f3d  wifi  wlan0    
wifi_30123  7129e93e-ce02-4170-8a68-9e17d46538c6  wifi  --     
honor_test  7b04411c-910d-4f19-9685-53f5f7934735  wifi  --     
root@kali:~# nmcli connection del "wifi_30123"
Connection 'wifi_30123' (7129e93e-ce02-4170-8a68-9e17d46538c6) successfully deleted.
root@kali:~# nmcli connection show
NAME        UUID                                  TYPE  DEVICE 
wifi_12345  ebf017b0-c25c-46be-8aaf-d26296337f3d  wifi  wlan0  
honor_test  7b04411c-910d-4f19-9685-53f5f7934735  wifi  --     
root@kali:~#
```

#### 看门狗
防止树莓派死机的监控`apt-get install watchdog`。

#### screen
在用SSH连接时，我们常常会遇到连接突然断开的问题。连 接一旦断开，原米我们进行的操作也就中断了，若再使用，就得从头再来了。  
Screen来让树莓派永不失联的方法。此方法下，就算连接断开了，当我们重新连接后依旧进行原来的操作，而不需要从头再来。  
`apt-get install screen`。  
待增加`screen`的专门页。  
[树莓派3B+ 软件源更改](https://blog.csdn.net/kxwinxp/article/details/78370980)。  

#### 已经废弃同时可能有用的东西
[启用wpa_supplicant而不需要NetworkManager](http://www.linuxeye.com/Linux/2237.html)。  
文件`/etc/network/interfaces`的内容如下：
```
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp

auto wlan0
iface wlan0 inet dhcp
wpa-conf /etc/wpa_supplicant/wpa.conf
```
文件`/etc/wpa_supplicant/wpa.conf`的内容如下：
```
ap_scan=1

network={
  ssid="WIFI_name_1"
  psk="password"
  priority=2
}

network={
  ssid="WIFI_name_2"
  psk="password"
  priority=1
}
```
可以wpa_cli reconfigure可以重新加载配置文件(wpa_supplicant.conf)。  
如果出现了`Failed to start Raise network interfaces.`需要
```shell
#!/bin/sh
# to evade [Failed to start Raise network interfaces.] problem.
# run [crontab -e] and add the following sentence:
# @reboot /root/evade_net.sh

EXE_FILE="/tmp/net_patch.sh"
LOG_FILE="/tmp/net_patch.log"
cat > ${EXE_FILE} <<-EOF
cat /dev/null                       > ${LOG_FILE}
for IDX in \$(seq 4); do
  /etc/init.d/networking restart > /dev/null 2>&1
  result=\$?
  echo \$(date) result=\${result}  >> ${LOG_FILE}
  if [ \$? -eq 0 ]; then
    break
  else
    sleep 2
  fi
done
EOF
chmod +x ${EXE_FILE}
${EXE_FILE} &
```
