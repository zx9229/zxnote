---
title: xargs相关
categories:
  - Linux
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2020-11-02 11:15:08
---
omit
<!--more-->

NAME
       xargs - build and execute command lines from standard input
       xargs - 根据标准输入构建和执行命令行

它的作用是从标准输入中读取内容，并将此内容传递给它要协助的命令，并作为那个命令的参数来执行。  
xargs 可以将管道或标准输入（stdin）数据转换成命令行参数，也能够从文件的输出中读取数据。  
xargs 是一个强有力的命令，它能够捕获一个命令的输出，然后传递给另外一个命令。  

例如：  
`find -type f -name '*.h' | xargs grep "hello"`  
相当于，将find命令的结果取出来，对于每一条结果，作为grep的参数，执行一次grep命令。  
