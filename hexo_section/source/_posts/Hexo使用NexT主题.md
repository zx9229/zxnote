---
title: Hexo使用NexT主题
categories:
  - MyDefaultCategory
tags:
  - MyDefaultTag
mathjax: false
toc: false
date: 2019-10-11 19:18:29
---
omit
<!--more-->

* 主题的网址
[Themes | Hexo](https://hexo.io/themes/)。  
[theme-next/hexo-theme-next](https://github.com/theme-next/hexo-theme-next)。  

* 安装
[docs/zh-CN/INSTALLATION.md](https://github.com/theme-next/hexo-theme-next/blob/master/docs/zh-CN/INSTALLATION.md)。  

* 数学公式
[docs/zh-CN/MATH.md](https://github.com/theme-next/hexo-theme-next/blob/master/docs/zh-CN/MATH.md)。  
[Hexo的多种Markdown渲染器对比分析](https://bugwz.com/2019/09/17/hexo-markdown-renderer/)。  
[Pandoc - Pandoc User’s Guide](https://pandoc.org/MANUAL.html#pandocs-markdown)。  
对于`hexo-renderer-pandoc`和`hexo-renderer-kramed`，我选择`hexo-renderer-kramed`。因为：  
`hexo-renderer-pandoc`需要先安装`pandoc`。  
`hexo-renderer-pandoc`据说对Mathjax语法进行了扩展。书写 Markdown 时需要遵循 Pandoc 对 Markdown 的规定。  
`hexo-renderer-kramed`是基于`hexo-renderer-marked`二次开发的渲染器，完善了对Mathjax的支持。  
`hexo-renderer-marked`是稳定更新的，`hexo-renderer-kramed`的作者不干了的话，个人应该有能力整合它。  
`npm uninstall hexo-renderer-marked --save`。  
`npm   install hexo-renderer-kramed --save`。  
