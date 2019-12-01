---
title: epel-release相关
date: 2018-01-20 14:09:46
categories:
- Linux
tags:
toc: false
---
Extra Packages for Enterprise Linux (EPEL) 企业版 Linux 附加软件包。  

<!-- more -->

### Fedora  
`https://zh.wikipedia.org/zh-hans/Fedora`  
Fedora基于Red Hat Linux。红帽公司赞助。  
对赞助者Red Hat公司而言，它是许多新技术的测试平台，被认为可用的技术最终会加入到Red Hat Enterprise Linux中。  

### EPEL  
`https://fedoraproject.org/wiki/EPEL/zh-cn`  
企业版 Linux 附加软件包（EPEL）；Extra Packages for Enterprise Linux (EPEL)。  
它面向的对象包括但不限于 红帽企业版 Linux (RHEL)、 CentOS、 Scientific Linux (SL)、 Oracle Linux (OL) 。  

### 安装  
CentOS 用户可以直接通过 `yum install epel-release` 安装并启用 EPEL 源。这一软件包被包括在 CentOS 的 Extras 仓库中，并且默认启用。  

### 我的备注  
我使用了 BandwagonHost 提供的 centos-7-x86_64-bbr 镜像，发现官方修改了 `/etc/yum.repos.d/epel.repo` 的参数，没有启用它。  
建议在第一次使用的时候，执行如下命令  
```
yum remove  epel-release
yum install epel-release
```
然后就可以使用它正常安装一些软件了  
```shell
yum install python34
yum install python34-devel
yum install python34-setuptools
easy_install-3.4 pip
pip  --version
pip3 --version
```
