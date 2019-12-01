---
title: 安装Go并用VSCode配置Go开发环境
date: 2017-11-19 20:58:18
categories:
- Go
tags:
toc: false
---
安装Go。配置GOPATH。VSCode设置代理。使用代理安装Go的插件。  
<!-- more -->

## 安装Go和常用依赖
Go的官网：[The Go Programming Language](https://golang.org/)。  
在Windows下，我们可以下载最新版的安装包(2019-01-25是`go1.11.5.windows-amd64.msi`)并安装它。  
它一般会默认安装到`C:\Go\`下。  
它会自动创建系统变量`GOROOT`并指向`C:\Go\`。  
创建用户变量`GOPATH`并指向`%USERPROFILE%\go\`。  
然后我们可以`mkdir %USERPROFILE%\go\src\my_code`然后在`my_code`里面写代码并测试等。  

### 安装git/svn/hg/bzr等
建议至少安装Git(`Git for Windows`，名字类似`Git-2.20.1-64-bit.exe`的安装包)。  
[Installing Version Control Tools for `go get`](https://golang.org/s/gogetcmd)。  
安装Git的时候，请尽量安装到`C:\Program_Files_x64\Git`等不含特殊字符(空格、括号、等)的目录下。  

### 关于GOPATH用户变量
查看变量：`go env GOPAHT`。查看帮助：`go help gopath`。  
一个设置`GOPATH`的用户变量的命令：`SETX GOPATH %USERPROFILE%\go;D:\Go_GOPATHd`。  
当有多个`GOPATH`时默认将`go get`获取的包存放在第一个目录下。  
例如：我们在"命令行提示"(`command-line prompt(cmd.exe)`)里执行`go get -u -v github.com/cw1997/NATBypass`之后，会发现它们出现在`%USERPROFILE%\go`路径下面。  
极度建议`GOPATH`的第一个目录是`%USERPROFILE%\go`。比如，用`protoc.exe`生成`grpc`的代码时，如果第一个目录不是`%USERPROFILE%\go`可能出现异常。  
如果不想将文件放到C盘，而是选择放到`D:\Go_GOPATHc\`，那么可以：创建文件夹&&创建软链接：  
`MKDIR D:\Go_GOPATHc\  &&  MKLINK /J  %USERPROFILE%\go\  D:\Go_GOPATHc\`。  

## 为VSCode配置Go开发环境  
思路：用VSCode打开一个后缀为go的文件，然后VSCode会自动推荐一些插件，然后择需安装即可。  

### 安装VSCode
最新(2019-01-25)的Windows的`System Installer`是`VSCodeSetup-x64-1.30.2.exe`。我们可以安装它。  

### 安装Go插件  
创建一个后缀为go的文件(比如test.go)并用VSCode打开。此时它会自动推荐一些插件。  
如无意外，它会推荐一个插件，该插件的名字是"Go"，简介(shortDesc)是"Rich Go language support for Visual Studio Code"。  
这个插件我用着不错，也推荐你安装它。  

### 安装插件的依赖程序(用VSCode自动安装)
在"test.go"里面随便敲几个字，你应该会看到弹窗提示，提示里应该有"Install All"，你可以"Install All"解决。  
因为部分依赖程序需要设置代理才能正常安装，所以我们可能需要给VSCode设置代理。  
假定我们的代理端口位于本机的1080端口，那么可以如下设置：  
`VSCode`=>`文件`=>`首选项`=>`设置`=>`搜索"http.proxy"`=>`填写"http://localhost:1080/"`。  
如果你想让VSCode重新弹出"Install All"的提示，你可以删除/重命名`%USERPROFILE%\go\bin`文件夹，然后你应当能达到目的。  
<label style="color:red">**如果在VSCode里安装`dlv`失败，可以进入其官网，找到安装命令，尝试手动在cmd里人工安装它，应当能成功，我也不知道为什么。**</label>  

### 安装插件的依赖程序(手动安装)  
预备知识：  
用"go get --help"可以查看详细帮助信息。其中：  
-u表示强制使用网络去更新包和它的依赖包。  
-v表示启用详细的进度和调试输出。  

#### 安装dlv.exe  
在VSCode下按F5启动调试时，会提示：  
`Failed to continue: "Cannot find Delve debugger. Install from https://github.com/derekparker/delve & ensure it is in your "GOPATH/bin" or "PATH"."`  
查看它在github上面的"README.md"文件，可以知道，使用命令`go get -u -v github.com/derekparker/delve/cmd/dlv`以安装它。  

#### 安装goreturns.exe  
在VSCode中按"Alt+Shift+F"(自动格式化代码)时，会提示：  
`The "goreturns" command is not available. Use "go get -v github.com/sqs/goreturns" to install.`  
使用命令`go get -u -v github.com/sqs/goreturns`以安装它(可能需要翻墙)。  

#### 安装其他依赖程序
过程与上面类似，不再赘述。  

## 用代理方法安装软件  
有些软件需要使用代理，才能安装成功，下面是一种代理的方式。  

### 预备知识(Windows相关)  
本例中，"某环境变量名"是"MY_ENV_NAME"，"某个值"是"This is a value"。  
1. 所有的在cmd命令行下对环境变量的修改只对当前窗口有效，不是永久性的修改。也就是说当关闭此cmd命令行窗口后，将不再起作用。  
2. 在cmd下查看某环境变量("set MY_ENV_NAME")。  
3. 在cmd下设置/修改某环境变量到某个值("set MY_ENV_NAME=This is a value")。  
4. 在cmd下删除某环境变量("set MY_ENV_NAME=")。  

### 预备知识(git相关)  
git是可以允许代理服务器的。假定我们的HTTP(S)代理服务的IP端口为"127.0.0.1:1080"。  
1. 查看git的代理相关设置("git config --get-regexp .*proxy")。  
2. 设置git的代理相关设置("git config --global  http.proxy http://127.0.0.1:1080")。  
3. 设置git的代理相关设置("git config --global https.proxy http://127.0.0.1:1080")。  
4. 取消git的代理相关设置("git config --global --unset  http.proxy")。  
5. 取消git的代理相关设置("git config --global --unset https.proxy")。  

### 使用代理安装软件的步骤  
备注：代理部分参考了[go get 获得 golang.org 的项目](https://www.cnblogs.com/ghj1976/p/5087049.html)。  
安装goreturns的命令(`go get -u -v sourcegraph.com/sqs/goreturns`)，使用代理安装的步骤如下：  

#### 使用Lantern(蓝灯)作为代理  
我假定你的机器安装了Lantern(蓝灯)。查看它的"HTTP(S)代理服务器"的地址，我的是"127.0.0.1:30888"。  
0. 打开cmd。所有的操作都在本cmd下。敏感操作都是先改过去，再改回来。  
1. 查看Windows的"http_proxy"环境变量名(`set http_proxy`)。  
2. 设置Windows的"http_proxy"环境变量名(`set http_proxy=http://127.0.0.1:30888`)。  
3. 查看Windows的"http_proxy"环境变量名，以确认设置。  
4. 查看git的代理相关设置(`git config --get-regexp .*proxy`)。  
5. 设置git的代理相关设置(`git config --global http.proxy http://127.0.0.1:30888`)。  
6. 查看git的代理相关设置(`git config --get-regexp .*proxy`)，以确认设置。  
7. 执行命令(`go get -u -v sourcegraph.com/sqs/goreturns`)。  
8.  删除git的代理相关设置(`git config --global --unset http.proxy`)。  
9. 删除Windows的"http_proxy"环境变量名(`set http_proxy=`)。  

#### 使用Shadowsocks(影梭)作为代理  
我假定你的机器运行了Shadowsocks客户端，并能正常使用。查看它的"代理端口"的值，一般情况下是1080。  
0. 打开cmd。所有的操作都在本cmd下。敏感操作都是先改过去，再改回来。  
1. 查看Windows的"http_proxy"环境变量名(`set http_proxy`)。  
2. 设置Windows的"http_proxy"环境变量名(`set http_proxy=http://127.0.0.1:1080`)。  
3. 查看Windows的"http_proxy"环境变量名，以确认设置。  
4. 查看git的代理相关设置(`git config --get-regexp .*proxy`)。  
5. 设置git的代理相关设置(`git config --global http.proxy http://127.0.0.1:1080`)。  
6. 查看git的代理相关设置(`git config --get-regexp .*proxy`)，以确认设置。  
7. 执行命令(`go get -u -v sourcegraph.com/sqs/goreturns`)。  
8.  删除git的代理相关设置(`git config --global --unset http.proxy`)。  
9. 删除Windows的"http_proxy"环境变量名(`set http_proxy=`)。  
