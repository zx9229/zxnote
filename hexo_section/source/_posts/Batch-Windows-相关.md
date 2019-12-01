---
title: 'Batch[Windows]相关'
categories:
  - MyDefaultCategory
toc: false
date: 2019-05-13 16:12:05
tags:
---
略。
<!-- more -->
* 当前时刻
`%date:~0,4%-%date:~5,2%-%date:~8,2%T%time:~0,2%:%time:~3,2%:%time:~6,2%.%time:~9,2%`。  
`%date:~0,4%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%%time:~9,2%`。

* 当前文件名
目录名`%~dp0`，文件名`%~n0`。

* 获取当前cmd的进程
[批处理如何获取自身进程的PID](http://www.bathome.net/thread-21842-1-1.html)。  
运行wmic进程并获取其父进程：`wmic process where name="wmic.exe" get parentprocessid`。

* 睡眠几秒
`choice /N /D Y /T 5 >nul`。  
