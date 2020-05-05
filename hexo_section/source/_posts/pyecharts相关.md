---
title: pyecharts相关
categories:
  - Python
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2020-05-06 00:41:13
---
omit
<!--more-->

[pyecharts - A Python Echarts Plotting Library](http://pyecharts.org/)，  

* 怎么样让K线图既有滑块又能缩放?  
[K 线图 Candlestick - Document](http://gallery.pyecharts.org/#/Candlestick/README)，  
```python
pyecharts.charts.Kline().add_xaxis(xaxis_data=dataX).add_yaxis(series_name='', y_axis=dataY,
).set_global_opts(datazoom_opts=[
    pyecharts.options.DataZoomOpts(type_="slider", orient="horizontal"),  # 水平滑动条,
    pyecharts.options.DataZoomOpts(type_="slider", orient="vertical"),  # 垂直滑动条,
    pyecharts.options.DataZoomOpts(type_="inside"),  # 鼠标滚轮可缩放,
]).render()
```
