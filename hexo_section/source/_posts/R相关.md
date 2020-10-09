---
title: R相关
categories:
  - MyDefaultCategory
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2020-09-30 22:29:39
---
omit
<!--more-->

* 线性回归分析  
R内置了一个汽车数据`mtcars`。可以`help(lm)`查看帮助。  
`print(mtcars)`可知`mpg`(Miles Per Gallon)和`wt`(weight)是`mtcars`的两个列。  
`lmfit <- lm(mpg~wt, data=mtcars)`，`plot(lmfit)`，  
我不太理解`mpg~wt`中的`~`是什么意思。  
