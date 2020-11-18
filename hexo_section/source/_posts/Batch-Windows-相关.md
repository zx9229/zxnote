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

* 当前时刻
```bat
@REM  delims=xxx      - 指分隔符集。这个替换了空格和制表符的默认分隔符集。;
@REM  对于每一行, 用#分隔符号, 因为输出的行的内容里没有符号#, 所以整行都被取进了变量里;
@REM  在cmd里执行【PowerShell Get-Help Get-Date -Online】以查看帮助;
@FOR /F "delims=#" %%i IN (' PowerShell Get-Date -Format 'yyyy-MM-dd HH:mm:ss' ') DO @SET YYYY_MM_DD_HH_MM_SS=%%i
@ECHO %YYYY_MM_DD_HH_MM_SS%
```

* 当前文件名
目录名`%~dp0`，文件名`%~n0`。

* 获取当前cmd的进程
[批处理如何获取自身进程的PID](http://www.bathome.net/thread-21842-1-1.html)。  
运行wmic进程并获取其父进程：`wmic process where name="wmic.exe" get parentprocessid`。

* 睡眠几秒
`choice /N /D Y /T 5 >nul`。  
