---
title: wget相关
categories:
  - 软件相关
toc: false
date: 2019-08-20 02:44:14
tags:
---
略
<!-- more -->

* Windows binaries of GNU Wget
[Wget - GNU Project - Free Software Foundation](https://www.gnu.org/software/wget/)。  
[GNU Wget 1.20.3 for Windows](https://eternallybored.org/misc/wget/)。  
[wget-1.20.3-win32.zip](https://eternallybored.org/misc/wget/releases/wget-1.20.3-win32.zip)。  
[wget-1.20.3-win64.zip](https://eternallybored.org/misc/wget/releases/wget-1.20.3-win64.zip)。  

* 全站抓取
`wget -m -e robots=off -k -E "http://www.abc.net/"`可以将全站下载以本地的当前工作目录，生成可访问、完整的镜像。  
[wget整站抓取、网站抓取功能；下载整个网站；下载网站到本地](https://www.cnblogs.com/shengulong/p/8445828.html)。  
```
--restrict-file-names=OS  restrict chars in file names to ones OS allows.
-k,  --convert-links      make links in downloaded HTML or CSS point to local files.
```
wget --restrict-file-names=ascii -r -p -np -k http://www.gushequ.com/
