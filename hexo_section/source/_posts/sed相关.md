---
title: sed相关
date: 2018-01-09 01:08:00
categories:
- Linux
tags:
toc: false
---
使用sed的过程中随便记录一些东西。  

<!-- more -->

一些链接:  
[sed命令_Linux sed 命令用法详解](http://man.linuxde.net/sed)  
[[Sed] 分支&测试](http://www.cnblogs.com/fanyl5/p/4795793.html)  
[Linux命令的工作原理（1）——sed的工作原理](http://blog.csdn.net/yanquan345/article/details/19613443)  
[sed修炼系列(三)：sed高级应用之实现窗口滑动技术](http://www.cnblogs.com/f-ck-need-u/p/7496916.html)  
[Sed and awk 笔记之 sed 篇：高级命令（一）](http://kodango.com/sed-and-awk-notes-part-4) 
[sed高级用法：模式空间(pattern space)和保持空间(hold space)](http://blog.csdn.net/itsenlin/article/details/21129405)  
[SED文本处理工具难点解析（D/d P/p N/n）](http://blog.51cto.com/crazy123/1181872)  

### sed的书籍推荐  

建议看一下`《sed与awk》`这本书。  

### sedsed  

你可以用`sedsed`调试你写的sed脚本。当然也可以用它验证一些你的猜测。  
[sedsed can debug, indent, tokenize and HTMLize your sed scripts.](http://aurelio.net/projects/sedsed/)  

### sed的地址(Addresses)有哪些写法  

执行`man sed`，找到`Addresses`部分，它描述了地址的几种写法。  

### sed的命令(COMMAND)有哪些  

执行`man sed`，找到`COMMAND SYNOPSIS`部分，其中：  
`Zero-address ``commands''`: 不接受地址的sed命令。  
`Zero- or One- address commands`: 可以接受0个或1个地址的sed命令。  
`Commands which accept address ranges`: 可以接受0个或1个或地址范围的sed命令。  

### sed的一些命令的解释等  

有些sed命令有大小写之分。通常来说，小写的命令是全部性质的，大写的命令是局部性质的。  
```
d(delete)    ①清空模式空间。
D(Delete)    ①删除模式空间的第一行(同时删除行尾的"\n"[如果有多行的话])
g(get)       ①清空模式空间。    ②拷贝保持空间的内容到模式空间(保持空间的内容不变)
G(Get)       ①附加"\n"到模式空间②附加保持空间的内容到模式空间(保持空间的内容不变)
h(hold)      ①清空保持空间。    ②拷贝模式空间的内容到保持空间(模式空间的内容不变)
H(hold)      ①附加"\n"到保持空间②附加模式空间的内容到保持空间(模式空间的内容不变)
n(next)      ①清空模式空间。    ②读取下一行内容到模式空间④行号计数器加一
N(Next)      ①附加"\n"到模式空间②附加下一行内容到模式空间④行号计数器加一
p(print)     打印模式空间的整个内容
P(Print)     打印模式空间的首行内容
q(quit)      立即退出sed脚本。如果未禁用auto-print的话，退出之前会输出模式空间的整个内容。
Q(Quot)      立即退出sed脚本。不输出任何内容。
t(test)      有条件的跳转到label处。条件：从最新的输入行被读取并且从上一个t/T以来命令s执行了成功的替换。参见man sed,像x,a,i,c等命令不能触发t命令。
T(Test)      有条件的跳转到label处。条件：从最新的输入行被读取并且从上一个t/T以来命令s未执行成功的替换。
b(branch)    无条件的跳转到label处。
x(Exchange)  互换模式空间的内容和保持空间的内容
s(substitute)替换整个模式空间的内容(如果有多行的话,会将多行作为一个字符串进行处理)
y            将源字符转译为目标字符。它是枚举性质的。
=            打印当前行号。
!            放在地址(Addresses)后面。对地址取反。表示相应的命令工作在不匹配该地址的行号上。
:            在脚本中标记一行，用于实现由b或t或T的控制转移。
;            分隔两个命令。用于同一行内书写多个命令的时候。
{}           标识一个命令块。
#            注释。
a\(append)   在当前行下面插入文本。注意：没有将文本加入到模式空间；它和N(假定N不读取下一行)的行为不一样。
i\(insert)   在当前行上面插入文本。注意：没有将文本加入到模式空间。
c\(change)   将当前行改为新的文本。猜测：①清空模式空间②标记新的文本为当前行的文本③本次的脚本运行结束(类似于continue;不再运行后面的语句)
^            匹配行开始
$            匹配行结束
```

### sed执行过程的一点猜测  

sed在读取一行的时候，"\n"作为两行之间的分界，并没有被读进去。  
sed在执行N时，会读取新的一行，并将新行放入模式空间。此时，sed会在老行和新行之间添加"\n"作为两行之间的分界。  
sed在执行H时，会将模式空间的数据附加到保持空间。此时，sed会在保持空间的旧有的数据和模式空间的数据之间添加"\n"作为两行之间的分界。  
如果在某一时刻，模式空间/保持空间的数据为`^$`，可能真的什么数据都没有，也可能有一个空行。  

### 需要转义的字符
[正则表达式(regular expression)](http://zx9229.blog.163.com/blog/static/211449268201492761326438/)。  
正则表达式之所以拥有巨大的魔力，就是因为有这12个标点字符才产生的。【 $ ^ * ( ) + { [ | \ . ? 】应注意的是，在这个列表中并不包含右方括号] 、连字号- 、右花括号} 。前两个符号只有在它们位于一个没有转义的 [ 之后才成为元字符，而 } 只有在一个没有转义的 { 之后才是元字符。在任何时候都没有必要对 } 进行转义。

### sed中需要转义的正则表达式
`()`指代正则表达式的分组时，需要转义。
`+`指代1次或多次时需要转义。  
例：替换纯数字的行为空行：`sed 's/^[0-9]\+$//g'`。其中`+`指代1次或多次，需要转义。  
`*?`中的`?`指代重复任意次，但尽可能少重复，时，需要转义。
`[]`表示列出范围时，需要转义。
`{}`指代重复的时候，需要转义。例如：`sed 's/^.\{3\}/___/g filename'`。

### 一些注意点  

sed的`-r`是扩展的正则表达式，它不支持`\d`的写法，不过可以用`[0-9]`替代过去。  
执行命令a/i/c时，如果命令不在末尾，你可能会遇见困难。此时你可以看《sed与awk》的"第五章 基本sed命令"的"5.5 追加,插入和更改"，可能对你有帮助。  
脚本中的空正则表达式`//`表示和前面的正则表达式一样。  
and the special escapes \1 through \9 to refer to the corresponding matching sub-expressions in the regexp.  

### 一个脚本分析  

```shell
src="原始字符串"
dst="目标字符串"  # 目标字符串里面可以有表示换行符的"\n"
file="文件名"
sed -i -r "/${src}/{x;//D;g;s//${dst}/g}"  "${file}"
```
脚本作用：file里面有多个${src}字符串，现在，将第一个${src}字符串(以正则表达式的方式)替换为${dst}字符串，其余的都删除。  
脚本的用途举例:  
禁用root远程登录: src=`^[# \t]*PermitRootLogin[ \t]+(yes|no)[ \t#]*.*$`, dst=`PermitRootLogin no`。  
修改MaxAuthTries: src=`^[# \t]*MaxAuthTries[ \t]+\d+[ \t#]*.*$`, dst=`MaxAuthTries 3`。  
脚本解释:  
```
/${src}/ {
    x
    // d
    g
    s//${dst}/g
}
```
脚本展开之后如上所示。它利用保持空间的数据作为标志。  
当读取到${src}的行时，先看看保持空间里是不是已经有数据了(先执行x和保持空间互换数据, 再比较字符串)。  
其中, 空正则表达式`//`表示和前面的正则表达式`/${src}/`一样。  
如果已经有数据了，说明已经不是第一次遇见了，就执行d删除它。删除之后，本次脚本直接结束，后面的命令不再执行。  
如果没有数据，说明这是第一次遇见。因为条件不足，删除命令d无法执行。然后接着执行后面的语句。  
先执行g把数据从保持空间拷贝过来，然后执行s替换字符串。  
它相当于：第一次读取到${src}，就将其替换为${dst}；以后再遇见，就直接删除。  

### 一个脚本分析  

```shell
src="原始字符串"
dst="目标字符串"
file="文件名"
sed -i -r "/${src}/{x;/^$/a${dst}
d}"  "${filename}"
```
脚本作用：file里面有多个${src}字符串，现在，将第一个${src}字符串所在的行修改成${dst}字符串，其余的都删除。  
脚本解释:  
```
/${src}/ {
    x
    /^$/ a\
${dst}
    d
}
```
脚本展开之后如上所示。它利用保持空间的数据作为标志。  
当读取到${src}的行时，先看看保持空间里是不是已经有数据了(先执行x和保持空间互换数据, 再比较字符串)。  
如果(原来的保持空间,现在的模式空间里的)是空字符串，表示是第一次遇见它。就在此行下面插入${dst}字符串。  
不管是不是第一次遇见的，都执行d删除模式空间里的数据。  
它相当于：只要读到${src}的行，都删除它；同时在第一次读到它时，插入${dst}字符串。  

### 例子收集  
* 删除文件中包含某个关键字的所有行  
`sed -i '/QWQ/d' <file>`
* 插入数据到文件的第一行  
`sed -i '1i line_content' filename`
* 删除文件的第二行  
`sed -i '2d' filename`
* 替换第2行中的原字符(.\*)到目标字符(new_content)  
`sed -i '2s/.*/new_content/' filename`
* 逐行替换第三次匹配到的原字符(aaa)到目标字符(bbb)  
`sed -i 's/aaa/bbb/3' filename`
* 删除最后一个字符  
`sed -i 's/.$//' filename`
* 替换逗号为换行符  
`sed 's/,/\n/g' filename`
* 删除空行
`sed '/^$/d'`。<label style="color:red">注意`d`仅和`/`搭配时才生效，比如`sed '#^$#d'`就是无效的。</label>  
* 删除空白行
`sed '/^[[:space:]]*$/d'`
* 删除换行符  
`sed ':L;N;s/\n//;t L' filename`
* 正则表达式与组号(重复本行内容)  
`sed 's/^\(.*\)$/\1\1/g' filename`
* 把所有的abc替换成def，并打印发生替换的那些行  
`sed -n 's/abc/def/gp' filename`
* 示例
`sed 's/^\([^,]\+,\)\{3\}\([^,]\+\)$/\1/g' filename`想要`^([^,]+,){3}([^,]+)$`。  

* 临时收集
sed匹配数字的方法`[0-9]`和`[[:digit:]]`，但是无法使用`\d`，跟Perl不一样，Perl这三样都可以。  
