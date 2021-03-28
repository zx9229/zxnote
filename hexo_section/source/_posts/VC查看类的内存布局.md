---
title: VC查看类的内存布局
categories:
  - Windows
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2021-03-07 17:39:08
---
omit
<!--more-->

![VC2013.jpg](VC2013.jpg)

[vs或者gcc下如何查看类的虚表中有什么东西？ - 知乎](https://www.zhihu.com/question/304309743)  
[使用 CL 编译器选项查看 C++ 类内存布局--转 - 梦想Sky - 博客园](https://www.cnblogs.com/dsky/archive/2012/02/07/2340984.html)  
[C++虚表详解_chczy1的博客-CSDN博客_虚表](https://blog.csdn.net/chczy1/article/details/100521615)  
[查看虚函数表和类内存布局，以及使用MSVC与GCC hack验证_五月花-CSDN博客](https://blog.csdn.net/friendbkf/article/details/49869703)  
[VS开发人员查看C++类内存布局_u012662731的博客-CSDN博客](https://blog.csdn.net/u012662731/article/details/53889105)  
总的来说，就是
```
cl.exe test.cpp /d1reportAllClassLayout
cl.exe test.cpp /d1reportSingleClassLayout[className]
```
不过我没找到相关官方的出处。  
