---
title: Git-for-Windows-Portable相关
categories:
  - 版本控制
  - git
toc: false
date: 2019-07-18 23:37:13
tags:
---
略。
<!-- more -->

貌似，执行`git-cmd.exe`之后，可以简单的输入`git`或`gitk`以调用`git.exe`或`gitk.exe`。  
假如我们想进入`C:\my_test\`目录。可以`git-bash.exe --cd=C:\my_test\.`。  

* 为系统环境变量添加`Git_PortableGit`系统变量  
假如我们将`PortableGit-2.28.0-64-bit.7z\git-bash.exe`匹配到路径`C:\zx_folder\program_files_zx\PortableGit\PortableGit-2.28.0-64-bit.7z\git-bash.exe`，可以：
```bat
SETX /M  Git_PortableGit  "C:\zx_folder\program_files_zx\PortableGit\PortableGit-2.28.0-64-bit.7z"
```

* 为系统变量`PATH`添加路径  
```bat
REM 确保echo显示了正确的数据
ECHO %Git_PortableGit%
SETX /M  PATH  "%PATH%;%Git_PortableGit%\cmd;"
```
备注：加入PATH时，加入`%Git_PortableGit%\cmd`即可，无需加入更多路径。本信息可以从安装版的PATH中侧面证明。

* 为(目录)鼠标右键菜单添加一个"open git_bash_zx here"选项(可重复执行)
```
REG ADD    "HKEY_CLASSES_ROOT\Directory\Background\shell\git_bash_zx\command" /ve     /t REG_SZ /d "\"%Git_PortableGit%\git-bash.exe\" \"--cd=%v.\""
REG ADD    "HKEY_CLASSES_ROOT\Directory\Background\shell\git_bash_zx"         /v Icon /t REG_SZ /d "\"%Git_PortableGit%\git-bash.exe\""
REG ADD    "HKEY_CLASSES_ROOT\Directory\Background\shell\git_bash_zx"         /ve     /t REG_SZ /d "open git_bash_zx here"
REG DELETE "HKEY_CLASSES_ROOT\Directory\Background\shell\git_bash_zx"
```

* 为(目录)鼠标右键菜单添加一个"open git_cmd_zx here"选项(可重复执行)
```
REG ADD    "HKEY_CLASSES_ROOT\Directory\Background\shell\git_cmd_zx\command" /ve     /t REG_SZ /d "\"%Git_PortableGit%\git-cmd.exe\""
REG ADD    "HKEY_CLASSES_ROOT\Directory\Background\shell\git_cmd_zx"         /v Icon /t REG_SZ /d "\"%Git_PortableGit%\git-cmd.exe\""
REG ADD    "HKEY_CLASSES_ROOT\Directory\Background\shell\git_cmd_zx"         /ve     /t REG_SZ /d "open git_cmd_zx here"
REG DELETE "HKEY_CLASSES_ROOT\Directory\Background\shell\git_cmd_zx"
```

* 为(目录)鼠标右键菜单添加一个"open cmd_zx here"选项(可重复执行)
```
REG ADD    "HKEY_CLASSES_ROOT\Directory\Background\shell\cmd_zx\command" /ve     /t REG_SZ /d "cmd.exe /s /k pushd \"%V\""
REG ADD    "HKEY_CLASSES_ROOT\Directory\Background\shell\cmd_zx"         /v Icon /t REG_SZ /d "cmd.exe"
REG ADD    "HKEY_CLASSES_ROOT\Directory\Background\shell\cmd_zx"         /ve     /t REG_SZ /d "open cmd_zx here"
REG DELETE "HKEY_CLASSES_ROOT\Directory\Background\shell\cmd_zx"
```

* TortoiseGit
我们还可以顺便安装"TortoiseGit"和"TortoiseGit-LanguagePack"，方便后续使用。

* 临时记录
[Git - 初次运行 Git 前的配置](https://git-scm.com/book/zh/v2/起步-初次运行-Git-前的配置)，  
[Git - 配置 Git](https://git-scm.com/book/zh/v2/自定义-Git-配置-Git)，  
[Git - 凭证存储](https://git-scm.com/book/zh/v2/Git-工具-凭证存储)，  
System: 系统配置，所有用户的通用配置；  
Global: 全局配置，当前用户的配置；  
 Local: 本地配置，当前版本库的配置；  
```shell
# 查看所有的配置以及它们所在的文件
git config --list --show-origin

git config --global user.email "zx@zx.com"
git config --global user.name  "zx"

git config --global --get core.autocrlf
# true:  提交时把CRLF转换成LF，检出时把LF转换成CRLF。
git config --global       core.autocrlf true
# input: 提交时把CRLF转换成LF，检出时不转换。
git config --global       core.autocrlf input
# false: 关闭转换功能。
git config --global       core.autocrlf false  # 个人强烈建议用它

git config --system --get     credential.helper
git config --global --get     credential.helper
git config          --get-all credential.helper
git config --global           credential.helper manager  # 酌情操作
git config --global --unset   credential.helper
```

* git的credential相关
`cat ${HOME}/.gitconfig`或`type %USERPROFILE%\.gitconfig`。如果执行类似`git config --global credential.helper manager`的命令，则会在文件中留下数据。
