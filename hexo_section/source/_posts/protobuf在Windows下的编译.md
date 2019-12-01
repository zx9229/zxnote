---
title: protobuf在Windows下的编译
categories:
  - Go
toc: false
date: 2019-01-05 17:55:56
tags:
---
在Windows下编译protobuf给Qt_for_MSVC、Qt_for_MinGW、Qt_for_Android用。
<!-- more -->

* Qt编译protobuf
其实是：使用Qt自带的MinGW编译器，为C++语言，编译出protobuf的链接库。  
我们需要安装Qt和Git。在安装时，需要注意其安装路径（不要有空格等特殊字符）。  
比如：Git的路径尽量为`C:\Program_Files_x86\Git`而非`C:\Program Files (x86)\Git`。  
假定我安装了Git(相关路径为`C:\Program_Files_x86\Git\cmd`)和Qt(相关路径`C:\Qt\Qt5.12.3\Tools\mingw730_32\bin`)，将它们加入系统变量`Path`，  
且将它们放到Path的最前面，这样从Path目录寻找程序时，可以确保使用了该目录下的程序。  
并`xcopy C:\Qt\Qt5.12.3\Tools\mingw730_32\bin\mingw32-make.exe C:\Qt\Qt5.12.3\Tools\mingw730_32\bin\make.exe`。  
然后可以按照`https://github.com/protocolbuffers/protobuf`的步骤进行编译。  
实际上是按照`https://github.com/protocolbuffers/protobuf/blob/master/src/README.md`的步骤进行编译。  
实际上从步骤`./configure`开始执行就可以了。它可能生成`libprotobuf.a`文件。  
它只需要编译谷歌发布的源文件，你自己的proto文件生成的代码，是不需要在这里编译的。  

* MinGW编译protobuf
同上。  

* MSVC编译protobuf
[protobuf的编译和使用，在windows平台上](https://blog.csdn.net/hp_cpp/article/details/81561310)。  

* NDK编译protobuf给Android用
[protobuf 交叉编译笔记](https://www.cnblogs.com/UniqPtr/p/7859758.html)。  
我们需要安装NDK和CMake。然后就可以在任意目录开始编译。  
NDK(Native Development Kit)是Android的一个工具开发包。NDK是属于Android的，与Java并无直接关系。  
NDK相关的几个链接：  
`https://developer.android.com/`  
`https://developer.android.com/ndk/downloads/`  
`https://developer.android.google.cn/ndk/downloads/`  
`https://dl.google.com/android/repository/android-ndk-r16b-windows-x86.zip`  
`https://dl.google.com/android/repository/android-ndk-r16b-windows-x86_64.zip`  
```
mkdir build && cd build
cmake -G "MinGW Makefiles" ^
    -DCMAKE_TOOLCHAIN_FILE=<Your_NDK_PATH>/build/cmake/android.toolchain.cmake ^
    -DCMAKE_MAKE_PROGRAM=<Your_NDK_PATH>/prebuilt/windows-x86_64/bin/make.exe ^
    -Dprotobuf_BUILD_TESTS=OFF ^
    <Protobuf_source_PATH>/cmake
cmake --build . --target libprotobuf
cmake --build . --target libprotobuf-lite
```
`CMAKE_TOOLCHAIN_FILE`，这个变量指定了`cmake`使用的`toolchain`脚本，`toolchain`脚本会帮助配置交叉编译使用的头文件/库文件路径，配置编译器/链接器等一系列工具。  
`CMAKE_MAKE_PROGRAM`，这个变量指定了`cmake`使用的`make`程序，如果系统的`PATH`中没有`make.exe`的话（通常也不会有，除非安装了`MinGW`并且配置了`PATH`环境变量），就需要指定使用的`make.exe`程序。这里使用了`ndk`自带的`prebuilt`版`make.exe`。  
`protobuf_BUILD_TESTS`，不要编译测试用例，这一选项默认启用，但在交叉编译时会导致奇怪的问题。  
`-G "MinGW Makefiles"`，指定`cmake`生成`MinGW Makefile`，即一般所说的`Makefile`。  
