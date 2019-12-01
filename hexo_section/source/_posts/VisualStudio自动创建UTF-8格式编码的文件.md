---
title: VisualStudio自动创建UTF-8格式编码的文件
date: 2018-02-01 18:40:31
categories:
- MSVC
tags:
toc: false
---
摘要暂略。  
<!-- more -->

进入VS安装目录的`VC\vcprojectitems`下。  
比如`C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcprojectitems`。  
修改`hfile.h`呈如下格式
```C++
#pragma once
#pragma execution_character_set("utf-8")
// 本文件以 UTF-8 无 BOM 格式编码
```
修改`newc++file.cpp`到如下内容
```C++
#pragma execution_character_set("utf-8")
// 本文件以 UTF-8 无 BOM 格式编码
```
并将这两个文件修改成`以 UTF-8 无 BOM 格式编码`的格式。

另外，用VS直接修改编码的方式：
`File`=>`Advanced Save Options...`=>将Encoding修改成`Unicode (UTF-8 without signature) - Codepage 65001`将Line endings默认成`Current Setting`。  
