---
title: LinuxDeploy相关说明
date: 2018-01-14 09:09:31
categories:
- MyDefaultCategory
tags:
toc: false
---
摘要暂略。  

<!-- more -->

#### 背景  
我淘汰了一些手机，有的因为屏幕有些毛病，有的就是正常的淘汰。这些手机丢了可惜，就想着能不能像树莓派那样使用。  
我期望的要求是：配置好之后，只要Android手机一开机，Linux系统就能立即运行。  
比如Termux之类的软件，我有个手机屏幕花了，我可以用半天时间配置好它，但是每次手机异常关机了，我还要点开软件，运行操作系统，这是我不想做的。  
基于这些想法，我找到了`Linux Deploy`。  

#### 获取busybox  
源码: `https://github.com/meefik/busybox`  
APK下载地址: `https://github.com/meefik/busybox/releases`  
GooglePlay: `https://play.google.com/store/apps/details?id=ru.meefik.busybox`  

#### 获取linuxdeploy  
源码: `https://github.com/meefik/linuxdeploy`  
APK下载地址: `https://github.com/meefik/linuxdeploy/releases`  
GooglePlay: `https://play.google.com/store/apps/details?id=ru.meefik.linuxdeploy`  

#### 安装过程  
建议上网搜一下，基本上都是图文并茂的，我这里就简要列一下过程。  
1. 手机需要root。  
2. 手机安装BusyBox并成功。  
3. 手机安装LinuxDeploy。  
4. 用LinuxDeploy下载镜像并启动。  
5. 设置开机自启动。  

#### 一些注意点  

* LinuxDeploy可以开启守护模式的服务。  
  在LinuxDeploy的`设置`->`管理`->`启动telnetd守护模式`和`启动httpd守护模式`。可以启动守护模式。  
  在守护模式里`su - root`貌似就进入了Android手机的root用户。不需要输入密码的。  

* httpd守护模式不支持IE浏览器。  
  可以用浏览器登录httpd守护模式。貌似不支持IE浏览器。可以用`Google Chrome`和`Firefox`正常使用。  

* 子系统安装到哪里了？  
  安装类型为`镜像文件`时，安装路径默认为`${EXTERNAL_STORAGE}/linux.img`，我们可以在守护模式里执行`echo ${EXTERNAL_STORAGE}`以查看变量的值，或`find / -iname "linux.img"`进行搜索。我个人为`${EXTERNAL_STORAGE}=/storage/emulated/legacy`。  
  不过官方文档说的是`${EXTERNAL_STORAGE} is /sdcard, ${ENV_DIR} is /data/data/com.meefik.linuxdeploy/files.`。  

* 内部存储的路径是什么？  
  好像是`/storage/emulated/legacy/`或`/storage/emulated/0/`或` /sdcard/`。因为我的手机不能插sdcard，所以不知道它的路径。  

* Android自带的命令不好用，我能使用busybox的命令吗？  
  可以执行`/system/xbin/busybox sh -l`进入busybox的命令集。  

* 手机安装的APP都可以在`/data/app/`下面找到apk文件。如果你的手机root过了，你就知道了。  
