---
title: Linux相关的收集贴
categories:
  - Linux
toc: false
date: 2018-06-22 21:11:52
tags:
---
摘要暂略。
<!-- more -->

### linux日志相关  
linux日志文件说明
```
/var/log/message 系统启动后的信息和错误日志，是Red Hat Linux中最常用的日志之一
/var/log/secure 与安全相关的日志信息
/var/log/maillog 与邮件相关的日志信息
/var/log/cron 与定时任务相关的日志信息
/var/log/spooler 与UUCP和news设备相关的日志信息
/var/log/boot.log 守护进程启动和停止相关的日志消息
/var/log/wtmp 该日志文件永久记录每个用户登录、注销及系统的启动、停机的事件
```
参见[linux查看系统的日志的一些实用操作 - lclc - 博客园](https://www.cnblogs.com/lcword/p/5917398.html)。  

### dmesg  
查看系统日志的一个命令：`dmesg`。程序崩溃之类的事情发生时，可以从里面找到痕迹。

### 查看用户登录信息  
[Linux用户登录记录日志和相关查看命令汇总](https://blog.csdn.net/jsd2honey/article/details/78404337)。

### 反向搜索执行过的命令
`Ctrl+r`: Linux的`reverse-i-search`。  

### 得到一个Linux后首先要装的几个软件  
```
yum install expect ncdu sshpass tcpdump
```

### ulimit相关
```
ulimit -a
ulimit -c unlimited  # 生成core文件, 可以 ulimit -c 查看当前值, 重启后失效.
```
修改`/etc/security/limits.conf`文件，添加如下行，相当于所有用户都`ulimit -c unlimited`了。无需重启，重新登录即可生效。
```
*               soft    core            unlimited
```

### 查看Linux的磁盘占用
方法1：`ncdu`。
方法2：用`du`命令。也可以结合其他命令进行排序。
```
du -sh ./*    # 占用空间,占用者
du -sh ./* | awk '{{X=0}if($1~".+K"){X=$1*1024}if($1~".+M"){X=$1*1048576}if($1~".+G"){X=$1*1073741824}{print X,"\t",$0}}' | sort -gk1
du -sh ./* | awk '{{X=0}if($1~".+K"){X=$1*1}if($1~".+M"){X=$1*1024}if($1~".+G"){X=$1*1048576}{print X,"\t",$0}}' | sort -gk1
du -s  ./* | sort -nk1
du -ah --max-depth=1
```

### ntpdate授时  
[全球可用的NTP服务器列表与解析服务 - ntp.org.cn & ntpdate.net](http://www.ntp.org.cn/)  
```
ntpdate -q cn.ntp.org.cn
```

### 查看网络流量相关数据
别人推荐了`iftop`和`NetHogs`，我还没有尝试。

### yum相关  
```shell
# 列出所有已安装的软件包
yum list installed
# 卸载
yum remove 包名
```

### 文件被哪些程序使用
`fuser -v 文件名`

### 压缩解压预览命令
```
压缩: tar -caf 压缩包名.tar.xz  路径
解压: tar -xaf 压缩包名.tar.xz
测试: tar -tvf 压缩包名.tar.xz
关于压缩和解压:
-c, --create               create a new archive
-x, --extract, --get       extract files from an archive
-a, --auto-compress        use archive suffix to determine the compression
其中 a 表示自动检测，这个 a 也可以省略，然而个人还是习惯输入——因为如果万一某个地方的 tar 版本不支持自动检测，你至少还能得到一个警告
-t, --list                 list the contents of an archive
-v, --verbose              verbosely list files processed
```

### 过滤掉配置文件的注释项
```
grep -Ev "(^[[:space:]]*$)|(^[[:space:]]*[;#])" smb.conf  # man POSIX
grep -Pv "(^[ \t]*$)|(^[ \t]*[;#])" smb.conf
```

### 用grep查找文件
我想找到所有包含`some_content`的所有文件，同时跳过`.svn`和`.git`文件夹：
```
grep --exclude-dir="\.git" --exclude-dir="\.svn" -r -a -i -l "some_content" ./
-r, --recursive           like --directories=recurse
-a, --text                equivalent to --binary-files=text
-i, --ignore-case         ignore case distinctions
-l, --files-with-matches  print only names of FILEs containing matches
```
也可以使用`GREP_OPTIONS`环境变量(该方式已经被弃用)：
```
export GREP_OPTIONS="--exclude-dir=\.git --exclude-dir=\.svn"
grep -r -a -i -l "some_content" ./
```
也可以使用`alias`：
```
alias grep='grep --exclude-dir=.git --exclude-dir=.svn'
grep -r -a -i -l "some_content" ./
```

### 往shell中的stderr输出内容  
```
echo "echo_message_to_stderr" >&2
```

### crontab 定时任务日志  
假设root用户的`crontab -l`有配置。那么：  
`/var/spool/cron/root`有配置的内容。  
`/var/log/cron`文件有简要记录。  
`/var/spool/mail/root`文件有详细记录。

### yum使用代理服务器
[有代理服务器时使用 yum](https://docs.huihoo.com/yum/managing-software-with-yum-zh_cn/sn-yum-proxy-server.html)。  
```
如果只是暂时使用代理,在命令行输入下面一条命令:
export http_proxy="http://127.0.0.1:8080"
长久使用代理: 修改/etc/yum.conf文件。
备注：版本库连接都在【/etc/yum.repos.d/*.repo】目录。
```

### wget使用代理服务器
```
echo "http-proxy = 127.0.0.1:8080" >> ${HOME}/.wgetrc
```

### 使用ntpd校准时间
```shell
# 安装ntp
yum install ntp
# 修改配置文件
vi /etc/ntp.conf
# 启动服务
systemctl start  ntpd.service
# 设置开机自启动
systemctl enable ntpd.service
```

### 删除空文件夹的命令
```shell
# 函数rme(rm empty dir)
rme(){ [ `ls -A "$1" 2>&1|wc -c` = 0 ] && rm -r "$1";}
rme(){ [ `ls -A "$1" 2>&1|wc -c` = 0 ] && rm -r "$1" || echo FAIL;}
rme(){ [ `ls -A "$1" 2>&1|wc -c` = 0 ] && rm -r "$1" || echo FAIL && return 1;}
rme(){ [ `ls -A "$1" 2>&1|wc -c` = 0 ] && echo empty || echo FAIL && return 1;}  # 测试函数
# 例
rme 某文件夹
```
备注：`find . -type d -empty -exec rm -r {} \;`。
```
find . -type d -empty -delete  # 删除空文件夹
```

#### 获取shell脚本自身所在目录
对于软链接也能正确得到其原始目录。
```shell
SRC="$0"
while [ -L "$SRC" ]; do # resolve $SRC until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SRC" )" && pwd )"
    SRC="$( readlink "$SRC" )"
    # 判断$SRC是否以/开头,你测试[[ "/test" != /* ]]和[[ "./test" != /* ]]应该就明白了.
    [[ "$SRC" != /* ]] && SRC="$DIR/$SRC" # if $SRC was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SRC" )" && pwd )"
```

#### 设置别名
查看当前设置：`alias`。  
临时设置别名：`alias ll='ls -l'`。  
永久设置别名：在`${HOME}/.bashrc`里添加`alias ll='ls -l'`。  
删除某个别名：`unalias ll`。

#### grep和awk配合时可能出现的问题
```shell
# 先grep后awk无任何显示
tail -f 文件名 | grep "匹配条件" | awk '操作'
# 先awk后grep会正常显示
tail -f 文件名 | awk '操作' | grep "匹配条件"
```

#### Makefile添加cleanobj
```
cleanobj:
  find . -type f -name "*.o" -exec rm -f {} \;
```
