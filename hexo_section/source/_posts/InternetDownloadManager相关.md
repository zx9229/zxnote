---
title: InternetDownloadManager相关
categories:
  - 软件相关
toc: false
date: 2018-08-25 19:33:53
tags:
---
略。

<!-- more -->

#### 利用系统防火墙阻断IDM连接自家的网站去验证序列号
源自[为了治疗不用破解补丁的强迫症们、你懂的【idm吧】_百度贴吧](http://tieba.baidu.com/p/3878377959)。  
总结：阻断idm连接自家的网站去验证序列号。  
【一定要打开Windows防火墙】我参考该教程，写了一个命令，假如
```
IDM的一个序列号是【OS5HG-K90NH-SXOGT-7JYEZ】
IMD的程序的路径是【C:\Program Files (x86)\Internet Download Manager\IDMan.exe】
IDM的IP地址列表是【50.22.78.28,169.55.0.224,169.55.0.227,169.55.40.5】
那么，命令是：
netsh advfirewall firewall add rule name="IDM_OUT_BLOCK" dir=out action=block program="C:\Program Files (x86)\Internet Download Manager\IDMan.exe" remoteip="50.22.78.28,169.55.0.224,169.55.0.227,169.55.40.5"
netsh advfirewall firewall add rule /?
```
查询指定名字的规则：`netsh advfirewall firewall show rule name="IDM_OUT_BLOCK"`。  
然后就可以注册了。如果你的机器安装了代理程序，我不知道会不会受到影响。

#### 一个可用的IDM
我从一个帖子找到了`Yanu`的一个作品并将其保留了下来。  
[恕我直言，只有yanu大神的IDM破解安装包好用](http://tieba.baidu.com/p/4942180901)。  
[Yanu - 分享优秀、纯净、绿色、实用的精品软件](www.ccav1.com)。  
[IDM 6.28 Build5 最新破解版](http://www.ccav1.com/idm.html)。  
[原始下载地址](http://www.ccav1.com/idm.html)。  
[我的下载地址](IDMan628Build5-Yanu.ex)。  
```
MD5: 9FABA635ECFF34BA5634DE41262487B6
SHA1: F6C862F417028C8E6B978CF848FF417D441C69E8
CRC32: 9007B8AC
```

#### 某些连接，我不想调用IDM下载，该怎么办？
方法1：使用快捷键暂停调用IDM下载任何链接(`下载`=>`选项`=>`常规`=>`自定义暂停调用或强制调用IDM的快捷键`)。  
方法2：`两次取消同一下载事件`，然后设置弹窗。  
方法3：`下载`=>`选项`=>`文件类型`=>`下列站点不要自动开始下载`和`下列地址不要自动开始下载`。  

#### IDM通过注册表重置到期时间
[IDM通过注册表重置到期时间](https://www.cnblogs.com/webkb/p/5249463.html)。  
[IDM解惑 正在更新ing](https://hhplow.github.io)中的`清理注册信息的文件 [opensource]IDM-trial-reset.zip`。  
[[opensource]IDM-trial-reset.zip](http://ys-k.ys168.com/549340455/VJgMjIo2J6L3I655FMN7/[opensource]IDM-trial-reset.zip)。  
[IDM通过注册表重置到期时间.reg](IDM通过注册表重置到期时间.reg)。  

#### 强杀进程
查询：`TASKLIST | FINDSTR /I idm`，  
强杀：`TASKKILL /F /IM IDMan.exe & TASKKILL /F /IM IDMMsgHost.exe`，  
备注：可以搜索"bat 批处理 复合语句连接符"然后可知"用&可以连接两条命令"，  
