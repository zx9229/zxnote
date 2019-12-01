---
title: SSH端口转发
categories:
  - Linux
toc: false
date: 2018-07-19 21:05:52
tags:
---
摘要暂略。
<!-- more -->

### EPEL
[EPEL - Fedora Project Wiki](https://fedoraproject.org/wiki/EPEL)。  
EPEL是专门为RHEL、CentOS等Linux发行版提供额外rpm包的。很多os中没有或比较旧的rpm，在epel仓库中可以找到。  
安装方式：
```
yum install epel-release
```

### IUS
[IUS](https://ius.io)。  
`IUS is a community project that provides RPM packages for newer versions of select software for Enterprise Linux distributions.`。  
IUS是一个社区项目，为Enterprise Linux发行版的新版精选软件提供RPM包。  
[Getting Started - IUS](https://ius.io/GettingStarted/#install-via-automation)。  
[自动安装脚本](https://setup.ius.io/)。
所以，安装ius的步骤就是
```
wget --output-document=auto_install_ius.sh  https://setup.ius.io/
bash auto_install_ius.sh
```

### SSH端口转发
[实战 SSH 端口转发](https://www.ibm.com/developerworks/cn/linux/l-cn-sshforward/index.html)。  

#### 本地端口转发
命令格式`ssh [-L [bind_address:]port:host:hostport] [-p port] [user@]hostname`。
```
MySQLClient(Host1)         |防火|  MySQLServer(Host2:3389)
  SSHClient(Host1)[63389]  | 墙 |    SSHServer(Host2:2222)
```
机房有一台Linux，其IP地址是`Host2`，其SSHD服务的端口是2222，上面有一个MySQL服务器在监听3389端口。  
办公室有一台机器，其IP地址是`Host1`，上面有一个MySQL客户端。我们想用它登录MySQL服务器。
`ssh -L 127.0.0.1:63389:localhost:3389 -p 2222 用户名@Host2`
让`SSHClient`监听`127.0.0.1:63389`并转发数据到`SSHServer`,然后`SSHServer`转发数据到`localhost:3389`。
然后MySQL客户端连接`127.0.0.1:63389`即可。

#### 远程端口转发  
命令格式`ssh [-R [bind_address:]port:host:hostport] [-p port] [user@]hostname`。  
```
ProxyServer(Host1:1080)    |防火|          yum(Host2)
  SSHClient(Host1)         | 墙 |    SSHServer(Host2:2222)[61080]
```
机房有一台Linux，其IP地址是`Host2`，其SSHD服务的端口是2222。它被禁止访问外网，所以yum无法安装软件。  
办公室有台Linux，其IP地址是`Host1`，上面有一个Proxy服务器在监听1080端口。
`ssh -R localhost:61080:127.0.0.1:1080 -p 2222 用户名@Host2`
让`SSHServer`监听`localhost:61080`并转发数据到`SSHClient`,然后`SSHClient`转发数据到`127.0.0.1:1080`。
然后修改`/etc/yum.conf`让yum使用代理连接`localhost:61080`即可。  

#### 动态转发
命令格式`ssh [-D [bind_address:]port] [-p port] [user@]hostname`。  
值得注意的是，此时它是socks代理，不是http代理，所以wget和yum无法使用。  


#### cow
[cyfdecyf/cow: HTTP proxy written in Go.](https://github.com/cyfdecyf/cow)。
简单验证（wget的http代理设置）
```bash
export  http_proxy=http://127.0.0.1:61080
export https_proxy=https://127.0.0.1:61080
wget http://www.baidu.com/
unset http_proxy https_proxy
```
