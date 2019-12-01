---
title: shell相关
categories:
  - Linux
  - shell
toc: false
date: 2019-04-23 20:30:17
tags:
---
shell备忘
<!-- more -->

* shell的一些变量
`$*`: 在一个变量中列出所有参数，各个参数用IFS中第一个字符分开。  
`"$*"`: 双引号包裹后等价于`"$1 $2 $3 ..."`。  
`$@`: 是$*的一个变体，不使用IFS，当IFS为空，参数值不会结合在一起。  
`"$@"`: 双引号包裹后等价于`"$1" "$2" "$3" ...`。  
`${@:7}`: 这样将自动识别到的第7个开始，全部获取到作为最后第7个参数。  

* 遍历入参
```shell
for param in "$@"; do
  test -z "${idx}"  &&  idx=0  ||  idx=$(($idx+1))
  echo "idx=${idx}, param=${param}"
done
```
