---
title: BinaryTree二叉树
categories:
  - MyDefaultCategory
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2021-03-23 16:23:27
---
omit
<!--more-->

* 满二叉树
```
x                               (第k-2层)
x               x               (第k-1层)
x       x       i(m)    x       (第k  层)
x   x   x   x   iL  iR  x   x   (第k+1层)

节点i在第k层
节点i在当前层的序号为i
节点i的left是iL, right是iR
节点iL在自己的那一层的序号是`2*i`
节点iR在自己的那一层的序号是`2*i+1`
节点i的全局序号为m
第k层上面共有节点`2**k-1`个
第k层的第一个元素的序号为`2**k-1`
m = 2**k - 1 + i

第k+1层上面共有节点`2**(k+1)-1`个
节点iL的全局序号为`2**(k+1)-1 + 2*i = 2**k + 2**k - 1 + i + i - 1 + 1`是`2*m + 1`
节点iR的全局序号为`2*m + 1 + 1`是`2*m + 2`

所以 2m+1 和 2m+2 的 父节点 是 m
floor((2m+1 - 1)/2) = m
floor((2m+2 - 1)/2) = m
所以m的父节点是floor((m - 1)/2)
```
