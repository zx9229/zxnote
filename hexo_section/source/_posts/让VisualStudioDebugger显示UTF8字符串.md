---
title: 让VisualStudioDebugger显示UTF8字符串
date: 2018-01-02 16:53:10
categories:
- MyDefaultCategory
tags:
toc: false
---
让VS在调试时显示UTF8字符串。

<!-- more -->

文章抄自  
[让VS调试器正确显示UTF-8字符串](http://blog.csdn.net/weiwangchao_/article/details/43453053)  
[Visual Studio 2010/2013 UTF8编码调试时显示中文](https://www.cnblogs.com/mforestlaw/p/4564616.html)  

#### 临时显示  

将要显示的

#### 永久显示  

打开`Common7\Packages\Debugger\Visualizers\stl.natvis`文件，找到  
```
<Type Name="std::basic_string&lt;char,*&gt;">
    <DisplayString Condition="_Mypair._Myval2._Myres &lt; _Mypair._Myval2._BUF_SIZE">{_Mypair._Myval2._Bx._Buf,na}</DisplayString>
    <DisplayString Condition="_Mypair._Myval2._Myres &gt;= _Mypair._Myval2._BUF_SIZE">{_Mypair._Myval2._Bx._Ptr,na}</DisplayString>
    <StringView Condition="_Mypair._Myval2._Myres &lt; _Mypair._Myval2._BUF_SIZE">_Mypair._Myval2._Bx._Buf,na</StringView>
    <StringView Condition="_Mypair._Myval2._Myres &gt;= _Mypair._Myval2._BUF_SIZE">_Mypair._Myval2._Bx._Ptr,na</StringView>
    ...略...
</Type>
```
将`,na`修改成`,s8`即可，修改后如下所示  
```
<Type Name="std::basic_string&lt;char,*&gt;">
    <DisplayString Condition="_Mypair._Myval2._Myres &lt; _Mypair._Myval2._BUF_SIZE">{_Mypair._Myval2._Bx._Buf,s8}</DisplayString>
    <DisplayString Condition="_Mypair._Myval2._Myres &gt;= _Mypair._Myval2._BUF_SIZE">{_Mypair._Myval2._Bx._Ptr,s8}</DisplayString>
    <StringView Condition="_Mypair._Myval2._Myres &lt; _Mypair._Myval2._BUF_SIZE">_Mypair._Myval2._Bx._Buf,s8</StringView>
    <StringView Condition="_Mypair._Myval2._Myres &gt;= _Mypair._Myval2._BUF_SIZE">_Mypair._Myval2._Bx._Ptr,s8</StringView>
    ...略...
</Type>
```
