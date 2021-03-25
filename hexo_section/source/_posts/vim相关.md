---
title: vim相关
date: 2018-01-09 23:17:01
categories:
- vim
tags:
toc: false
---
摘要暂略。  

<!-- more -->

一些链接:  
[VIM 文件编码识别与乱码处理](edyfox.codecarver.org/html/vim_fileencodings_detection.html)  
[vim查看配置项的值以及查看环境变量的值](https://www.douban.com/note/413404532/)  
[Vim中的四种编码设置](https://blog.wangmingkuo.com/four-encoding-style-in-vim/)  

#### 我用Vim打开一个文件结果中文部分乱码  

Vim单独维护了一些参数。修改Linux的操作系统编码，一般来说，对vim没有作用。  

1. 操作系统编码能不能正常显示中文呢？  
你可以head/tail/cat一个文件，看看屏幕上能不能正常显示中文。  

2. Vim有哪些编码相关的配置项？
此部分内容直接摘抄了网上的内容。尚未考证。  

* `encoding`:(查看当前值:`:set encoding?`):  
  Vim内部使用的字符编码方式。  
  一般设置为`set encoding=utf-8`。  

- `fileencoding`(查看当前值:`:set fileencoding?`):  
  Vim打开了一个文件，Vim认为这个文件是什么编码格式。  

+ `fileencodings`(查看当前值:`:set fileencodings?`):  
  Vim尝试着用哪些编码打开一个文件。  
  常设置为`set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1`。  

* `termencoding`:  
  Vim用于屏幕显示的编码。  
  如果termencoding没有设置，则直接使用encoding不进行转换。  
  一般不设置。  

#### Vim的配置文件一般在哪里  
```
/etc/virc
/etc/vimrc
~/.virc
~/.vimrc
~/.viminfo
等。。。
```

#### 以cp936的编码方式加载文件
打开一个文件，发现文件是乱码，然后想以cp936的编码方式重新加载文件，可以输入以下命令：
```
:edit ++encoding=cp936
:e    ++enc     =cp936
```
你可以输入`:help :edit`查看相关帮助。

#### 在vim中执行shell命令
正常模式(按Esc返回正常模式)下执行`:!cmd`比如`:!date`。你可以`:help !cmd`查看对应的帮助。  
备注：你也可以`:!bash`进入一个shell，然后执行一些命令，然后`CTRL-D`或`exit`离开shell。

#### 在vim中删除^M
在vim中执行`:%s/^M//g`（输入`^M`的方法：先`CTRL-V`再`CTRL-M`）。

#### 往vim中粘贴代码时缩进变乱了
1. 打开vim。
2. 执行`:set paste`进入粘贴模式。
3. 按`i`进入插入模式。
4. 往vim里粘贴代码。
5. 按`Esc`退出插入模式。
6. 执行`:set nopaste`退出粘贴模式。

#### 在vim中批量替换字符串
查看帮助`:help :substitute`。  
格式：`:[range]s[ubstitute]/{pattern}/{string}/[flags] [count]`。  
例子：`:%s#pattern#string#g`或`:1,$s/pattern/string/g`。  

#### vim删除当前行之前的所有行
[https://www.linuxprobe.com/vim-delete-lines.html](vim编辑器如何删除一行或者多行内容 | 《Linux就该这么学》)  
`:1,.-1d`并回车(vim删除当前行之前的所有行，不含当前行)。  
解析：  
`:3,5d`删除第3行至第5行(包含第3行和第5行)。  
`:3,5-1d`删除第3行至第(5-1=4)行。  
`:1,.d`删除第1行至第当前行(`.`代表当前行)。  
`:1,.-1d`删除第1行至第当前行之前的一行(`.`代表当前行)。  
其中(`.`代表当前行)的信息可以从`:help range`中查到。  

#### vim删除当前行之后的所有行
`:.+1,$d`并回车(vim删除当前行之后的所有行，不含当前行)。  
