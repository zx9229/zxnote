---
title: DokuWiki相关
date: 2018-02-28 22:46:26
categories:
- MyDefaultCategory
tags:
toc: false
---
摘要暂略。
<!-- more -->

## CentOS 下安装 DokuWiki  
1. 安装必要的依赖服务  
```
yum -y install httpd php  # 安装 httpd 和 php
service httpd restart     # 启动 httpd
apachectl -v  # 查看服务程序的版本号
httpd -v      # 查看服务程序的版本号
php -v        # 查看服务程序的版本号
```

2. 检查`httpd`服务是否正常运行  
在浏览器中输入`http://服务器IP地址/`进行检查。  
备注：开启80端口
```
service iptables status
iptables -I INPUT -p tcp --dport 80 -j ACCEPT
service iptables save
```

3. 设置`httpd`服务开机自启动  
```
chkconfig –-list httpd  # 检查httpd的开机自启动
chkconfig httpd on      # 设置httpd的开机自启动
```

4. 下载`DokuWiki`的压缩包并解压到目标文件夹  
压缩包的下载地址：  
```
https://download.dokuwiki.org/
https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz
```
下载后，用`tar -xf 文件名`解压并重命名文件夹，将其匹配到`/var/www/html/dokuwiki`路径。  
备注：查看 DokuWiki的版本号`cd /var/www/html/ && cat dokuwiki/VERSION`。  

5. 给文件夹设置权限  
```
chown -R apache:apache /var/www/html/dokuwiki
```
备注：  
不需要修改文件的读写执行权限了。因为压缩包里面已经把权限设置好了。  
```
chown [OPTION]... [OWNER][:[GROUP]] FILE...
chmod 的 664 代表了[ugo]，即user-group-other
find /var/www/html/ -type f -perm /1 (find 查找指定权限的文件)http://blog.csdn.net/lidonghat/article/details/66478071
```

6. 在浏览器打开`install.php`并按指示进行操作  
在浏览器中输入下面的链接以打开`install.php`：  
```
http://[dokuwikiPath]/install.php
http://127.0.0.1/dokuwiki/install.php
http://176.122.164.105/dokuwiki/install.php
```
参考链接：
```
https://www.dokuwiki.org/install
https://www.dokuwiki.org/installer
https://www.dokuwiki.org/install:permissions
https://www.dokuwiki.org/install:centos
```

7. 修改文件名的编码方式(可选,建议)  
编辑`dokuwiki/conf/local.php`文件，使其包含如下配置`$conf['fnencode'] = 'utf-8';`即可。  

8. 启用`.htaccess`文件(可选,建议)  
编辑`httpd.conf`文件(一般是`/etc/httpd/conf/httpd.conf`文件)，然后搜索`.htaccess`字符串，你应当在附近能看到`AllowOverride None`，将其修改为`AllowOverride All`，然后重启`httpd`服务。  
参考链接：  
```
https://www.dokuwiki.org/start?id=zh:security
https://www.dokuwiki.org/security
https://www.dokuwiki.org/security#web_access_security
```

9. 修改`data`目录到其他路径(可选)  
假如我们要将`data`目录匹配到`/Dropbox/dokuwiki/data/`路径，那么：  
编辑`dokuwiki/conf/local.php`文件，使其包含如下配置`$conf['savedir'] = '/Dropbox/dokuwiki/data';`。  
然后移动data目录到目标路径(这里我们将data移到Dropbox里，然后创建软链接)：  
```
mv /var/www/html/dokuwiki/data /Dropbox/dokuwiki/.  # 移动data目录
chown -R apache:apache /Dropbox                     # 设置所属的权限
```
参考链接：[安全](https://www.dokuwiki.org/start?id=zh:security)。  

10. 修改`conf`目录到其他路径(可选)  
假如我们要将`conf`目录匹配到`/Dropbox/dokuwiki/conf/`路径，那么：  
创建`dokuwiki/inc/preload.php`文件，其内容如下所示：  
```
<?php
define('DOKU_CONF','/Dropbox/dokuwiki/conf/');
```
然后`chown apache:apache preload.php`进行赋权。  
然后移动`conf`目录到目标路径。  
```
mv /var/www/html/dokuwiki/conf /Dropbox/dokuwiki/.  # 移动conf目录
chown -R apache:apache /Dropbox                     # 设置所属的权限
```

11. 设置`php`的`date.timezone`
执行`find / -type f -iname "php.ini"`找到对应文件(可能是`/etc/php.ini`)，打开它，修改到类似下面的配置：
```
[Date]
; Defines the default timezone used by the date functions
; http://php.net/date.timezone
;date.timezone =
date.timezone = Asia/Shanghai
```
然后重启Apache服务，修改便生效了。  
因为DokuWiki用`date_default_timezone_set(@date_default_timezone_get());`获取时区并处理时间戳，相应的DokuWiki显示的时间也正常了。  
参考链接：[Setting TimeZone](https://www.dokuwiki.org/start?id=tips:timezone)

* Linux安装Dropbox  
请参考[安装 - Dropbox](https://www.dropbox.com/install-linux)的`通过命令行安装无外设模式的 Dropbox`。

* 通过“修订记录”可以看到历史记录，历史记录存储在哪里呢？
存储在 dokuwiki/data/attic 里面。

* WIKI 的一个 横向对比网站，建议根据自己需求比较下。
https://www.wikimatrix.org/index.php

DokuWiki
* 我想创建一个中文的文件名，结果DokuWiki创建了一个乱码的文件名，我该怎么办？
详细描述：
当我“创建该页面”时，如果是一个中文页面，那么 DokuWiki 会在 dokuwiki/data/pages/ 下面创建一个乱码的文件名。我想让 DokuWiki 创建一个中文的文件名，我要怎么做？

当我们"创建该页面"时，如果页面的名字是一个中文名，那么DokuWiki会创建一个XX的文件名，并非创建一个中文名
修改成中文名

编辑 dokuwiki/conf/local.php 文件，使其包含如下配置 $conf['fnencode'] = 'utf-8'; 即可。
备注：
可以用 find / -type f -iname "local.php" 寻找 local.php 的路径。
参考链接：
https://www.dokuwiki.org/zh:pagename
https://www.dokuwiki.org/pagename
https://www.dokuwiki.org/config:fnencode

* DokuWiki创建页面名  
一种可行的方式：直接编辑url，访问一个不存在的文件，然后点击“创建该页面”。例如：
http://127.0.0.1/dokuwiki/doku.php?id=某命名空间:儿子命名空间:孙子命名空间:某页面
http://176.122.164.105/dokuwiki/doku.php?id=某命名空间:儿子命名空间:孙子命名空间:某页面
参考链接：
https://www.dokuwiki.org/zh:page
https://www.dokuwiki.org/zh:pagename

* DokuWiki删除页面名  
如果你编辑一个页面名并移除其中的所有内容，那么，DokuWiki会删除该页面。
参考链接：
https://www.dokuwiki.org/zh:pagename

* 一个可用的 MarkDown 插件
https://www.dokuwiki.org/plugin:markdowku
安装方式：
管理=>扩展管理器=>搜索和安装=>搜索MarkDown=>安装


[DokuWiki 用户手册(zh)](https://www.dokuwiki.org/start?id=zh:manual)
[DokuWiki 特性](https://www.dokuwiki.org/zh:features)
