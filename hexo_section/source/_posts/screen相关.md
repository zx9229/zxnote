---
title: screen相关
categories:
  - Linux
toc: false
date: 2018-11-18 15:53:47
tags:
---
Linux的screen命令。
<!-- more -->

[linux 技巧：使用 screen 管理你的远程会话](https://www.ibm.com/developerworks/cn/linux/l-cn-screen/)。  

#### screen 中的 Ctrl+A
同时按Ctrl和A的操作，我们常记作`Ctrl+A`或`Ctrl+a`，在Linux下也常记作`C-a`或`^A`。  
我们给screen发送命令需要使用特殊的键组合C-a。这是因为我们在键盘上键入的信息是直接发送给当前screen窗口，必须用其他方式向screen窗口管理器发出命令，默认情况下，screen接收以C-a开始的命令。这种命令形式在screen中叫做键绑定(key binding)，C-a叫做命令字符(command character)。

#### 常用命令
```shell
# 查看帮助
screen --help
man screen
在 screen 中先 Ctrl+a 再 ? 可弹出 Screen key bindings 界面
# 创建一个会话(名字为:<pid>.<tty>.<host>)
screen
# 创建一个会话(名字为:sockname)
screen -S sockname
# 分离一个正在运行的会话
screen -d [session]
# 分离当前会话
在 screen 中先 Ctrl+a 再 d 即可分离当前会话
# 结束当前会话
在 screen 中输入 exit 以 terminate 当前会话
# 列出我们的会话
screen -ls
screen -list
# 同(-list)但清理掉那些无法连接的会话
screen -wipe
# 重新连接到一个分离的会话
screen -r [session]
# 如果可能的话就重新连接,否则就创建一个新的会话
screen -R
# 我是否处于screen会话中?
先同时按Ctrl和a，然后松手，再按?，就是同时按Ctrl和/，出现 Screen key bindings 则处于 screen 中
# 我现在哪个screen会话中?
echo $TERM $STY    # 可以试一下,不一定有效
```
