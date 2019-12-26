---
title: Python日期时间转换
categories:
  - python
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2019-12-26 18:16:15
---
omit
<!--more-->

```python
import time
import datetime
import pytz
# 获取时区信息
print(pytz.country_timezones('us'))
print(pytz.country_timezones('cn'))
tzny = pytz.timezone('America/New_York')
tzsh = pytz.timezone('Asia/Shanghai')
# str转datetime
dt = datetime.datetime.strptime('2006-01-02 15:04:05.123456', '%Y-%m-%d %H:%M:%S.%f')  # yapf: disable
# datetime转str
dt.strftime('%Y-%m-%d %H:%M:%S.%f')
# 转换时区.
dt.replace(tzinfo=tzsh).astimezone(tzny)  # 把dt认定到tzsh时区,再转换到tzny时区.
# datetime转UnixTimestamp
valUnixTime = time.mktime(dt.timetuple())
# UnixTimestamp转datetime
valDateTime = datetime.datetime.fromtimestamp(valUnixTime)
```
目前python代码貌似有BUG：两个时间不是严格的差距12/13小时。
```python
import datetime
import pytz
tzny = pytz.timezone('America/New_York')
tzsh = pytz.timezone('Asia/Shanghai')
print(datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S.%f'))
print(datetime.datetime.now().replace(tzinfo=tzsh).astimezone(tzny).strftime('%Y-%m-%d %H:%M:%S.%f'))  # yapf: disable
```
