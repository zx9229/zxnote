---
title: IceBox冰箱APP相关
categories:
  - 软件相关
toc: false
date: 2018-12-12 20:25:34
tags:
---
摘要暂略。

<!-- more -->

* IceBox冰箱APP的一个可用的备份文件
[原始下载地址](https://pan.lanzou.com/i10lx2h?t)。文件名为`icebox_recovery_1526167839549.zip`。  
[我的下载地址](IceBox冰箱.zip.zi)。  

* adb相关
{% post_link ADB相关 %}。  

* Shizuku Manager
`https://play.google.com/store/apps/details?id=moe.shizuku.privileged.api`

* GooglePlay里面的下载链接
`https://play.google.com/store/apps/details?id=com.catchingnow.icebox`

* 冰箱 Ice Box 应用的在线文档
`https://github.com/heruoxin/Ice-Box-Docs`

* Device Owner （免 root）模式设置.md
`https://github.com/heruoxin/Ice-Box-Docs/blob/master/Device%20Owner%20（免%20root）模式设置.md`

* 华为荣耀8使用IceBox
1. 下载`adb`程序。
2. `设置`>`应用和通知`>`应用分身`, 关闭所有应用分身。
3. `设置`>`用户和账户`, 退出所有用户。
4. `设置`, 在醒目位置(首行)应当能看到`华为账号、云空间、应用市场等`或`登录华为账号`, 如果登录了华为账号, 请退出它。
5. 用USB连接电脑和手机, 选择`USB连接方式`为`传输照片`或`传输文件`, 总之不要选择`仅充电`。
6. `设置`>`系统`>`开发人员选项`>`USB调试`>`连接USB后启用调试模式`, 开启它。
7. 执行`adb devices`确保正确设置了ADB调试。
8. 参考`Device Owner （免 root）模式设置.md`执行对应命令。
9. `设置`>`系统`>`开发人员选项`>`恢复默认设置`。

* 操作成功时可能会如下提示
```
D:\platform-tools>adb shell dpm set-device-owner com.catchingnow.icebox/.receiver.DPMReceiver
Success: Device owner set to package ComponentInfo{com.catchingnow.icebox/com.catchingnow.icebox.receiver.DPMReceiver}
Active admin set to component {com.catchingnow.icebox/com.catchingnow.icebox.receiver.DPMReceiver}
```

* 手机开启应用分身时可能会如下报错
```
D:\platform-tools> adb shell dpm set-device-owner com.catchingnow.icebox/.receiver.DPMReceiver
java.lang.IllegalStateException: Not allowed to set the device owner because there are already several users on the device
        at android.os.Parcel.readException(Parcel.java:1954)
        at android.os.Parcel.readException(Parcel.java:1892)
        at android.app.admin.IDevicePolicyManager$Stub$Proxy.setDeviceOwner(IDevicePolicyManager.java:5176)
        at com.android.commands.dpm.Dpm.runSetDeviceOwner(Dpm.java:148)
        at com.android.commands.dpm.Dpm.onRun(Dpm.java:96)
        at com.android.internal.os.BaseCommand.run(BaseCommand.java:54)
        at com.android.commands.dpm.Dpm.main(Dpm.java:41)
        at com.android.internal.os.RuntimeInit.nativeFinishInit(Native Method)
        at com.android.internal.os.RuntimeInit.main(RuntimeInit.java:315)
```

* 手机登录华为账号时可能会如下报错
```
D:\platform-tools> adb shell dpm set-device-owner com.catchingnow.icebox/.receiver.DPMReceiver
java.lang.IllegalStateException: Not allowed to set the device owner because there are already some accounts on the device
        at android.os.Parcel.readException(Parcel.java:1954)
        at android.os.Parcel.readException(Parcel.java:1892)
        at android.app.admin.IDevicePolicyManager$Stub$Proxy.setDeviceOwner(IDevicePolicyManager.java:5176)
        at com.android.commands.dpm.Dpm.runSetDeviceOwner(Dpm.java:148)
        at com.android.commands.dpm.Dpm.onRun(Dpm.java:96)
        at com.android.internal.os.BaseCommand.run(BaseCommand.java:54)
        at com.android.commands.dpm.Dpm.main(Dpm.java:41)
        at com.android.internal.os.RuntimeInit.nativeFinishInit(Native Method)
        at com.android.internal.os.RuntimeInit.main(RuntimeInit.java:315)
```

* 华为荣耀8查看某程序的服务
`设置`>`应用和通知`>`应用管理`>`微信`>`内存`, 然后可以查看`详细信息`。

* 华为荣耀8查看所有(?)进程
`设置`>`电池`>`耗电排行`>`软件排行`。

* 华为荣耀8查看各程序的内存使用量
`设置`>`存储`>`内存`>`各应用使用的内存`, 可查看`应用的内存使用量`的统计。然后点击`微信`可查看`内存使用量`的`详细信息`。

* 华为Mate9设置手机防止息屏断网
`设置`>`电池`>`更多电池设置`>`休眠时始终保持网络连接`>`[开]`，  
`设置`>`无线和网络`>`移动网络`>`高级`>`WLAN/移动数据连接切换提示`>`[自动使用移动数据连接]`，  
`设置`>`应用`>`权限管理`>`点击右上角三个点`>`特殊访问权限`>`电池优化`>`将指定的APP设置为"不允许"`，  
