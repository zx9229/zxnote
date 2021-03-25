---
title: CSharp相关
categories:
  - MyDefaultCategory
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2020-12-01 23:42:52
---
omit
<!--more-->

[NuGet Package manager stuck on "Retrieving information..." on VS 2013 - Stack Overflow](https://stackoverflow.com/questions/20361374/nuget-package-manager-stuck-on-retrieving-information-on-vs-2013)，  
[在 Visual Studio 中使用控制台安装和管理 NuGet 包 | Microsoft Docs](https://docs.microsoft.com/zh-cn/nuget/consume-packages/install-use-packages-powershell)，  

我想用`NuGet`安装[GitHub - sunkaixuan/SqlSugar](https://github.com/sunkaixuan/SqlSugar)，我可以：  
首先，打开网站[NuGet Gallery | Home](https://www.nuget.org/)  
然后，搜索`SqlSugar`，得到一些结果，  
然后，进入`total downloads`最大的那一个结果，然后看到其`Owners`是`jhl52771`，其`Authors`是`sun kaixuan`，可见我们找对了。  
然后，复制`Package Manager`的命令`Install-Package sqlSugar -Version 5.0.1.4`，  
然后，`VS2013`>`TOOLS`>`NuGet Package Manager`>`Package Manager Console`，  
然后，执行命令`Install-Package sqlSugar -Version 5.0.1.4`，  

* C#中数字后面的M是什么意思?  
[浮点数值类型 - C# 引用 | Microsoft Docs](https://docs.microsoft.com/zh-cn/dotnet/csharp/language-reference/builtin-types/floating-point-numeric-types)  
真实文本的类型由其后缀确定，如下所示：  
不带后缀的文本或带有`d`或`D`后缀的文本的类型为`double`  
带有`f`或`F`后缀的文本的类型为`float`  
带有`m`或`M`后缀的文本的类型为`decimal`  
