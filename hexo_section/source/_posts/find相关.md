---
title: find相关
date: 2017-07-25 09:37:09
categories:
- Linux
tags:
toc: false
---
一些有用的find示例。

<!-- more -->

## 查找，同时忽略掉无权限的目录(其实是不显示无权限的错误消息)
```
find / -iname "*redis*" 2>&1 | grep -v "Permission denied"
find / -iname "*redis*" 2>/dev/null
```

## 查找在某个时间段之内被修改的文件  
方法：用touch生成两个文件，命名为newFile和oldFile。然后用`-newer`和`! -newer`选项即可成功。  
```
touch  -d    "2017-08-01 08:30:00" oldFile
touch --date="2017-08-15 08:30:00" newFile
find .    -newer oldFile            ! -newer newFile
find . \( -newer oldFile \) -and \( ! -newer newFile \)
```

### find的几个选项  
```
-anewer file
       File was last accessed more recently than file was modified.
       文件的最后访问时间比file的修改时间要新。
-cnewer file
       File’s status was last changed more recently than file was modified.
       文件的状态的最后修改时间比file的修改时间要新。
-newer file
       File was modified more recently than file.
       文件的修改时间比file的修改时间要新(file_time<File_time)。
```
可以在man find的`OPERATORS`部分，找到`( expr )`,`! expr`,`-not`,`-a`,`-and`,`-o`,`-or`等运算符。  

* find 的`-ctime`选项
[linux的find命令--按时间查找文件](https://blog.csdn.net/ytmayer/article/details/6364739)
```
-ctime n
       File’s status was last changed n*24 hours ago.
       |----(+n)-----|--(n)--------------|-(-n)-------|
       | ~ (n+1)*24H | (n+1)*24H ~ n*24H | n*24H ~ now|
       -ctime +n    查找距现在 (n+1)*24H 前修改过的文件
       -ctime  n    查找距现在 n*24H 前, (n+1)*24H 内修改过的文件
       -ctime -n    查找距现在 n*24H 内修改过的文件
```

## 查看mtime,atime,ctime的几种方式  

### 用ls查看  
```
-c     with -lt: sort by, and show, ctime (time of last modification of file status information)
       with -l: show ctime and sort by name        (ls -lc: 以名字进行排序,显示ctime[Change Time,状态时间])
       otherwise: sort by ctime
-u     with -lt: sort by, and show, access time
       with -l: show access time and sort by name  (ls -lu: 以名字进行排序,显示atime[Access Time,访问时间])
       otherwise: sort by access time
-l     use a long listing format                   (ls -l : 以名字进行排序,显示mtime[Modify Time,修改时间])
-t     sort by modification time
```
`ls -l`显示的时间为"修改时间"。你可以`man ls`然后查看和尝试`-t`(sort by modification time)选项。  

### 用stat查看
```
$ stat --help
Usage: stat [OPTION]... FILE...
Display file or file system status.
```

### 临时收集
`find . -type f -name "*.o" -exec rm -f {} \;`

* 找到最近7天内修改过的文件，并按修改时间顺序显示
`find . -type f -ctime -7 | sed ':L;N;s/\n/ /;t L' | xargs ls -l -rt`
