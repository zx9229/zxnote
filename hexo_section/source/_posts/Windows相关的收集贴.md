---
title: Windows相关的收集贴
categories:
  - Windows
toc: false
date: 2018-06-25 20:19:29
tags:
---
摘要暂略。
<!-- more -->

### Windows下远程执行脚本的程序  
```
远程机器为Windows => powershell.exe(powershell脚本)
远程机器为Linux   => plink.exe     (     shell脚本)
```

### 设置Windows让程序崩溃时不弹窗就直接退出  
修改下面的注册表项，将其由0修改成1：
```
HKEY_CURRENT_USER\Software\Microsoft\Windows\Windows Error Reporting\DontShowUI
```
也可以执行如下命令查询和修改
```
REG QUERY "HKEY_CURRENT_USER\Software\Microsoft\Windows\Windows Error Reporting" /v DontShowUI
REG ADD   "HKEY_CURRENT_USER\Software\Microsoft\Windows\Windows Error Reporting" /v DontShowUI /t REG_DWORD /d 1
```

### putty修改默认字体大小
`putty`的默认设置(`Default Settings`)字体是`Courier New`，还是不错的，不过大小默认是10，太小了，我们把它改成12应该就舒服了。
```
REG QUERY "HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\Sessions\Default%20Settings" /v FontHeight
REG ADD   "HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\Sessions\Default%20Settings" /v FontHeight /t REG_DWORD /d 12
```

