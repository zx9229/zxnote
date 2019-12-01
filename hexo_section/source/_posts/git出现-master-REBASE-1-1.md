---
title: git出现(master|REBASE 1/1)
categories:
  - git
toc: false
date: 2019-09-23 11:21:44
tags:
---
`git出现(master|REBASE 1/1)`
<!-- more -->

* `git status`  
显示工作树的状态。  

* `git --help rebase`  
查看帮助。  

* `git rebase --continue`  
`(all conflicts fixed: run "git rebase --continue")`：  
修复了所有冲突之后，执行`git rebase --continue`。  

* `git rebase --abort`  
`To abort and get back to the state before "git rebase", run "git rebase --abort".`：  
要终止并返回到"git rebase"之前的状态，请执行`git rebase --abort`。  

* `git --help stash`  
查看帮助。  

* `git stash list`  
`List the stash entries that you currently have.`。  
列出你当前拥有的存储项。  

* 八进制转义序列转中文
[python-8进制转换为汉字（utf-8）](https://blog.csdn.net/CD2016/article/details/81358612)。  
python3下执行`b"\346\224\266\351\233\206\350\264\264.md".decode('UTF-8')`。  
附送：python3下执行`print( bytes.fromhex('090D0A') )`有惊喜。  
附送：python3下执行`print( binascii.a2b_hex('090D0A') )`有惊喜，不过要先`import binascii`。  

* 解决冲突步骤
[用rebase合并【教程1 操作分支】](https://backlog.com/git-tutorial/cn/stepup/stepup2_8.html)。  
`git status`查看哪些文件冲突了。  
`git diff 某冲突文件名`预览某文件的冲突情况。  
`右键某冲突文件名`>`TortoiseGit`>`Edit conflicts`>`手工解决冲突`。  
`git add 某冲突文件名`。  
`git rebase --continue`。  
