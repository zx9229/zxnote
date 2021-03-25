---
title: logging相关
categories:
  - Python
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2021-01-15 09:09:54
---
omit
<!--more-->

```python
import logging
import time
import sys

def logging_initialize():
    logFilename = time.strftime('log_%Y%m%d_%H%M%S.log', time.localtime())
    f_handler = logging.FileHandler(logFilename)
    s_handler = logging.StreamHandler()
    # 写代码时发现: filename 和 stream, filename 和 handlers, 不能同时存在;
    # 对于参数 format, 可以参考 help(logging.Formatter)
    logging.basicConfig(format='%(asctime)s %(name)s %(filename)s(%(funcName)s[line:%(lineno)d]) %(levelname)s - %(message)s',
                        datefmt='%Y-%m-%d %H:%M:%S',  # time.strftime('%Y-%m-%d %H:%M:%S', time.localtime())  # 据说,这里的格式化符与time模块相同;
                        level=logging.DEBUG, handlers=[f_handler, s_handler])

def main():
    logging_initialize()
    logging.exception(f"logging_exception", stack_info=sys._getframe().f_back)
    logging.info("DONE")

if __name__ == "__main__":
    main()
```