### openssh-portable 或 Win32-OpenSSH
[Installing SFTP/SSH Server on Windows using OpenSSH :: WinSCP](https://winscp.net/eng/docs/guide_windows_openssh_server#configuring_ssh_server)。  
[PowerShell/Win32-OpenSSH: Win32 port of OpenSSH](https://github.com/PowerShell/Win32-OpenSSH)。  
[PowerShell/openssh-portable: Portable OpenSSH](https://github.com/PowerShell/openssh-portable)。

### freeSSHd
[freeSSHd and freeFTPd - open source SSH and SFTP servers for Windows](http://www.freesshd.com/)。  
可以创建用户，让用户仅有sftp权限。非常好用。  

### 查看文件的MD5
```
certutil -hashfile -? 
certutil -hashfile 文件名 MD5
certutil -hashfile 文件名 SHA256
```

### 命令行查看程序打开的文件
它貌似不能搜索单个文件，只能显示所有文件。
```
OPENFILES /Local ON
OPENFILES /Query /FO LIST /V
```

### 限制远程桌面服务用户只能进行一个远程会话
[限制用户只能进行一个会话](https://technet.microsoft.com/zh-cn/library/cc754762.aspx)。  
[Restrict Users to a Single Session](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754762(v=ws.11))。  

### Beyond Compare 4 重置试用时间
```
REG QUERY  "HKEY_CURRENT_USER\Software\Scooter Software\Beyond Compare 4" /V CacheId
REG DELETE "HKEY_CURRENT_USER\Software\Scooter Software\Beyond Compare 4" /V CacheId
```

### 为Win10添加"在此处打开命令窗口"
在Win07下`Shift+鼠标右键`可以"在此处打开命令窗口"。  
在Win10下`Shift+鼠标右键`可以"在此处打开Powershell窗口"。  
成功执行下面的命令后，会为鼠标右键添加一个"open cmd here"选项。
```
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\cmd_zx\command" /ve /t REG_SZ /d "cmd.exe /s /k pushd \"%V\""
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\cmd_zx"         /ve /t REG_SZ /d "open cmd here"
```
成功执行下面的命令后，会为鼠标右键添加一个"open cmd here"选项。这里注册了一个"C"的快捷键。
```
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\cmd_zx\command" /ve /t REG_SZ /d "cmd.exe /s /k pushd \"%V\""
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\cmd_zx"         /ve /t REG_SZ /d "open cmd here (&C)"
```
成功执行下面的命令后，会为鼠标右键添加一个"open cmd here"选项。这里注册了一个"C"的快捷键。用"Shift+F10"看的比较清楚。
```
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\cmd_zx\command" /ve /t REG_SZ /d "cmd.exe /s /k pushd \"%V\""
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\cmd_zx"         /ve /t REG_SZ /d "open &cmd here"
```

### Windows程序崩溃生成dump文件
[windows程序崩溃生成dump文件](https://blog.csdn.net/whatday/article/details/47275711)。  

### wmic设置系统环境变量
[在cmd命令行下使用wmic永久修改Windows环境变量](https://blog.csdn.net/qidi_huang/article/details/52634293)。
```
wmic ENVIRONMENT CREATE name="PYTHON_ROOT_37",    username="<system>",     VariableValue="C:\Program_Files_zx\python-3.7.4-embed-amd64"
wmic ENVIRONMENT WHERE "name='PYTHON_ROOT_37' AND username='<system>'" SET VariableValue="C:\Program_Files_zx\python-3.7.4-embed-amd64"
wmic ENVIRONMENT WHERE "name='PYTHON_ROOT_37'" DELETE
```

### SysWOW64
[什么是SysWow64 – 老麟技术笔记](https://blogs.msdn.microsoft.com/tianlin/2011/10/26/syswow64/)。  
`C:\Windows\System32`:  
32位时，放的是32位的系统文件。  
64位时，放的是32位的系统文件。  
`C:\Windows\SysWOW64`:  
是64位Windows，用来存放32位Windows系统文件的地方。  
微软的解决方案是：Wow64，全称是32bit Windows On 64bit Windows（64位Windows上的32位Windows）。  

### 查看软件是32位还是64位
`选中exe`->`右键`->`7 Zip`->`打开压缩包`->`信息`。  

### Win10快捷键
```
快速切换任务: Alt + Tab
显示任务视图: Win + Tab
创建虚拟桌面: Win + Ctrl + D  (D可以记为Desktop)
切换虚拟桌面: Win + Ctrl + 左/右
关闭虚拟桌面: Win + Ctrl + F4
切换显示方向: Alt + Ctrl + 上/下/左/右
截取当前窗口: Alt + PrtScn     (Win10)
任意区域截图: Win + Shift + S  (Win10)
```
`将程序从一个虚拟桌面拖到另一个虚拟桌面`：先`Win`+`Tab`，然后鼠标拖动应用程序到目标虚拟桌面，即可。

### 全键盘将“选中状态”切换到托盘栏
①Win+D显示桌面，然后点击上下左右的随便的一个，让“选中状态”保持到桌面上，②(注意看着点)，一直按Tab，即可切换“选中状态”到托盘栏里，然后按上下左右选中某托盘图标。  
①Win+T(T可以记为Task或Taskbar)将选中状态切换到任务栏上，②(注意看着点)，一直按Tab，即可切换“选中状态”到托盘栏里，然后按上下左右选中某托盘图标。  
①`Win+T`(T可以记为Task或Taskbar)将选中状态切换到任务栏上，②(注意看着点)，按`Ctrl+Tab`或`Shift+Tab`到托盘栏。  

### powershell编辑时间戳
[如何使用Windows10 PowerShell编辑时间戳](http://www.ghost580.com/win10/2017-10-10/22107.html)。  
[windows用powershell修改文档/文件夹创建时间、修改时间](https://blog.csdn.net/u012223913/article/details/72123906)。  
修改单个文件/文件夹的命令
```
$(Get-Item FILENAME.EXT).CreationTime='2006-01-02 15:04:05'
$(Get-Item FILENAME.EXT).LastAccessTime='2006-01-02 15:04:05'
$(Get-Item FILENAME.EXT).LastWriteTime='2006-01-02 15:04:05'
```
递归文件夹中所有文件
```
Get-Childitem -path 'C:\test\' -Recurse | foreach-object { $_.LastWriteTime = Get-Date; $_.CreationTime = Get-Date }
```

### 4K显示器
[使用4K显示器遇到的坑](https://www.cnblogs.com/wei-feng/p/8013183.html)。  
使用4K显示器后，鼠标移动变慢，有强烈的的滞后敢/粘滞感。达到了60HZ的刷新频率后，鼠标移动才没有粘滞感，  
`win7`>`(桌面)鼠标右键`>`屏幕分辨率`>`高级设置`>`监视器`>`屏幕刷新频率`。  
`win10`>`(桌面)鼠标右键`>`显示设置`>`高级显示设置`>`显示适配器属性`>`监视器`>`屏幕刷新频率`。  

### 部分快捷键
Win + T - 任务栏(Taskbar),移动光标到任务栏  
Win + B – 移动光标到系统托盘  
Shift + F10 弹出(鼠标)右键菜单  
针对双显示器: Win + Shift + 左 – 移动当前窗口到左边的显示器上  
针对双显示器: Win + Shift + 右 – 移动当前窗口到右边的显示器上  
win10：Win+(左/右)+(上/下)屏幕4等分。  

### 鼠标
[鼠标如何选购 鼠标选购方法介绍【详解】](https://product.pconline.com.cn/itbk/diy/mouse/1802/10850292.html)。  
[你真的会用鼠标吗？鼠标使用全揭秘](http://mouse.zol.com.cn/372/3729367_all.html)。  
量一量自己用着顺手的那个鼠标的长宽高，然后可以网购一个差不多大小的。  
