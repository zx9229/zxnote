---
title: awk相关
date: 2018-01-09 23:53:34
categories:
- Linux
tags:
toc: false
---
摘要暂略。  

<!-- more -->

一些链接:  
[awk学习](http://blog.chinaunix.net/uid-23302288-id-3785105.html)  
[linux之awk用法](http://www.cnblogs.com/dong008259/archive/2011/12/06/2277287.html)  
[Unix awk使用手册（第二版）](http://net.pku.edu.cn/~yhf/tutorial/awk_manual.html)  
或者在浏览器上搜索`man awk`然后应当会找到英文的man文档。  

#### awk的一般语法格式  
```
awk [-参数 变量] 'BEGIN{初始化} { 条件类型1{动作1} } { 等等 } { 条件类型n{动作n} } END{后处理}' 要处理的文件名
```
其中，BEGIN和END中的语句分别在开始读取文件(in_file)之前和读取完文件之后发挥作用，可以理解为初始化和扫尾。  

#### awk能修改文件吗  

我没找到官方说明。我个人认为不能。它仅仅是读取文件，逐行读取文件之后，打印到标准输出。  

#### 一个例子  
不允许root用户远程登录的例子:  
```shell
src="^[# \t]*PermitRootLogin[ \t]+(yes|no)[ \t#]*.*$"
dst="PermitRootLogin no"
awk -v srcPattern="${src}" -v dstString="${dst}"  '
BEGIN { cnt = 0; cur = 0 }
{ { cur = 0 } }
{ if ( $0 ~ srcPattern ) { cnt +=1; cur = 1 } }
{ if (cur == 1)
  {
    if (cnt == 1) { print dstString }
  }
  else
  {
    print $0
  }
}
END {}
' /etc/ssh/sshd_config > ~/test.txt
```
注意，$0、$1、$NF都是系统变量，系统变量是需要前缀的，但是自定义变量不需要任何前缀。  
同时为了区分自定义变量和普通文本，在输出文本的时候需要使用双引号将文本引用起来。  

#### 统计某字段出现次数
` awk -F"," '{a[$1]+=1;} END {for(i in a){print a[i]" "i;}}' "文件名"`。  
此处`a`有map的作用。

#### 一些注意点  

内建变量(Built-in Variables)
NF: The number of fields in the current input record
```
//    匹配代码块，可以是字符串或正则表达式
~     匹配，与==相比不是精确比较
!~    不匹配，不精确比较
==    等于，必须全部相等，精确比较
!=    不等于，精确比较
```
