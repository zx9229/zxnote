---
title: autopep8相关
categories:
  - Python
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2020-10-29 13:48:19
---
omit
<!--more-->

[autopep8 · PyPI](https://pypi.org/project/autopep8/)  
[hhatto/autopep8](https://github.com/hhatto/autopep8)  

* 临时禁止修复E501
```python
# E501 - Try to make lines fit within --max-line-length characters.
def fun():
    val = "1234567890abcdefghij1234567890ABCDEFGHIJ1234567890abcdefghij1234567890{}".format('')  # NOQA: E501
    print(val)
```

* 临时禁止修复E402
[vscode写python调用autopep8自动格式化代码把import的顺序换了怎么办?](https://www.zhihu.com/question/365523087/answer/983243706)  
```python
# E402 - Fix module level import not at top of file
import sys
sys.path.insert(0, r'C:/mypkg')
import mypkg  # NOQA: E402
```
