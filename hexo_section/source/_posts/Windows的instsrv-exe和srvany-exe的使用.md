---
title: Windows的instsrv.exe和srvany.exe的使用
categories:
  - Windows
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2020-01-08 16:42:29
---
"Windows Resource Kits Tools"。
<!--more-->

* 相关链接
[Run a Windows Application as a Service with srvany](https://www.iceflatline.com/2015/12/run-a-windows-application-as-a-service-with-srvany/)。  
[Windows Server 2003 Resource Kit Tools](https://www.microsoft.com/en-us/download/details.aspx?id=17657)。  

* 相关文件的MD5
`a623a99d60f8d34d9fbe089bb64368f2`：`rktools.exe`，  
`9f7acaad365af0d1a3cd9261e3208b9b`：`instsrv.exe`，  
`4635935fc972c582632bf45c26bfcb0e`：`srvany.exe`，  

* 一个示例
instsrv.exe：`C:\Windows Resource Kits\Tools\instsrv.exe`，  
srvany.exe ：`C:\Windows Resource Kits\Tools\srvany.exe`，  
服务名称：`test_service`，  
程序路径：`C:\Windows\System32\cmd.exe`，  
工作目录：`C:\Windows\`，  
启动参数：`/C ECHO 'content, %DATE% %TIME%'>test.test.txt`，  

1. 查询该服务是否已经注册
```bat
C:\>REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\test_service"
错误: 系统找不到指定的注册表项或值。
```

2. 用instsrv.exe和srvany.exe注册该服务
```bat
C:\>"C:\Windows Resource Kits\Tools\instsrv.exe" test_service "C:\Windows Resource Kits\Tools\srvany.exe"

The service was successfuly added!

Make sure that you go into the Control Panel and use
the Services applet to change the Account Name and
Password that this newly installed service will use
for its Security Context.
```

3. 为该服务配置参数
```reg
Windows Registry Editor Version 5.00
#                                                     test_service
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\test_service\Parameters]
# 程序的绝对路径
"Application"="C:\\Windows\\System32\\cmd.exe"
# 程序的启动时的工作目录
"AppDirectory"="C:\\Windows\\"
# 程序的启动参数
"AppParameters"="/C ECHO 'content, %DATE% %TIME%' > test_service.txt"
```

4. 删除该服务
```bat
C:\>"C:\Windows Resource Kits\Tools\instsrv.exe" test_service REMOVE

The service was successfully deleted!
```
