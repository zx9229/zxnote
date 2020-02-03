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
假如我们将`PortableGit\git-bash.exe`匹配到路径`C:\Program_Files_zx\PortableGit\git-bash.exe`，可以：
```bat
SETX /M  Git_PortableGit  "C:\Program_Files_zx\PortableGit"
REM 将其加入PATH系统环境变量
wmic ENVIRONMENT WHERE "name='PATH' AND username='<system>'" SET VariableValue="%PATH%;%Git_PortableGit%\cmd;"
```
备注：加入PATH时，加入`%Git_PortableGit%\cmd`即可，无需加入更多路径。本信息可以从安装版的PATH中侧面证明。(可能需要重启系统才能使修改生效)。

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
```
git config --global user.email "zx@zx.com"
git config --global user.name  "zx"
git config --global --get core.autocrlf
git config --global       core.autocrlf input  # 不太建议
git config --global       core.autocrlf false  # 强烈建议
git config --system --get     credential.helper
git config --global --get     credential.helper
git config          --get-all credential.helper
git config --global           credential.helper manager  # 酌情操作
git config --global --unset   credential.helper
```

* git的credential相关
`cat ${HOME}/.gitconfig`或`type %USERPROFILE%\.gitconfig`。如果执行类似`git config --global credential.helper manager`的命令，则会在文件中留下数据。
