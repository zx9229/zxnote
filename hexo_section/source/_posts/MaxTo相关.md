---
title: MaxTo相关
categories:
  - 软件相关
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2019-12-04 22:34:24
---
omit
<!--more-->

[Home - MaxTo](https://maxto.net)。  
[Release history - MaxTo](https://maxto.net/en/release)。  
[MaxTo-2.0.1.zip](https://files.maxto.net/releases/2.0.1/MaxTo-2.0.1.zip)。貌似应执行`MaxTo.Core.exe`。  
[2018MaxTo屏幕分割软件已注册版(附注册码) 免费版](http://www.smzy.com/smzy/down389114.html)。  
貌似，其注册项可能有`[HKEY_LOCAL_MACHINE\SOFTWARE\Digital Creations AS\MaxTo]`，  
其缓存目录可能有`C:\Users\zhang\AppData\Roaming\MaxTo`和`C:\Users\zhang\AppData\Local\MaxTo`。  

* ZIP installation package
[MaxTo-2.0.1.zip](https://files.maxto.net/releases/2.0.1/MaxTo-2.0.1.zip)。  
解压后，直接双击`MaxTo.Core.exe`，然后`tasklist | findstr /I MaxTo`就明白了。  

* 文档摘要
[Tutorial - MaxTo](https://maxto.net/en/documentation/tutorial)。  
[Configuration location](https://maxto.net/en/documentation/configuration/location)。  
按着Shift的同时移动窗口：预览区域。  
MaxTo的`设置`>`recipes(配方/食谱/方法)`的有一些快捷键，可以熟悉一下。  

* 向(上/下/左/右)替换窗口
有两个区域，每个区域都有一个最大化的窗口，按下快捷键，这两个窗口将会互换位置。  

* 配方
我准备以AquaSnap为主以MaxTo为辅，所以删掉了重复的快捷键，修改了冲突的快捷键，最后如下所示：  
![MaxTo_配方](MaxTo_recipes.png)  

* 过期处理
貌似仅修改`%APPDATA%\MaxTo\config.json`的`license`的`firstStart`的值就行了。  
旧：貌似执行完下面的命令就行了，注意有个配置文件在`%APPDATA%\MaxTo\config.json`，  
```bat
REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\MaxTo"
RMDIR /S /Q %USERPROFILE%\AppData\Local\MaxTo\
RMDIR /S /Q %USERPROFILE%\AppData\Roaming\MaxTo\
```
