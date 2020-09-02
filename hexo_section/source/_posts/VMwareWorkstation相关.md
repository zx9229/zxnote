---
title: VMwareWorkstation相关
categories:
  - 软件相关
toc: false
date: 2019-07-27 21:21:28
tags:
---
VMware Workstation(威睿工作站)
<!-- more -->

应该下载`Desktop & End-User Computing`>`VMware Workstation Pro`>`VMware Workstation 15.5.6 Pro for Windows`，  

貌似 Windows 10 Enterprise 主机禁用 Credential Guard 或 Device Guard 之后才能打开运行在 12.5 之前版本的 Workstation 上的虚拟机电源。因此，用Win10专业版，别用Win10企业版。  

[威睿虚拟机 VMware Workstation Pro 15.1.0 中文版 + 注册机](http://www.carrotchou.blog/122.html)。  
注意  
1、从VM11开始就不再支持32位系统了，所以32位系统用户和XP系统用户请使用10.0.7版本；  
2、从VM14开始，对硬件要求进一步提高，所以低配电脑用户请使用12.5.9版本；  
3、关于VM14黑屏问题，这是 VMware tools 版本过低引起的。  
各版本序列号  
10.x：1Z0G9-67285-FZG78-ZL3Q2-234JG  
11.x：YG74R-86G1M-M8DLP-XEQNT-XAHW2  
12.x：ZC3TK-63GE6-481JY-WWW5T-Z7ATA  
14.x：AU108-FLF9P-H8EJZ-7XMQ9-XG0U8  
15.x：FC7D0-D1YDL-M8DXZ-CYPZE-P2AY6  
下载地址  
10.0.7: https://download3.vmware.com/software/wkst/file/VMware-workstation-full-10.0.7-2844087.exe  
12.5.9: https://download3.vmware.com/software/wkst/file/VMware-workstation-full-12.5.9-7535481.exe  
14.1.5: http://download3.vmware.com/software/wkst/file/VMware-workstation-full-14.1.5-10950780.exe  
15.1.0: https://download3.vmware.com/software/wkst/file/VMware-workstation-full-15.1.0-13591040.exe  

* 禁用 Device Guard 或 Credential Guard
`VMware Workstation 与 Device/Credential Guard 不兼容。在禁用 Device/Credential Guard 后，可以运行 VMware Workstation 。有关更多详细信息，请访问 https://kb.vmware.com/s/article/2146361`。  
[Manage Windows Defender Credential Guard (Windows 10) | Microsoft Docs](https://docs.microsoft.com/en-us/windows/security/identity-protection/credential-guard/credential-guard-manage)。  
我禁用 Device/Credential Guard 时，使用了`Windows Defender Device Guard and Windows Defender Credential Guard hardware readiness tool`(需要人工修改一行代码)，其相关命令为
```
DG_Readiness_Tool_v3.5.ps1 -Enable -AutoReboot
DG_Readiness_Tool_v3.5.ps1 -Ready
DG_Readiness_Tool_v3.6.ps1 -Disable -AutoReboot
```
然后发现，该工具在`Disable`后，再`Enable`，恢复到原来的状态失败。并不能无缝切换状态。  
我还需要再执行下面的命令，才能正常使用VMware：
```
禁用 hyper-v
bcdedit /set hypervisorlaunchtype off
恢复 Hyper-v
bcdedit /set hypervisorlaunchtype auto
```
