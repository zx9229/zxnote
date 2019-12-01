---
title: 普通用户访问root用户下面的文件夹
date: 2018-03-01 22:39:25
categories:
- MyDefaultCategory
tags:
toc: false
---
摘要暂略。

<!-- more -->

root用户运行dropboxd程序，在家目录生成了Dropbox文件夹(/root/Dropbox)，我该怎么办，才能让普通用户使用/root/Dropbox目录呢？  
我们假定Dropbox下面有dokuwiki文件夹，我该怎么办才能让普通用户访问/root/Dropbox/dokuwiki文件夹呢？  

* 普通用户直接访问/root/Dropbox/dokuwiki  
Linux下的每个"文件/文件夹"都可以当做一个对象，这个对象有read(r)/write(w)/execute(x)权限。  
比如，我们要ls一个文件夹，其实是使用了这个文件夹的read权限。我们要cd到一个文件夹里面去，其实是使用了这个文件夹的execute权限。  
现在我们有一个普通用户zhan，各文件夹的默认权限如下：  
```
# id zhan
uid=1001(zhan) gid=1001(zhan) groups=1001(zhan)
# ls -l  /
dr-xr-x--- 5 root root 4.0K Jan 21 20:05 root
# ls -l /root
drwx------ 4 root root 4096 Mar  1 21:30 Dropbox
# ls -l /root/Dropbox
drwxr-xr-x 2 root root 4096 Mar  1 21:32 dokuwiki
```
经过如下设置，可以达到我们的目标：  
```
[root@localhost]# ls -l /
dr-xr-x--- 5 root root 4.0K Jan 21 20:05 root
[root@localhost]# chmod o+x /root
[root@localhost]# ls -l /
dr-xr-x--x 8 root root 4096 Mar  1 21:30 root
[root@localhost]# ls -l /root
drwx------ 4 root root 4096 Mar  1 21:30 Dropbox
[root@localhost]# chmod o+x /root/Dropbox
[root@localhost]# ls -l /root
drwx-----x 5 root root 4096 Mar  1 21:32 Dropbox
[root@localhost]# ls -l /root/Dropbox
drwxr-xr-x 2 root root 4096 Mar  1 21:32 dokuwiki
[root@localhost]# chown -R zhan:zhan /root/Dropbox/dokuwiki
[root@localhost]# ls -l /root/Dropbox
drwxr-xr-x 2 zhan zhan 4096 Mar  1 22:02 dokuwiki
[zhan@localhost]$ cd /root/Dropbox/dokuwiki/
[zhan@localhost]$ touch test.txt
```
这样做，有个副作用：  
因为新建的文件夹默认都是755的权限，假如某个普通用户知道其他路径的话，是可以cd到对应路径下的。很显然这样不安全。  
这就要求我们的root用户在每次新建文件夹后，都要`chmod o-x 文件夹`才行。root用户可能会忘记操作。很显然这样不好。  

* 创建软连接  
1. root用户首次运行dropboxd，自动生成/root/Dropbox文件夹。  
2. 关掉dropbox进程。  
3. 移动Dropbox文件夹到/root外面。比如`mv /root/Dropbox /.`。  
4. 创建软连接到原来的位置。比如`ln -s /Dropbox /root/.`。  
5. 启动dropbox进程。  

这样做，也有副作用：  
当root用户备份自己的家目录时，备份的Dropbox其实是一个软链接。  
