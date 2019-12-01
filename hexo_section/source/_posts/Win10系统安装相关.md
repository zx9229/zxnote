---
title: Win10系统安装相关
categories:
  - Windows
toc: false
date: 2019-01-28 10:25:53
tags:
---
略。
<!-- more -->

标准用户是计算机 Users 组的成员；管理员是计算机 Administrators 组的成员。  
Win10企业版也可以使用`专业版的密钥`。  
安装完毕后，先启用`Administrator`并为其设置密码。然后，不要在Administrator下安装任何软件。直接退回普通管理员用户。  
```
net user administrator /active:yes
net user administrator /active:no
```
我曾经遇见的情况：我在Administrator下安装了VSCode，然后在普通管理员下运行它之后，没有任何反应。
比如`Administrator`和`zhang`。

桌面图标设置。
文件扩展名
隐藏的项目
打开文件资源管理器时打开：此电脑。
