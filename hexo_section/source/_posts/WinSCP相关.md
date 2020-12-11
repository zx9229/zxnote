---
title: WinSCP相关
categories:
  - 软件相关
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2020-11-17 09:43:54
---
omit
<!--more-->

[Directory Synchronization :: WinSCP](https://winscp.net/eng/docs/task_synchronize_full)  

![WinSCP_Synchronize](WinSCP_Synchronize.png)  

* Synchronization Direction  

There are three possible directions (targets) of synchronization.  

With Local direction, changes from remote directory (source) are applied to local directory (target). Only the local directory is modified.  
对于`Local`方向，源自远程目录的修改会应用到本地。只有本地目录被修改。  

Remote mode is the same as Local, just in an opposite direction: changes from the local directory (source) are applied to the remote directory (target). Only the remote directory is modified.  

In Both mode, both local and remote directories can be modified (both can act as both source and target).  

* Synchronization Mode  

There are three modes of synchronization.  

With Synchronize files mode, files that are newer in a source directory than in a target directory are transferred to the target directory. Files in the source directory not present in the target directory are by default transferred as well (disable this using the option Existing files only). Files in the target directory not present in the source directory can optionally be deleted (enable option Delete files). In Both mode (see above), files not present in an opposite directory are considered new, hence they are transferred (unless Existing files only is enabled), but never deleted. In other words, in Both mode, no file is ever deleted.  
`Synchronize files`模式时，对于一个文件，如果源目录的文件比目标目录的文件要新，那么它将会被传输到目标目录。对于一个文件，如果源目录中存在文件，目标目录不存在文件，那么默认会将它传输到目标目录（使用选项`Existing files only`禁用这个行为）。对于一个文件，目标目录存在文件，源目录不存在文件，可以选择删除它（使用选项`Delete files`启用这个行为）。当`Synchronization Direction`为`Both`时，对于一个文件，如果对端目录没有这个文件，那么这个文件会被认为是新的，因此这个文件会被传输（除非启用选项`Existing files only`），但是从来不会被删除。换句话说，在`Both`模式下，不会删除任何文件。  

With Mirror files mode, different (both newer and older) files in the source directory are transferred to the target directory. Otherwise the mode is the same as Synchronize files.  
`Mirror files`模式时，对于一个文件，如果源目录里的文件（更新或更旧），那么文件会被传输到目标目录。否则，其行为和`Synchronize files`模式相同。  

With Synchronize timestamps mode, timestamps of target files are updated to match timestamps of source files. It will not do any transfers, nor delete anything. Simply, whenever it finds the same file in both directories, it updates a timestamp of a target file to match the one of a source file. In Both mode, it always updates the older timestamp. The mode is available with SFTP protocol only.  


[Scripting and Task Automation :: WinSCP](https://winscp.net/eng/docs/scripting)  
[Command-line Options :: WinSCP](https://winscp.net/eng/docs/commandline)  
命令`WinSCP.exe /help`查看帮助。  
命令`WinSCP.exe /console /script=C:\winscp_script.txt`可以执行脚本。脚本内容可以如下所示：  
```sh
# https://winscp.net/eng/docs/scriptcommand_open
# open  sftp://用户:密码@主机地址:端口/
open    sftp://root:toor@127.0.0.1:22/
# https://winscp.net/eng/docs/scriptcommand_synchronize
# synchronize local|remote|both [ <local directory> [ <remote directory> ] ]
# 需求<local directory>已创建;
# local: changes from remote directory are applied to local directory.
# local: 远程目录的修改将会应用于本地目录(只有本地目录被修改);
synchronize  -transfer=binary  local  C:\test_sync\.  /root/test_sync/.
# Closes session
close
# Closes all sessions and terminates the program
exit
```
