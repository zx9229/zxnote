---
title: Hexo的一些偏好设置
categories:
  - Hexo
tags:
  - MyDefaultTag
mathjax: false
toc: true
date: 2017-07-31 23:59:59
---
Hexo的一些自定义的偏好设置。  
<!--more-->


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

## 让创建的文章有一个默认分类  

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

## 使用其他theme  

下载某theme到根目录下的`./themes/.`下，然后修改theme的名字到对应的名字即可。  
```yml
# Extensions
## Plugins: https://hexo.io/plugins/
## Themes: https://hexo.io/themes/
theme: landscape
```


## 部署到GitHub  
[将 Hexo 部署到 GitHub Pages | Hexo](https://hexo.io/zh-cn/docs/github-pages#Project-page)，  
假如，GitHub上有一个Owner是`zhangsan`，其下有个Repository是`hexo_demo_repo`。那么：  
打开配置文件`_config.yml`，找到`Deployment`部分，其内容可能为：  
```yml
# Deployment
## Docs: https://hexo.io/docs/one-command-deployment
deploy:
  type: ''
```
我们要将静态文件上传到指定版本库的`gh-pages`分支，所以，应当将其修改成：  
```yml
# Deployment
## Docs: https://hexo.io/docs/one-command-deployment
deploy:
  type: 'git'
  repo: https://github.com/zhangsan/hexo_demo_repo.git
  branch: gh-pages
```
打开配置文件`_config.yml`，找到`URL`部分，其内容可能为：  
```yml
# URL
## If your site is put in a subdirectory, set url as 'http://example.com/child' and root as '/child/'
url: http://example.com
root: /
```
因为Github上的Repository的名字是`hexo_demo_repo`，所以将其修改为：
```yml
# URL
## If your site is put in a subdirectory, set url as 'http://example.com/child' and root as '/child/'
url: http://example.com/hexo_demo_repo
root: /hexo_demo_repo/
```

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
