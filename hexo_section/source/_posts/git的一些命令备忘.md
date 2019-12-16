---
title: git的一些命令备忘
categories:
  - 版本控制
  - git
toc: false
date: 2018-07-09 23:04:13
tags:
---
摘要暂略。
<!-- more -->

* 查看帮助  
```
git --help
git stash --help
git rebase --help
git commit --help
git checkout --help
git <command> --help
```
* 查看当前状态  
`git status`

* 查看版本库上的文件  
`git ls-files`

* 查看版本库上(某目录下)的文件  
`git ls-files 某目录`

* 查看提交信息
`git log`或`git log --graph`。

* 查看(某目录/某文件的)提交信息  
`git log 某目录`  
`git log 某文件`

* 查看两个版本之间变更了哪些文件  
`git diff HEAD     HEAD~1   --name-status` : 当前版本和上一版本之间变更了哪些文件。  
`git diff HEAD~1   HEAD~2   --stat`        : 上一版本和上二版本之间变更了哪些文件。  
`git diff commit_1 commit_2 --name-status` : 某一提交和某二提交之间变更了哪些文件。  
举例：  
我某次进行了一次提交(SHA-1: db22a3632a79c0b235530d025924e657809eb0ab)，一段时间之后，又进行了一次提交(SHA-1: 8844f9ecad53386cfd7b63e708242bb555b2163c)，我想查看这两个版本号之间变更了哪些文件，需执行命令：`git diff db22a3 8844f9 --name-status`

* 查看查看某版本号增删改了哪些文件
`git show REVISION --stat`或`git show REVISION`。  
某次提交是`commit 10b71b4b74d247fa9ac934082dcad0c57de27dd2`，则命令可以是`git show 10b71b4b --stat`。  

* 查看某版本号时某文件的全部内容  
`git show REVISION:./path/to/file`  
举例：  
假设某文件为`test_file`，其路径为`./dir/test_file`，很早就把它提交到git上，很久没有改动过它了。我最近进行了一次提交(SHA-1: db22a3632a79c0b235530d025924e657809eb0ab)，我想查看这一版本时候的`test_file`的全部内容，需执行命令：`git show db22a3:./dir/test_file`

* 查看某版本号对某文件做了哪些修改  
`git show REVISION ./path/to/file`  
举例：  
假设某文件为`test_file`，其路径为`./dir/test_file`，我最近进行了一次提交(SHA-1: db22a3632a79c0b235530d025924e657809eb0ab)，这次提交对`test_file`和一些其他文件一并进行了修改，我想看一下这次提交对`test_file`做了哪些修改，需执行命令：`git show db22a3 ./dir/test_file`

* <span style="color:blue;">鼠标操作TortoiseGit对某文件执行Revert操作</span>  
`git checkout HEAD </path/to/your/file>`  
据说推荐`<span style="color:red;">这是比font标签更好的方式。可以试试。</span>`而不推荐`<font color=red>内容</font>`。

* 对某文件执行Revert操作  
`git checkout 文件名`  
以下随手摘录同时未经确认：  
一种是readme.txt自修改后还没有被放到暂存区，现在，撤销修改就回到和版本库一模一样的状态；  
一种是readme.txt已经添加到暂存区后，又作了修改，现在，撤销修改就回到添加到暂存区后的状态。  
总之，就是让这个文件回到最近一次git commit或git add时的状态。

* 恢复单个文件到指定版本  
`git checkout <sha1-of-a-commit> </path/to/your/file>`  
备注：它好像对应的是帮助文档中的`git checkout [-p|--patch] [<tree-ish>] [--] <pathspec>…`。

* 查看所有分支  
`git branch  -a`或`git branch -av`或`git branch -avv`  
`git branch --all`

* 删除REPO上的文件同时保留本地文件
`git rm --cached 文件名`
