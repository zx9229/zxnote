---
title: SQLserver相关记录
categories:
  - MyDefaultCategory
toc: false
date: 2019-09-25 16:11:51
tags:
---
`SQL Server`，`MSSQL`，
<!-- more -->

* 截取字符串
从`601398:SH`获取`SH`字符串：`RIGHT(code,LEN(code)-CHARINDEX(':',code,1))`。  
从`601398:SH`获取`601398`字符串：`LEFT(code,CHARINDEX(':',code,1)-1)`。  
