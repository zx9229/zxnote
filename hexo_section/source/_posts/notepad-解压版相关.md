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

* 建议使用32位的Notepad++  
对于Notepad++，一个流行的代码编辑器来说，你可能想要使用32位的版本，因为64位的版本可能不支持所有的插件。比如`HEX-Editor`插件。  

* 为系统环境变量添加`npp_notepad++`系统变量
假如我们将`npp.7.8.9.bin\notepad++.exe`匹配到路径`C:\zx_folder\program_files_zx\notepad++\npp.7.8.9.bin\notepad++.exe`，可以：
```bat
REM 将其加入系统环境变量
SETX /M  npp_notepad++  "C:\zx_folder\program_files_zx\notepad++\npp.7.8.9.bin"
```

* 为(文件)鼠标右键菜单添加一个"edit with notepad++"选项(可重复执行)
```bat
REM 确保系统环境变量%npp_notepad++%显示了正确的绝对路径
ECHO %npp_notepad++%
REG ADD    "HKEY_CLASSES_ROOT\*\shell\notepad++_zx\command" /ve     /t REG_SZ /d "\"%npp_notepad++%\notepad++.exe\" \"%1\""
REG ADD    "HKEY_CLASSES_ROOT\*\shell\notepad++_zx"         /v Icon /t REG_SZ /d "\"%npp_notepad++%\notepad++.exe\""
REG ADD    "HKEY_CLASSES_ROOT\*\shell\notepad++_zx"         /ve     /t REG_SZ /d "edit with notepad++"
REM 下面是移除命令
REG DELETE "HKEY_CLASSES_ROOT\*\shell\notepad++_zx"
```

* 大小写转换  
[notepadd++正则表达式大小写转换](https://www.cnblogs.com/njl041x/p/9626509.html)，  
```
猜测: U(Upper case);L(Lower case);
小写转大写：
查找【^.*$】替换【\U$0】
查找【^(.*)$】替换【\U\1】或【\U$1】
大写转小写：
查找【^.*$】替换【\L$0】
查找【^(.*)$】替换【\L\1】或【\L$1】
```
