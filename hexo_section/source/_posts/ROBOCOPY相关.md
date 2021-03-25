---
title: ROBOCOPY相关
categories:
  - Windows
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2021-03-23 16:18:05
---
omit
<!--more-->

* 查看帮助
`ROBOCOPY /?`

* 常用参数
```
用法 :: ROBOCOPY source destination [file [file]...] [options]

      /S :: 复制子目录，但不复制空的子目录。
      /E :: 复制子目录，包括空的子目录。
/COPYALL :: 复制所有文件信息(等同于 /COPY:DATSOU)。
  /PURGE :: 删除源中不再存在的目标文件/目录。
    /MIR :: 镜像目录树(等同于 /E 加 /PURGE)。
    /ETA :: 显示复制文件的预期到达时间。

示例
ROBOCOPY  K:\data2\op_gf_shfe\marketdata\daily_raw  J:\A1\data2\op_gf_shfe\marketdata\daily_raw  /E /COPYALL /ETA
```
