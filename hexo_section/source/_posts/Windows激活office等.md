---
title: Windows激活office等
categories:
  - Windows
toc: false
date: 2019-07-27 23:23:25
tags:
---
激活Office2016、Office2019等  
备注：可以搜索`hexo 引用站内文章`查询相关信息。  
<!-- more -->

{% post_link vlmcsd相关 %}。  

* KMS激活office2016  
[2016_officeProPlus_projectPro_visioPro_激活脚本](2016_officeProPlus_projectPro_visioPro_激活脚本.7z)。  

* KMS激活office_professional_plus_2019
[cn_office_professional_plus_2019激活脚本](cn_office_professional_plus_2019_x86_x64_dvd_5e5be643.iso.激活.cmd)。  

* 其他备注  
[[极客玩具] Win、Office 无配置 自激活](https://juejin.im/post/6844903745776680968)  
[用于管理 Office 批量激活的工具 - Deploy Office | Microsoft Docs](https://docs.microsoft.com/zh-cn/DeployOffice/vlactivation/tools-to-manage-volume-activation-of-office)  
可以用 vlmcsd 激活 Office 。  
```
/remhst          删除 KMS 主机名并将端口设置为默认值。默认端口为 1688。
/sethst:value    使用用户提供的主机名设置 KMS 主机名。Value 参数为必需。
                 这将设置 HKLM\Software\Microsoft\OfficeSoftwareProtectionPlatform\KeyManagementServiceName (REG_SZ) 。
/setprt:value    使用用户提供的端口号设置 KMS 端口。默认端口号为 1688。Value 参数为必需。
                 这将设置 HKLM\Software\Microsoft\OfficeSoftwareProtectionPlatform\KeyManagementServicePort (REG_SZ) 。
```
