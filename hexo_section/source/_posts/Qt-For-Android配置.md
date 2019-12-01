---
title: Qt-For-Android配置
categories:
  - Qt
toc: false
date: 2019-01-26 18:29:06
tags:
  - Qt
---
用Qt编写Android程序时需要的设置。
<!-- more -->

* Qt下载地址
http://download.qt.io/archive/qt/

* 安装
安装文件：我(2019-07-20)选择了`http://download.qt.io/archive/qt/5.12/5.12.4/qt-opensource-windows-x86-5.12.4.exe`。  
安装方式：全部勾选，然后安装，期间无报错，安装完毕。  

* Qt For Android 配置
启动`qtcreator.exe`，然后`工具`>`选项`>`设备`>`Android`，可以看到，Qt需要`JDK`、`Android SDK`、`Android NDK`这3个东西。并且Qt给出了每个软件的下载地址：  
JDK:`http://www.oracle.com/technetwork/java/javase/downloads/`。  
Android SDK: `https://developer.android.com/studio/`。  
Android NDK: `https://developer.android.com/ndk/downloads/`。  

* 安装JDK
下载JDK8，无脑下一步。  
注意：当前(jdk-8u221-windows-x64.exe)有(jdk-11.0.4_windows-x64_bin.zip) 。因为`java.xml.bind`在JAVA8以后就被弃用了，所以，不建议使用JAVA8以上的版本。  

* 安装Android SDK
简要说明：我们又不用 Android Studio 编写代码，所以下载基本的 Android 命令行工具(basic Android command line tools)就够用了。  
下载地址：`https://dl.google.com/android/repository/sdk-tools-windows-4333796.zip`。  
安装方式：解压即可。不需要配置环境变量。我将其匹配到了目录`C:\sdk-tools-windows-4333796\`。(我们还可以将其用git管理，方便验证一些猜测)。  
如果您不需要 Android Studio，可以从下面下载基本的 Android 命令行工具。您可以使用随附的 sdkmanager 下载其他 SDK 软件包。  
[sdkmanager  |  Android Developers](https://developer.android.com/studio/command-line/sdkmanager)。  
或许我们可以执行`sdkmanager  "build-tools"  "platform-tools"  "platforms;android-28"`命令。  

* 安装Android NDK
下载地址：`https://dl.google.com/android/repository/android-ndk-r19c-windows-x86_64.zip`。  
安装方式：解压即可。不需要配置环境变量。我将其匹配到了目录`C:\android-ndk-r19c-windows-x86_64\android-ndk-r19c\`。  
注意：`Qt-5.12.4`和`android-ndk-r19c`更配呦(使用其他版本的ndk可能会出现各种问题)。  

* 配置 Qt creator
![配置Android选项](qt-5.12.4-配置Android选项Android.png)  
