---
title: grep相关
categories:
  - Linux
toc: false
date: 2019-07-22 19:21:07
tags:
---
略。
<!-- more -->

* 搜索原始字符串
[Linux fgrep Command Tutorial for Beginners (with Examples)](https://www.howtoforge.com/linux-fgrep-command/)。  
```
-F, --fixed-strings       PATTERN is a set of newline-separated fixed strings
grep -F "原始字符串" filename
```

* 使用正则表达式
`grep -o -E '66097218[^,]+,([^,]+,){4}' 20190913_befortrade.dmp`
