---
title: go.windows-amd64.zip相关
categories:
  - Go
toc: false
date: 2019-07-21 04:43:58
tags:
---
解压版用法。
<!-- more -->

官网：`https://golang.org/`。  
一个压缩包[go1.15.6.windows-amd64.zip](https://dl.google.com/go/go1.15.6.windows-amd64.zip)。  

* 用法
假如我将其解压并匹配到`C:\program_files_zx\go1.15.6.windows-amd64\go\bin\go.exe`，那么应将`C:\program_files_zx\go1.15.6.windows-amd64\go\bin`加入`PATH`。  

* 环境变量
执行以下命令，可以查看环境变量相关信息:
```
go      env
go help env
go help environment
```

* 需要安装一些工具(临时记录)
可以用VSCode打开一个`test.go`文件，然后编辑器会提示你安装东西的。
```
The "go-outline" command is not available. Run "go get -v github.com/ramya-rao-a/go-outline" to install.
The "goreturns" command is not available. Run "go get -v github.com/sqs/goreturns" to install.
The "godef" command is not available. Run "go get -v github.com/rogpeppe/godef" to install.
The "gocode-gomod" command is not available. Run "go get -v github.com/stamblerre/gocode" to install.
The "dlv" command is not available. Run "go get -v github.com/go-delve/delve/cmd/dlv" to install.
The "gopls" command is not available. Run "go get -v golang.org/x/tools/gopls" to install.
```

* GOPROXY相关
[Go proxy 设置 - 简书](https://www.jianshu.com/p/99aa7522c746)。  
从`go env`或`go env GOPROXY`可知，默认`GOPROXY=https://proxy.golang.org,direct`。  
命令`go help env`可知，设置的大概命令应该是`go env -w NAME=VALUE`。  
执行`go env -w GOPROXY=https://goproxy.cn,direct`。  

* 临时记录
不带任何参数执行`plink.exe`程序，可以查看简要说明。  
```
ssh [-1246AaCfgKkMNnqsTtVvXxYy] [-b bind_address] [-c cipher_spec]
    [-D [bind_address:]port] [-e escape_char] [-F configfile]
    [-I pkcs11] [-i identity_file]
    [-L [bind_address:]port:host:hostport]
    [-l login_name] [-m mac_spec] [-O ctl_cmd] [-o option] [-p port]
    [-R [bind_address:]port:host:hostport] [-S ctl_path]
    [-W host:port] [-w local_tun[:remote_tun]]
    [user@]hostname [command]

[-L [bind_address:]port:host:hostport]
ssh_client与ssh_server成功建立连接，
ssh_client，会监听ssh_client所在机器的【[bind_address:]port】，
有程序连接了【[bind_address:]port】，ssh_client会通知ssh_server，让ssh_server连接【host:hostport】

[-R [bind_address:]port:host:hostport]
ssh_client与ssh_server成功建立连接，
ssh_client通知ssh_server，让ssh_server监听ssh_server所在机器的【[bind_address:]port】，
有程序连接了【[bind_address:]port】，ssh_server会通知ssh_client，让ssh_client连接【host:hostport】
```
代码目录可参考`go help gopath`。  
`C:\Users\admin\go\src\my_code\my_project\test.go`。  

* go mod download
下载modules到本地cache。  
目前所有模块版本数据均缓存在 $GOPATH/pkg/mod和 ​$GOPATH/pkg/sum 下  
疑似执行`go mod download`可以更新把`go.mod`的依赖搞下来。  

```
C:\> plink.exe
Plink: command-line connection utility
Usage: plink [options] [user@]host [command]
       ("host" can also be a PuTTY saved session name)
Options:
  -P port   connect to specified port
  -l user   connect with specified username
The following options only apply to SSH connections:
  -pw passw login with specified password
  -D [listen-IP:]listen-port
            Dynamic SOCKS-based port forwarding  (基于SOCKS的动态端口转发)
  -L [listen-IP:]listen-port:host:port
            Forward local port to remote address (转发本地端口到远程地址)
  -R [listen-IP:]listen-port:host:port
            Forward remote port to local address (转发远程端口到本地地址)
  -C        enable compression
  -N        don't start a shell/command (SSH-2 only)

远端运行着sshServer, sshServer的信息是主机8.8.8.8端口20022用户root密码toor
远端有一台机器是127.0.0.1上面运行着MySQL默认端口3306
本地有一台机器是localhost上面运行着Oracle默认端口1521
连接到远端然后执行pwd命令:
plink.exe    root@8.8.8.8 -P 20022 -pw toor        pwd
plink.exe连接到sshServer, plink.exe监听localhost:61080, 进行代理:
plink.exe -N root@8.8.8.8 -P 20022 -pw toor -D localhost:61080
plink.exe连接到sshServer, plink.exe监听localhost:63306, 有人连接到plink.exe监听的localhost:63306, 就让sshServer连接到127.0.0.1:3306
plink.exe -N root@8.8.8.8 -P 20022 -pw toor -L localhost:63306:127.0.0.1:3306
plink.exe连接到sshServer, sshServer监听127.0.0.1:61521, 有人连接到sshServer监听的127.0.0.1:61521, 就让plink.exe连接到localhost:1521
plink.exe -N root@8.8.8.8 -P 20022 -pw toor -R 127.0.0.1:61521:localhost:1521
```
