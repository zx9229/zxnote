---
title: svn相关的收集贴
categories:
  - 版本控制
  - svn
toc: false
date: 2019-07-19 11:46:38
tags:
---
摘要暂略。
<!-- more -->

#### svn解决冲突
```
[root@localhost mycode]# svn update
...(略)...
Conflict discovered in 'somepath/Makefile'.
Select: (p) postpone, (df) diff-full, (e) edit,
        (mc) mine-conflict, (tc) theirs-conflict,
        (s) show all options: s

  (e)  edit             - change merged file in an editor
  (df) diff-full        - show all changes made to merged file
  (r)  resolved         - accept merged version of file

  (dc) display-conflict - show all conflicts (ignoring merged version)
  (mc) mine-conflict    - accept my version for all conflicts (same)  # 合并内容,冲突的那一部分内容以本地为准.
  (tc) theirs-conflict  - accept their version for all conflicts (same)  # 合并内容,冲突的那一部分内容以服务器为准.

  (mf) mine-full        - accept my version of entire file (even non-conflicts)  # 完全以本地为准.
  (tf) theirs-full      - accept their version of entire file (same)  # 完全以服务器为准.

  (p)  postpone         - mark the conflict to be resolved later
  (l)  launch           - launch external tool to resolve conflict
  (s)  show all         - show this list

Select: (p) postpone, (df) diff-full, (e) edit, (r) resolved,
        (mc) mine-conflict, (tc) theirs-conflict,
        (s) show all options: tf
...(略)...
G    somepath/Makefile
...(略)...
```

#### svn命令行导出某个Revision的文件
```
C:\>svn export --help
export: Create an unversioned copy of a tree.
usage: 1. export [-r REV]   URL[@PEGREV] [PATH]
       2. export [-r REV] PATH1[@PEGREV] [PATH2]
```
例如：`svn export -r 110120 http://localhost:80/repos/my_code/trunk/test.txt C:\.`。  

#### svn update 忽略指定目录
[SVN update 忽略指定文件](https://www.jianshu.com/p/3fda584b0a01)。
```
[root@09b4bf96e3d5 ~]# svn checkout http://localhost:80/repos/my_code
...(略)...
Checked out revision 110120.
[root@09b4bf96e3d5 ~]# cd my_code/
[root@09b4bf96e3d5 my_code]# svn update --set-depth=exclude ./trunk/Solutions/projectA/Release/ ./trunk/Solutions/projectB/ ./trunk/Solutions/projectC/
D         trunk/Solutions/projectA/Release
D         trunk/Solutions/projectB
D         trunk/Solutions/projectC
[root@09b4bf96e3d5 my_code]# svn status
[root@09b4bf96e3d5 my_code]#
```
如果要恢复过来，可以`svn update --set-depth=infinity`。  

#### Working copy ??? locked
![Working_copy_XXX_locked](Working_copy_XXX_locked.png)

#### Create path 和 Apply patch
![Create_path_Apply_patch](Create_path_Apply_patch.png)
