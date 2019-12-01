---
title: git的AutoCrLf和SafeCrLf
date: 2018-02-01 18:27:25
categories:
- git
tags:
toc: false
---
摘要暂略。
<!-- more -->

[Git中的AutoCRLF与SafeCRLF换行符问题](https://www.cnblogs.com/flying_bat/archive/2013/09/16/3324769.html)  
未核实。  

#### AutoCRLF

提交时转换为LF，检出时转换为CRLF  
git config --global core.autocrlf true  

提交时转换为LF，检出时不转换  
git config --global core.autocrlf input  

提交检出均不转换  
git config --global core.autocrlf false  

#### SafeCRLF

拒绝提交包含混合换行符的文件  
git config --global core.safecrlf true  

允许提交包含混合换行符的文件  
git config --global core.safecrlf false  

提交包含混合换行符的文件时给出警告  
git config --global core.safecrlf warn  
