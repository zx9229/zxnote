---
title: powershell相关的收集贴
categories:
  - Windows
  - powershell
toc: false
date: 2018-06-22 19:55:20
tags:
---
powershell相关。
<!-- more -->

一些连接：  
[PowerShell Documentation | Microsoft Docs](https://docs.microsoft.com/zh-cn/powershell/)。  
[PowerShell 脚本 | Microsoft Docs](https://docs.microsoft.com/zh-cn/powershell/scripting/powershell-scripting?view=powershell-6)。  
[PowerShell 在线教程 - PowerShell 中文博客](https://www.pstips.net/powershell-online-tutorials)。  
[PowerShell 远程执行任务的方法步骤](https://www.jb51.net/article/131532.htm)。  
[通过powershell remoting自动登录服务器并运行命令](http://www.pstips.net/auto-login-and-invoke-remoting-command.html)。  

1. 查看本机的powershell的版本号，有个直观的了解
```powershell
$PSVersionTable.PSVersion
```

2. 查看远程机器 WinRM 服务的状态
登录远程机器并执行如下命令：
```powershell
Get-Service WinRM
```

3. 查看 WinRM 的监听器
登录远程机器并执行如下命令：  
如果你需要操作远程机器，同时它没有监听端口，则需要开启WinRM服务。
```powershell
PS C:\> winrm enumerate winrm/config/Listener
Listener
    Address = *
    Transport = HTTP
    Port = 5985
    Hostname
    Enabled = true
    URLPrefix = wsman
    CertificateThumbprint
    ListeningOn = 127.0.0.1, ::1, 等
```

4. 开启远程机器的服务
登录远程机器并执行如下命令：
```powershell
# 开启 WinRM 服务
Enable-PSRemoting  –Force
# 关闭 WinRM 服务
Disable-PSRemoting –Force
```

5. 测试WinRM服务是否在本地或远程计算机上运行
```powershell
Test-WSMan -ComputerName localhost -Port 5985
```

6. 创建远程连接 Session
```powershell
Enter-PSSession -ComputerName 192.168.1.101 -Port 5985 -Credential Administrator
Enter-PSSession -ComputerName 192.168.1.101 -Port 5985 -Credential domain\myName
```

7. 如果报错
```powershell
PS D:\> Enter-PSSession -ComputerName 192.168.2.56 -Port 5985 -Credential Administrator
Enter-PSSession : 连接到远程服务器失败，错误消息如下: WinRM 客户端无法处理该请求。 可以在下列条件下将默认身份验证与 IP 地址结合使用: 传输为
 HTTPS 或目标位于 TrustedHosts 列表中，并且提供了显式凭据。 使用 winrm.cmd 配置 TrustedHosts。请注意，TrustedHosts 列表中的计算机可能未经过
身份验证。 有关如何设置 TrustedHosts 的详细信息，请运行以下命令: winrm help config。 有关详细信息，请参阅 about_Remote_Troubleshooting 帮助
主题。
所在位置 行:1 字符: 16
+ Enter-PSSession <<<<  -ComputerName 192.168.1.101 -Port 5985 -Credential Administrator
    + CategoryInfo          : InvalidArgument: (192.168.1.101:String) [Enter-PSSession], PSRemotingTransportException
    + FullyQualifiedErrorId : CreateRemoteRunspaceFailed

PS D:\>
```
可能需要为本机的TrustedHosts添加远程机器的IP地址，命令如下：
```powershell
Set-Item WSMan:\localhost\client\TrustedHosts -Value *
Set-Item WSMan:\localhost\client\TrustedHosts -Value <ComputerName>[,<ComputerName>]
```

8. 待定。
可以用`Write-Error`或`Write-Warning`在屏幕上输出提示。  
PowerShell远程管理使用5985(http)和5986(https)端口。  
判断一个变量为bool的真/假值`($var -eq $true)`和`($var -eq $false)`。  
判断一个变量为空值`($var -eq $null)`。  
`powershell`是`$?`而`cmd`是`%errorlevel%`，如果`plink.exe`的程序返回值为`0`，那么`powershell`的`$?`是`$true`。  
在`PowerShell3.0`之前，获取当前路径，之前一直通过内置的$MyInvocation变量`$CurrentyDir = Split-Path -Parent $MyInvocation.MyCommand.Definition;`，PowerShell3.0之后，直接一个$PSScriptRoot解决问题。  
