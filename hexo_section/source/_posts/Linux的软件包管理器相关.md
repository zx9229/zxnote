---
title: Linux的软件包管理器相关
categories:
  - Linux
toc: false
date: 2018-11-14 20:46:17
tags:
---
`yum`和`apt-get`对比。
<!-- more -->

#### 搜索软件包
```
yum       search w3m
apt-cache search w3m
apt-cache show   w3m
```

#### 安装 add-apt-repository
`apt-get install software-properties-common` 或者  
`apt-get install software-properties-common python-software-properties`。
