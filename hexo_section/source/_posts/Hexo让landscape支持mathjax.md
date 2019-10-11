---
title: Hexo让landscape支持mathjax
categories:
  - MyDefaultCategory
tags:
  - MyDefaultTag
mathjax: true
toc: false
date: 2019-10-11 18:45:54
---
omit
<!--more-->

#### 思路
[针对中国大陆地区对hexo官方主题landscape进行优化](https://github.com/xiangming/landscape-plus)。  
`landscape-plus`：针对中国大陆的hexo用户，优化hexo官方主题landscape。新增mathjax模块。  
我们可以将`landscape-plus`中的`mathjax`模块取出来，人工并入`landscape`中。  

#### 找出mathjax相关的代码
在`landscape-plus`的根目录执行`grep -irl 'mathjax' ./.`可以找到相关文件。  
用`Beyond Compare`对比`landscape-plus`和`landscape`的文件，可以找到相关的差异。  

#### 让landscape支持mathjax
将`./themes/landscape-plus/layout/_partial/mathjax.ejs`拷贝到`landscape`的对应目录下。  
将`./themes/landscape-plus/layout/_partial/after-footer.ejs`里面涉及`mathjax`的部分合并到`landscape`的对应文件中。  
将`./themes/landscape-plus/_config.yml`的`mathjax: true`配置合并到`landscape`的对应文件中。  
其中，修改`after-footer.ejs`添加：
```html
<!--如果"hexo的_config.yml"或"theme的_config.yml"配置了`mathjax: true`
    并且"page has `mathjax: true` in Front-matter"
    那么使用"mathjax.ejs"-->
<% if (((config.mathjax || theme.mathjax) && page.mathjax)){ %>
<%- partial('mathjax') %>
<% } %>
```

* 杂  
保持默认的`hexo-renderer-marked`就行，无需更换到`hexo-renderer-kramed`。  
执行`npm install mathjax --save`将会生成`./node_modules/mathjax`文件夹。  
[mathjax - npm](https://www.npmjs.com/package/mathjax)。  
[](https://github.com/mathjax/MathJax-src/archive/master.zip)。  
[](https://github.com/mathjax/MathJax/archive/master.zip)。  

* mathjax  
[在线 Markdown MathJax 编辑器](https://kerzol.github.io/markdown-mathjax/editor.html)。  
[MathJax Documentation — MathJax 3.0 documentation](http://docs.mathjax.org/en/latest/index.html)。  
[MathJax 中文文档 — MathJax Chinese Doc 2.0 documentation](https://mathjax-chinese-doc.readthedocs.io/en/latest/)。  
[maths-symbols.pdf](http://mirrors.sjtug.sjtu.edu.cn/ctan/info/symbols/math/maths-symbols.pdf)。  
[Markdown MathJax 公式](https://www.rdtoc.com/tutorial/markdown-mathjax-tutorial.html)。  
[Markdown LaTeX 数学符号速查表](https://www.rdtoc.com/tutorial/markdown-latex-tutorial.html)。  

* 数学公式示例  
$ E = mc^2 $  
$ V = \frac{4}{3} \pi R^3 $  
$ log _a (M \bullet N) = log _a M + log _a N $  
$ log _a \frac{M}{N} = log _a M - log _a N $  
$ log _a M^n = n log _a M $  
$ log _{a^n} M = \frac{1}{n} log _a M $  
$ log _a b = \frac{log _c b}{log _c a} $  
$ log _a b = \frac{1}{log _b a} $  
