---
title: sqlite相关
categories:
  - MyDefaultCategory
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2020-08-16 23:01:44
---
omit
<!--more-->

在`https://sqlite.org/download.html`可以下载`sqlite-tools-win32-x86`(例如`sqlite-tools-win32-x86-3320300.zip`)以管理sqlite文件。  
```
D:\sqlite-tools-win32-x86-3320300>sqlite3.exe
Enter ".help" for usage hints.
Use ".open FILENAME" to reopen on a persistent database.

sqlite> .show
colseparator: "|"
rowseparator: "\n"

sqlite> .separator "," "\r\n"

sqlite> .show
colseparator: ","
rowseparator: "\r\n"

sqlite> .quit

临时
.headers off
.separator ","
.separator "," "\r\n"
```
