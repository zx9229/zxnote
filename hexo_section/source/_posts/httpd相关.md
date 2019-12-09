---
title: httpd相关
categories:
  - Linux
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2019-12-09 16:58:15
---
Linux下安装"The Apache HTTP Server Project"。
<!--more-->

* 安装
`yum install httpd`。  

* 启停查
```sh
service httpd start
service httpd stop
service httpd restart
service httpd status
```

* 修改端口
httpd服务可以配置多个端口。  
`cat /etc/httpd/conf/httpd.conf | grep -i Listen`。  

* 使用
以`/var/www/html/`为根目录，将网页文件放进它里面。例如：
```sh
#                             /var/www/html/
mkdir -vp                     /var/www/html/test/
echo "this is a test page." > /var/www/html/test/test_page.html
```
然后可以浏览器打开`http://HOST:PORT/test/test_page.html`网页。  

* 一些命令
```sh
httpd -v
httpd -V
ps aux | grep httpd
netstat -anp | grep httpd
```
