---
title: VC构建命令和属性的宏-Macros-for-Build-Commands-and-Properties
categories:
  - Windows
toc: false
date: 2018-09-12 15:40:49
tags:
---
摘要暂略。
<!-- more -->

在`VS2013`下，`HELP`->`View Help`，会转跳到VS的在线帮助页面：  
https://msdn.microsoft.com/query/dev12.query?appId=Dev12IDEF1&l=en-US&k=k(MSDNSTART)&rd=true  
然后点击放大镜按钮以调出输入框，然后输入`solutiondir macro`并搜索，可以看到`Macros for Build Commands and Properties`的链接，该链接列出了用于构建命令和属性页的所有的宏，网上有人对此已经做了翻译：  
http://www.cnblogs.com/lidabo/archive/2012/05/29/2524170.html  
我就不客气的copy过来了：  

#### 宏和说明

* $(RemoteMachine)  
设置为“调试”属性页上“远程计算机”属性的值。有关更多信息，请参见更改用于 C/C++ 调试配置的项目设置。  

* $(Configuration)  
The name of the current project configuration (for example, "Debug").  
当前项目的配置的名字。你选择了Debug，该宏就是Debug，Release也同理。  

* $(References)  
以分号分隔的引用列表被添加到项目中。  

* $(ConfigurationName)  
当前项目配置的名称（例如“Debug”）。  

* $(PlatformName)  
当前项目平台的名称（例如“Win32”）。  

* $(Inherit)  
指定在由项目生成系统所撰写的命令行中，继承的属性出现的顺序。默认情况下，继承的属性出现在当前属性的末尾。  

* $(NoInherit)  
使任何将被继承的属性不被继承。若还要避免同级级别的计算，请使用 $(StopEvaluating)。使用 $(NoInherit)会导致对于同一属性忽略任何出现的 $(Inherit)。  

* $(StopEvaluating)  
立即停止计算链中宏的计算。出现在 $(StopEvaluating) 之后的任何值将不出现在宏的计算值中。如果$(StopEvaluating) 在 $(Inherit) 之前，计算链中当前位置的继承值将不会连接到宏值。$(StopEvaluating)是 $(NoInherit) 的功能超集。  

* $(ParentName)  
包含此项目项的项的名称。该名称将是父文件夹名称或项目名称。  

* $(RootNameSpace)  
包含应用程序的命名空间（如果有）。  

* $(IntDir)  
Path to the directory specified for intermediate files relative to the project directory. This path should have a trailing slash. This resolves to the value for the Intermediate Directory property.  
为中间文件指定的(相对于项目目录的)目录路径。这个路径应当有一个尾斜杠。它解析为“中间目录”属性的值。  

* $(OutDir)  
输出文件目录的路径，相对于项目目录。这解析为“输出目录”属性的值。  

* $(DevEnvDir)  
Visual Studio .NET 的安装目录（定义形式：驱动器 + 路径）；包括尾部的反斜杠“\”。  

* $(InputDir)  
输入文件的目录（定义形式：驱动器 + 路径）；包括尾部的反斜杠“\”。如果该项目是输入，则此宏等效于 $(ProjectDir)。  

* $(InputPath)  
输入文件的绝对路径名（定义形式：驱动器 + 路径 + 基本名称 + 文件扩展名）。如果该项目是输入，则此宏等效于 $(ProjectPath)。  

* $(InputName)  
输入文件的基本名称。如果该项目是输入，则此宏等效于 $(ProjectName)。  

* $(InputFileName)  
输入文件的文件名（定义为基本名称 + 文件扩展名）。如果该项目是输入，则此宏等效于 $(ProjectFileName)。  

* $(InputExt)  
输入文件的文件扩展名。它在文件扩展名的前面包括“.”。如果该项目是输入，则此宏等效于 $(ProjectExt)。  

* $(ProjectDir)  
项目的目录（定义形式：驱动器 + 路径）；包括尾部的反斜杠“\”。  

* $(ProjectPath)  
项目的绝对路径名（定义形式：驱动器 + 路径 + 基本名称 + 文件扩展名）。  

* $(ProjectName)  
项目的基本名称。  

* $(ProjectFileName)  
项目的文件名（定义为基本名称 + 文件扩展名）。  

* $(ProjectExt)  
项目的文件扩展名。它在文件扩展名的前面包括“.”。  

* $(SolutionDir)  
解决方案的目录（定义形式：驱动器 + 路径）；包括尾部的反斜杠“\”。  

* $(SolutionPath)  
解决方案的绝对路径名（定义形式：驱动器 + 路径 + 基本名称 + 文件扩展名）。  

* $(SolutionName)  
解决方案的基本名称。  

* $(SolutionFileName)  
解决方案的文件名（定义为基本名称 + 文件扩展名）。  

* $(SolutionExt)  
解决方案的文件扩展名。它在文件扩展名的前面包括“.”。  

* $(TargetDir)  
生成的主输出文件的目录（定义形式：驱动器 + 路径）；包括尾部的反斜杠“\”。  

* $(TargetPath)  
生成的主输出文件的绝对路径名（定义形式：驱动器 + 路径 + 基本名称 + 文件扩展名）。  

* $(TargetName)  
生成的主输出文件的基本名称。  

* $(TargetFileName)  
生成的主输出文件的文件名（定义为基本名称 + 文件扩展名）。  

* $(TargetExt)  
生成的主输出文件的文件扩展名。它在文件扩展名的前面包括“.”。  

* $(VSInstallDir)  
安装 Visual Studio .NET 的目录。  

* $(VCInstallDir)  
安装 Visual C++ .NET 的目录。  

* $(FrameworkDir)  
安装 .NET Framework 的目录。  

* $(FrameworkVersion)  
Visual Studio 使用的 .NET Framework 版本。与 $(FrameworkDir) 相结合，就是 Visual Studio 使用的 .NET Framework 版本的完整路径。  

* $(FrameworkSDKDir)  
安装 .NET Framework SDK 的目录。.NET Framework SDK 可作为 Visual Studio .NET 的一部分安装，也可单独安装。  

* $(WebDeployPath)  
从 Web 部署根到项目输出所属于的位置的相对路径。返回与 RelativePath 相同的值。  

* $(WebDeployRoot)  
指向 `<localhost>` 位置的绝对路径。例如，c:\inetpub\wwwroot。  

* $(SafeParentName)  
有效名称格式的直接父级的名称。例如，窗体是 .resx 文件的父级。  

* $(SafeInputName)  
作为有效类名的文件的名称，但不包括文件扩展名。  

* $(SafeRootNamespace)  
项目向导将在其中添加代码的命名空间名称。此命名空间名称将只包含在有效的 C++ 标识符中允许的字符。  

* $(FxCopDir)  
fxcop.cmd 文件的路径。fxcop.cmd 文件不和所有的 Visual C++ 版本一起安装。  

完。
