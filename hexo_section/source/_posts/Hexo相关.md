---
title: Hexo相关
date: 2018-06-21 19:04:32
categories:
- Hexo
tags:
toc: true
---
Hexo的一些自定义设置。
<!-- more -->

## 启用“文章资源文件夹”  

更多请见：[资源文件夹 | Hexo](https://hexo.io/zh-cn/docs/asset-folders.html)。  
修改`_config.yml`的`post_asset_folder`字段为`true`。  
通过`hexo new [layout] <title>`命令创建新文章时自动创建一个文件夹。  
我们将资源放在这个关联文件夹中之后，可以通过相对路径来引用它们。  
例如，我们创建了一个名为`示例文章`的文章，关联文件夹中放置了`文章配图.png`，那么情况应当如图：
```
_posts
  |--示例文章    <folder>
  |     `-- 文章配图.png
  `--示例文章.md
```
我们可以在文章中用`![图片描述](文章配图.png)`来引用这个资源。  

## hexo-blog-encrypt 插件(弃)  
更多请见：(https://github.com/MikeCoder/hexo-blog-encrypt)。  
它是一个文章加密插件。可以在博客根目录下执行下面命令来安装它：
```
npm install hexo-blog-encrypt --save
```

## 启用搜索(弃)  

打开配置文件`_config.yml`，找到`URL`部分，其内容可能为：  
```
# URL
## If your site is put in a subdirectory, set url as 'http://yoursite.com/child' and root as '/child/'
url: http://yoursite.com
root: /
permalink: :year/:month/:day/:title/
permalink_defaults:
```
应当修改URL的值为自己的博客地址，比如修改成  
```
# URL
## If your site is put in a subdirectory, set url as 'http://yoursite.com/child' and root as '/child/'
url: http://zx9229.github.io
root: /
permalink: :year/:month/:day/:title/
permalink_defaults:
```
你可能需要向谷歌搜索提交自己的网站，或许才能正常使用站内搜索功能。  

## 让创建的文章有一个默认分类。  

在`_config.yml`里搜索`default_layout`并找到其值，然后找到对应的md文件。  
例如它的值是`post`，那么对应的文件是`./scaffolds/post.md`。  
文件的内容可能为：
```
---
title: {{ title }}
date: {{ date }}
tags:
---
```
假如我们想让文章默认到`MyDefaultCategory`这个分类下面。我们可以将其修改成
```
---
title: {{ title }}
date: {{ date }}
categories:
- MyDefaultCategory
tags:
---
```
然后，通过`hexo new [layout] <title>`新建一个文章的话，生成的文件会默认填写这个值，从而被归类。  
分类可以是中文。如果是英文的话，经测试，其大小写是敏感的。  
更多请见：[Front-matter | Hexo](https://hexo.io/zh-cn/docs/front-matter.html#分类和标签)。  
备注，当前`.\scaffolds\post.md`的内容是
```
---
title: {{ title }}
date: {{ date }}
categories: [MyDefaultCategory,]
tags: [MyDefaultTag,]
mathjax: false
toc: false
---
omit
<!--more-->
```

## 为Hexo博客添加目录  

更多请见：[辅助函数（Helpers） | Hexo](https://hexo.io/zh-cn/docs/helpers.html#toc)。  
原作请见：[为Hexo博客添加目录 | The Bloom of Youth | 锦瑟华年](http://kuangqi.me/tricks/enable-table-of-contents-on-hexo/)。  
备份请见：{% post_link 为Hexo博客添加目录 %}。  

## 让landscape支持mathjax
请见：{% post_link Hexo让landscape支持mathjax %}。  
