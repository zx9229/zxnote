---
title: Hexo在project类型的GitHub-Pages-site的使用
categories:
  - Hexo
toc: false
date: 2019-10-06 18:05:14
tags:
---
GitHub一账号多站点的用法。
<!-- more -->

### 思路
我们有一个GitHub账号`zx9229`，我们新建了一个项目/版本库`my_site`，`my_site`有一个分支`gh-pages`，我们往`gh-pages`提交了一个静态网站，那么我们可以通过`http(s)://zx9229.github.io/my_site/`访问这个静态网站。  
相关链接：  
[发布到 GitHub Pages | GitBook 简明教程](http://www.chengweiyang.cn/gitbook/github-pages/README.html)。  
[About GitHub Pages - GitHub Help](https://help.github.com/en/articles/about-github-pages)。  
相关内容：  
User and organization sites are always published from a repository named `<user>.github.io` or `<organization>.github.io`. Unless you're using a custom domain, user and organization sites are available at `http(s)://<username>.github.io` or `http(s)://<organization>.github.io`.  
The source files for a project site are stored in the same repository as their project. Unless you're using a custom domain, project sites are available at `http(s)://<user>.github.io/<repository>` or `http(s)://<organization>.github.io/<repository>`.  
The default publishing source for a project site is the `gh-pages` branch. If the repository for your project site has a `gh-pages` branch, your site will publish automatically from that branch.  

### 步骤

##### 创建版本库
![](create_repository.png)  

##### 克隆版本库
![](clone_with_https.png)  

##### 设置Hexo
```bat
:: 克隆版本库
F:\>git clone https://github.com/zx9229/my_site.git
Cloning into 'my_site'...
...(略)...

F:\>cd my_site\

:: (在hexo_section文件夹里)新建一个网站
F:\my_site>hexo init hexo_section
INFO  Cloning hexo-starter https://github.com/hexojs/hexo-starter.git
Cloning into 'F:\my_site\hexo_section'...
...(略)...

F:\my_site>cd hexo_section

F:\my_site\hexo_section>npm install
...(略)...

:: 安装(hexo-deployer-git)插件
F:\my_site\hexo_section>npm install hexo-deployer-git --save
...(略)...

F:\my_site\hexo_section>
```

##### 配置_config.yml
[hexo-deployer-git/README.md](https://github.com/hexojs/hexo-deployer-git/blob/master/README.md)。  
[资源文件夹 | Hexo](https://hexo.io/zh-cn/docs/asset-folders.html#文章资源文件夹)。  
项目站点在项目路径下。  
要部署到`gh-pages`分支。  
![](配置_config.yml.png)  

##### 生成和提交静态网站
```bat
:: 清除文件(缓存文件和已生成的静态文件等)
F:\my_site\hexo_section>hexo clean
INFO  Deleted database.

:: 生成静态文件
F:\my_site\hexo_section>hexo generate
INFO  Start processing
...(略)...

:: 部署网站
F:\my_site\hexo_section>hexo deploy
INFO  Deploying: git
INFO  Setting up Git deployment...
...(略)...

F:\my_site\hexo_section>
```

##### 访问网址
浏览器访问`https://zx9229.github.io/my_site/`查看结果。  
