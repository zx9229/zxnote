---
title: vnpy相关
categories:
  - MyDefaultCategory
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2020-08-03 10:27:17
---
omit
<!--more-->

[GitHub - vnpy/vnpy: 基于Python的开源量化交易平台开发框架](https://github.com/vnpy/vnpy)，  
[Releases · vnpy/vnpy · GitHub](https://github.com/vnpy/vnpy/releases)，  
[vn.py量化社区 - By Traders, For Traders.](https://www.vnpy.com/)，  
[CTA策略模块](https://www.vnpy.com/docs/cn/cta_strategy.html)，  

* 策略示例  
程序根目录下`vnpy\app\cta_strategy\strategies`文件夹内应该有`double_ma_strategy.py`，里面有一个类`DoubleMaStrategy`就是交易策略的名字，  

* vt_symbol
`vt_symbol`:`本地代码`，可以`合约查询`看到。  

* 回测数据  
`配置`>`全局配置`里面可以配置回测用途的数据来源。  
可以配置`sqlite`然后观察数据库里面的数据表，其中`dbbardata`.`interval`
```python
class Interval(Enum):
    """
    Interval of bar data.
    """
    MINUTE = "1m"
    HOUR = "1h"
    DAILY = "d"
    WEEKLY = "w"
```

* test
例如`class DoubleMaStrategy(CtaTemplate):`可以在源码里搜索`CtaTemplate`应该能找到`vnpy\app\cta_strategy\template.py`里面有`class CtaTemplate(ABC):`的定义，然后就可以查看这个类有哪些接口，以及接口的说明了。  
文档`docs\cta_strategy.md`或许有点用处。  
