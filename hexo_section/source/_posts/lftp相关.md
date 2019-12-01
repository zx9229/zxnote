---
title: lftp相关
categories:
  - Linux
toc: false
date: 2018-10-27 20:15:20
tags:
---
摘要暂略。
<!-- more -->

* mirror
```
mirror [OPTS] [source [target]]
Mirror specified source directory to local target directory.
将指定的源目录镜像到本地目标目录。
If the second directory is omitted, base name of first directory is used.
如果省略第二个目录，则使用第一个目录的基本名称。
If both directories are omitted, current local and remote directories are used.
如果省略两个目录，则使用当前的本地和远程目录。
If target directory ends with a slash (except root directory) then base name of source directory is appended.
如果目标目录以斜杠结尾（根目录除外），则附加源目录的基本名称。（源目录是否以斜杠结尾都一样因为都是$(basename source)的结果）
-c, --continue      continue a mirror job if possible  如果可能的话，继续镜像作业。
-v, --verbose[=level]    verbose operation  在下载之前显示详细操作。
--use-pget[-n=N]     use pget to transfer every single file 使用pget传输每个文件(使用多个连接获取指定文件，可以加快传输速度，指定连接数)
--Remove-source-files    remove files after transfer (use with caution)  在传输后删除文件（谨慎使用）(它只会删除文件，不会删除文件夹)
```
命令
```
lftp sftp://用户:密码@主机:端口 -e 'mirror --continue --verbose=3 --use-pget-n=8                       源目录 目标目录' > 日志文件 2>&1
lftp sftp://用户:密码@主机:端口 -e 'mirror --continue --verbose=3 --use-pget-n=8 --Remove-source-files 源目录 目标目录' > 日志文件 2>&1
```
