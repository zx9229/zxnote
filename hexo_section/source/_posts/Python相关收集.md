---
title: Python相关收集
categories:
  - Python
toc: false
date: 2018-07-13 14:59:25
tags:
---
摘要暂略。
<!-- more -->

[Unofficial Windows Binaries for Python Extension Packages](https://www.lfd.uci.edu/~gohlke/pythonlibs/)  

### Linux安装Python35
先用epel-release，找不到python35的话，再用ius。
用ius的步骤
```
wget --output-document=auto_install_ius.sh  https://setup.ius.io/
bash auto_install_ius.sh
yum list | grep python35
yum list | grep python35 | grep setuptools
```
