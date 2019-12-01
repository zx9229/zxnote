---
title: NetworkManager切换为systemd-network
categories:
  - Linux
toc: false
date: 2018-11-11 21:27:49
tags:
---
将 Raspberry Pi 上的 Kali Linux 的 NetworkManager 切换为 systemd-network 和 wpa_supplicant
<!-- more -->


#### 参考链接
[如何在 Linux 上从 NetworkManager 切换为 systemd-network](https://www.linuxidc.com/Linux/2015-11/125430.htm)。  
[systemd-networkd with wpa_supplicant to manage wireless with roaming support](https://beaveris.me/systemd-networkd-with-roaming/)。  
[Systemd - Gentoo Wiki](https://wiki.gentoo.org/wiki/Systemd/zh-cn)。  
本文根据[如何在 Linux 上从 NetworkManager 切换为 systemd-network](https://www.linuxidc.com/Linux/2015-11/125430.htm)稍作修改。  

#### 停用 NetworkManager 启用 systemd-networkd
```
systemctl --version
systemctl disable NetworkManager
systemctl  enable systemd-networkd
systemctl   start systemd-networkd
```

#### 启用 systemd-resolved 服务
因为 systemd-networkd 需要使用 systemd-resolved 进行域名解析，所以我们要启用该服务。  
该服务还实现了一个缓存式 DNS 服务器。当启动后， systemd-resolved 就会在 /run/systemd/ 目录下的某个地方创建它自己的 resolv.conf 文件。  
未启动该服务时，由`find /run/systemd/ -type f -name "resolv.conf"`可知，该目录下应当没有此文件才对。  
启用该服务的命令如下所示：
```
systemctl enable systemd-resolved
systemctl  start systemd-resolved
```
然后我们应当会发现该目录下生成 resolv.conf 了。文件的路径一般为`/run/systemd/resolve/resolv.conf`。  
但是，把 DNS 解析信息存放在 /etc/resolv.conf 是更普遍的做法，很多应用程序也会依赖于 /etc/resolv.conf。  
因此为了兼容性，我们需要创建一个到 /etc/resolv.conf 的符号链接：
```shell
rm /etc/resolv.conf
ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
ln -s /run/systemd/resolve/resolv.conf /etc/.            # 也可以这样写.
```

#### 管理网络配置
要用 systemd-networkd 配置网络服务，你必须指定带 .network 扩展名的配置信息文本文件。这些网络配置文件保存到 /etc/systemd/network/ 并从这里加载。当有多个文件时， systemd-networkd 会按照字母顺序一个个加载并处理。  
我们看一下该路径下默认有什么东西：
```
root@kali:~# ls -l /etc/systemd/network/
total 0
lrwxrwxrwx 1 root root 9 Jul  4  2018 99-default.link -> /dev/null
root@kali:~#
```

#### 配置 DHCP 网络
下面我们来配置 DHCP 网络。对于此，先要创建下面的配置文件。文件名可以任意，但记住文件是按照字母顺序处理的。  
比如我们可以创建一个名为 50-dhcp.network 的文件。  
`vi /etc/systemd/network/50-dhcp.network`。文件内容如下所示：
```
[Match]
Name=*
[Network]
DHCP=yes
```

#### 配置 WIFI 连接
我们首先要知道有哪些无线网络接口(wireless network interface)，可以用`iwconfig`查看：
```
root@kali:~# iwconfig
wlan0     IEEE 802.11  ESSID:off/any
          Mode:Managed  Access Point: Not-Associated  Tx-Power=31 dBm
          Retry short limit:7   RTS thr:off   Fragment thr:off
          Encryption key:off
          Power Management:on

eth0      no wireless extensions.

lo        no wireless extensions.

root@kali:~#
```
由上面的结果可知，现在我们的机器只有一个名为`wlan0`的接口。  
然后我们找一下名字类似`wpa_supplicant*service`的文件，并读一下它的内容：
```
root@kali:~# find /etc /lib /run /usr /var -type f -iname "wpa_supplicant*service"
/usr/lib/systemd/system/wpa_supplicant@.service
/usr/lib/systemd/system/wpa_supplicant.service
/usr/lib/systemd/system/wpa_supplicant-wired@.service
/var/lib/systemd/deb-systemd-helper-enabled/multi-user.target.wants/wpa_supplicant.service
root@kali:~#
root@kali:~# cat /usr/lib/systemd/system/wpa_supplicant\@.service 
[Unit]
Description=WPA supplicant daemon (interface-specific version)
...(略)...

[Service]
Type=simple
ExecStart=/sbin/wpa_supplicant -c/etc/wpa_supplicant/wpa_supplicant-%I.conf -Dnl80211,wext -i%I

[Install]
Alias=multi-user.target.wants/wpa_supplicant@%i.service

root@kali:~#
```
可知，对于每个无线网络接口，需要一个类似`/etc/wpa_supplicant/wpa_supplicant-%I.conf`名字的配置文件。  
所以，我们需要配置一下`/etc/wpa_supplicant/wpa_supplicant-wlan0.conf`文件的内容：  
(字段`priority`尽量都用个位数字,我一个99一个9的时候,经常出现无法自动连接的情况)。  
```
# 没有这句话,就不能使用wpa_cli.
ctrl_interface=/var/run/wpa_supplicant
# 确保只有root用户能读取WPA的配置(待验证)
ctrl_interface_group=0

network={
  ssid="WIFI_NAME_1"
  psk="PASSWORD"
  priority=9
}

network={
  ssid="WIFI_NAME_2"
  psk="PASSWORD"
  priority=1
}
```
然后
```
systemctl  enable wpa_supplicant@wlan0
systemctl   start wpa_supplicant@wlan0
systemctl restart wpa_supplicant@wlan0  # 重启程序,重新加载配置文件,有点reboot的意思.
```

#### 重启以生效设置
命令`reboot`或`shutdown -r -t 60`(参数`-t`仅在Windows下有效)以重启机器，让设置生效。  
重启后，机器应当可以正常连接WIFI，插入网线后应当能正常获取IP地址，表明LAN和WLAN均正常运行。  

#### 手工启动某无线网络接口
如果我们临时插入了一个无线网络接口，请创建`/wpa_supplicant_manual.sh`脚本：
```shell
if [ $# -ne 1 ]; then echo "must input one interface." >&2; exit 1; fi
/sbin/wpa_supplicant -B -c/etc/wpa_supplicant/wpa_supplicant-$1.conf -Dnl80211,wext -i$1
```
然后为该接口创建对应的配置文件。  
假定该接口名为`wlan1`，那么可以`/wpa_supplicant_manual.sh wlan1`手工启动该接口。

#### wpa_passphrase 一些用法
`wpa_passphrase [ ssid ] [ passphrase ]`。
```
root@kali:~# wpa_passphrase wifiName wifiPswd
network={
	ssid="wifiName"
	#psk="wifiPswd"
	psk=6cb2d28425ad7340ceff035eb97fc7c0b34d401214003284c702c49a69b6f1ca
}
root@kali:~# wpa_passphrase wifiName wifiPswd >> /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
root@kali:~# wpa_cli -i wlan0 list_network
root@kali:~# wpa_cli -i wlan0 reconfigure
root@kali:~# wpa_cli -i wlan0 list_network
```

#### wpa_cli 的一些命令
```shell
wpa_cli          scan         # request new BSS scan
wpa_cli          scan_result  # 获取最新的scan结果
wpa_cli -i wlan0 ping         # pings wpa_supplicant
wpa_cli -i wlan0 reconfigure  # 强制wpa_supplicant重新读取它的配置文件
wpa_cli -i wlan0 scan         # request new BSS scan
wpa_cli -i wlan0 scan_result  # 获取最新的scan结果
wpa_cli -i wlan0 status       # 得到当前的WPA/EAPOL/EAP状态
wpa_cli -i wlan0    list_network    # 列出配置的网络
wpa_cli -i wlan0 disable_network 0  # 关闭指定序号的网络(数字是list_network显示的序号)
wpa_cli -i wlan0  enable_network 1  # 开启指定序号的网络(数字是list_network显示的序号)
wpa_cli -i wlan0  select_network 1  # select a network (disable others)
```
用`wpa_cli`添加/修改/删除 network
```
root@kali:~# wpa_cli -i wlan0 list_network
network id / ssid / bssid / flags
0  WIFI_A  any  [CURRENT]
1  WIFI_B  any  [DISABLED]
root@kali:~# wpa_cli -i wlan0 add_network 
2
root@kali:~# wpa_cli -i wlan0 list_network
network id / ssid / bssid / flags
0  WIFI_A  any  [CURRENT]
1  WIFI_B  any  [DISABLED]
2          any  [DISABLED]
root@kali:~# wpa_cli -i wlan0 set_network 2 ssid '"AP_TEST"'
OK
root@kali:~# wpa_cli -i wlan0 list_network
network id / ssid / bssid / flags
0  WIFI_A  any  [CURRENT]
1  WIFI_B  any  [DISABLED]
2  AP_TEST any  [DISABLED]
root@kali:~# wpa_cli -i wlan0 set_network 2 psk '"AP_password"'  # 切记,密码至少8位
OK
root@kali:~# wpa_cli -i wlan0 list_network
network id / ssid / bssid / flags
0  WIFI_A  any  [CURRENT]
1  WIFI_B  any  [DISABLED]
2  AP_TEST any  [DISABLED]
root@kali:~# wpa_cli -i wlan0 remove_network 2
OK
root@kali:~# wpa_cli -i wlan0 list_network
network id / ssid / bssid / flags
0  WIFI_A  any  [CURRENT]
1  WIFI_B  any  [DISABLED]
root@kali:~#
```

#### 其它链接
[Setting WiFi up via the command line - Raspberry Pi Documentation](https://www.raspberrypi.org/documentation/configuration/wireless/wireless-cli.md)。  

#### 其他命令
`iwlist`和`iwconfig`和`iw`。