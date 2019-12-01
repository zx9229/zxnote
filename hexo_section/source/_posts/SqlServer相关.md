---
title: SqlServer相关
categories:
  - MyDefaultCategory
toc: false
date: 2019-05-09 17:57:42
tags:
---
略。
<!-- more -->
ntext转nvarcahr：`CAST( ColumnName AS NVARCHAR(MAX) )`。  
移除换行符：`REPLACE(ColumnName, CHAR(13)+CHAR(10), '')`。  
