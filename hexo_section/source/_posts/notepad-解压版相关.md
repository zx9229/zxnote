---
title: notepad++解压版相关
categories:
  - 软件相关
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2020-02-03 12:15:53
---
npp(notepad-plus-plus), notepad++,
<!--more-->

* 创建`npp_notepad++`系统变量
假如我们将`npp.7.8.4.bin.x64\notepad++.exe`匹配到路径`C:\program_files_zx\notepad++\npp.7.8.4.bin.x64\notepad++.exe`，可以：
```bat
REM 将其加入系统环境变量
SETX /M  npp_notepad++  "C:\program_files_zx\notepad++\npp.7.8.4.bin.x64"
```
(可能需要重启系统才能使修改生效)???

* 为(文件)鼠标右键菜单添加一个"edit with notepad++"选项(可重复执行)
```
REG ADD    "HKEY_CLASSES_ROOT\*\shell\notepad++_zx\command" /ve     /t REG_SZ /d "\"%npp_notepad++%\notepad++.exe\" \"%1\""
REG ADD    "HKEY_CLASSES_ROOT\*\shell\notepad++_zx"         /v Icon /t REG_SZ /d "\"%npp_notepad++%\notepad++.exe\""
REG ADD    "HKEY_CLASSES_ROOT\*\shell\notepad++_zx"         /ve     /t REG_SZ /d "edit with notepad++"
REG DELETE "HKEY_CLASSES_ROOT\*\shell\notepad++_zx"
```
