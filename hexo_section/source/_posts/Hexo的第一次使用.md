---
title: Hexo的第一次使用
date: 2017-07-08 00:09:45
categories:
- Hexo
tags:
toc: false
---
从一个什么都不知道的小白，到部署网站到GitHub，所需的全部操作。  
<!-- more -->

假使你的机器是Windows，你准备使用Hexo。  
建议你访问`https://hexo.io/zh-cn/`以学习Hexo。  
这篇文章是我写了给自己看的。  
下面是第一次使用Hexo的步骤。  

## 在本地配置Hexo环境  

1. 安装Git  

在Windows下安装Git其实是安装的`Git for Windows`。  
Git官网：https://git-scm.com/  
Git for Windows：https://gitforwindows.org/  

2. 为Git配置一个全局的name和email  

假定我的name是`zhangsan`，email是`zhangsan@163.com`。  
打开`Git Bash`，执行以下命令：  
```shell
USERNAME@MACHINE_NAME MINGW64 ~
$ git config --global user.email "zhangsan@163.com"

USERNAME@MACHINE_NAME MINGW64 ~
$ git config --global user.name "zhangsan"

USERNAME@MACHINE_NAME MINGW64 ~
$
```

3. 安装TortoiseGit  

TortoiseGit官网：https://tortoisegit.org/  

4. 安装Node.js  

Node.js官网：https://nodejs.org/en/  
`nvm does not support Windows`.  
在Windows下建议下载LTS版本的安装包进行安装。  
安装时，建议勾选`npm package manager`和`Add to PATH`以安装相应的组件和进行相应的设置。  

5. 安装Hexo  

打开"命令行提示"(`command-line prompt(cmd.exe)`)，然后执行 `npm install hexo-cli -g` 命令。其中`-g`表示全局安装。  
该命令不会影响工作目录（如果你在某目录下执行该命令，执行之后，该目录不会受到影响）。  
可以`npm help install`查看`npm install`的帮助文档。  
Hexo的英文网站：https://hexo.io/  
Hexo的中文网站：https://hexo.io/zh-cn/  

6. 建站以寻找成就感  

在cmd下运行命令`hexo init D:\hexo_demo`在指定目录创建一个`Hexo folder`。  
将当前目录切换到新生成的`Hexo folder`下。  
在cmd下执行命令`npm install`。  
在cmd下执行命令`hexo server --port=4000`。  
在浏览器里访问`http://localhost:4000/`查看情况。  
如果一切正常的话，我们会看到一个网站，此时我们的成就感得到初步满足。  
下面是具体的命令：  
```bat
C:\> hexo init D:\hexo_demo
...(略)...

C:\> cd /d D:\hexo_demo

D:\hexo_demo> npm install
...(略)...

D:\hexo_demo> hexo server --port=4000
INFO  Start processing
INFO  Hexo is running at http://localhost:4000/. Press Ctrl+C to stop.
```


## 一个使用Hexo的示例  

### 选择一个目录作为本次示例的根文件夹  

假设我们选择"D:\hexo_demo"目录作为本次示例的根目录。  
我们需要执行以下命令来初始化这个根目录。  
```bat
C:\> hexo init D:\hexo_demo
C:\> cd /d D:\hexo_demo
D:\hexo_demo> npm install
```

### 写一篇文章  

假设这篇文章的标题为"测试Hexo"。  

1. 新建一篇名为`Hexo测试`的文章  

在根目录下执行命令`hexo new "Hexo测试"`。  
此命令会自动生成一个名为"Hexo测试"的文件。  
```bat
D:\hexo_demo> hexo new "Hexo测试"
INFO  Created: D:\hexo_demo\source\_posts\Hexo测试.md
```

2. 编辑"Hexo测试.md"文件  

打开新生成的"Hexo测试.md"文件，保留已有的文字，继续书写文章内容即可。  

3. 启动服务以查看效果  

在根目录下执行`hexo server --port=4000`以启动服务。  
在浏览器里访问`http://localhost:4000/`查看文章的内容和效果。  
```bat
D:\hexo_demo> hexo server --port=4000
INFO  Start processing
INFO  Hexo is running at http://localhost:4000 . Press Ctrl+C to stop.
```

4. 生成静态文件  

我们书写了文章之后，应当将文章生成静态文件。生成命令是`hexo generate`。  
我们如果要部署网站的话，是需要将生成的html静态文件部署到网站服务器上的。  
Jekyll是你把原文上传GitHub，可以直接生成博客，也可以用在线编辑器处理。  
Hexo是本地生成html再上传。所以Hexo要求本地环境。  
```bat
D:\hexo_demo> hexo generate
...(略)...

D:\hexo_demo>
```

## 部署到GitHub上  

### 创建一个repository  

比如我们创建一个名为`hexo_demo_repo`的Repository。  
举例说明：  
我叫张三，我在注册GitHub账号时，填写的Email为`zhangsan@163.com`，Username为`zhangsan`。  
那么，在GitHub上，我的`Owner`就是`zhangsan`。  
我创建了一个名为`hexo_demo_repo`的Repository。  
那么这个Repository的下载地址应该是：  
`https://github.com/zhangsan/hexo_demo_repo.git`，  
待会我们期望从以下链接访问我们的网站：  
`https://zhangsan.github.io/hexo_demo_repo/`，  

### 安装 hexo-deployer-git  

安装部署工具`hexo-deployer-git`，为后面将网站部署到GitHub上做准备。  
在根目录下执行`npm install hexo-deployer-git --save`命令。  
"--save"的含义：`--save: Package will appear in your dependencies.`。使用`npm help install`可以查看详情。  
```bat
D:\hexo_demo> npm install hexo-deployer-git --save
...(略)...

D:\hexo_demo>
```

### 修改_config.yml配置文件，使其能将网站部署到GitHub上  

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

### 生成静态文件并部署网站到GitHub上以查看效果。  

打开`Git Bash`，切换到根目录(/d/hexo_demo)下，执行`hexo g`和`hexo d`命令。  
注意，在执行`hexo d`后，可能会让你输入用户名和密码。  
`hexo generate`: 生成静态文件。  
`hexo deploy`  : 部署网站。  
```
USERNAME@MACHINE_NAME MINGW64 /d/hexo_demo
$ hexo generate
...(略)...

USERNAME@MACHINE_NAME MINGW64 /d/hexo_demo
$ hexo deploy
...(略)...

USERNAME@MACHINE_NAME MINGW64 /d/hexo_demo
```
然后在浏览器输入`https://zhangsan.github.io/hexo_demo_repo/`查看效果。  
不出意外的话，网站已经部署到GitHub上了。  


___
***
---


# 部署Hexo到GitHub上  

## 创建一个repository  

在GitHub网页上`Create a new repository`。  
要创建的这个repository的名字是有规范的。  
举例：我叫张三，我在注册GitHub账号时，填写的Email为"zhangsan@163.com"，Username为"zhangsan"。  
那么，在GitHub上，我的`Owner`就是"zhangsan"。  
此时我要创建的repository的名字应当为"zhangsan.github.io"。  
即：这个repository的命名规范为`<Owner>.github.io`。  
如果不以这种方式命名，你一般会遇到一些很奇怪的现象。  
创建repository时，建议勾选`Initialize this repository with a README`。因为这个文件里可以写一些说明，起到一个提示作用。  

## 立即在这个repository上创建一个branch，随便起一个名字，比如`my_blog`  

在GitHub网页上，找到名为`<Owner>.github.io`的repository，然后`create a branch`，其名字为`my_blog`。  
建议在网页上创建这个branch，简单、快捷、方便。  
用途：Hexo是利用源文件在本地生成html，然后将html上传到GitHub上。并非Jekyll那样把源文件上传到GitHub，然后GitHub用源文件直接生成博客。  
生成的html传上去了，但是原文件并不在GitHub上，这样个人认为不太好。这个branch是用来存储源文件和Hexo的一些配置文件的。  

## 选定一个目录作为Hexo的根目录，并新建一个网站。  

比如，我们选定"D:\hexo_data"作为Hexo的根目录。  
我们执行以下命令以初始化这个根目录，为写文章和建站做准备。  
```
D:\> hexo init hexo_data
D:\> cd hexo_data
D:\hexo_data> npm install
```

## 安装 hexo-deployer-git  

安装部署工具 hexo-deployer-git ，为后面将网站部署到GitHub上做准备。  
在"D:\hexo_data>"目录下执行`npm install hexo-deployer-git --save`命令。  
"--save"的含义：`--save: Package will appear in your dependencies.`。使用`npm help install`可以查看详情。  
```
D:\hexo_data> npm install hexo-deployer-git --save
...(略)...

D:\hexo_data>
```
备注：如果用npm安装失败，我们可以安装[cnpm](http://npm.taobao.org/)，然后用cnpm安装它。  
```
 npm install -g cnpm --registry=https://registry.npm.taobao.org
cnpm install hexo-deployer-git --save
```
备注：也可以下载源码，拷贝到特定目录和修改文件，以实现安装的步骤。文字中描述的路径是例子中的路径。  
去`https://github.com/hexojs/hexo-deployer-git`下载release下的最新的源码包，比如`hexo-deployer-git-0.3.1.zip`。  
源码包里面肯定有package.json文件，我们需要将源码包匹配到路径`D:\hexo_data\node_modules\hexo-deployer-git\package.json`。  
然后根据package.json里的内容可知(或者根据压缩包的名称也能猜测)其版本号为0.3.1。  
然后打开`D:\hexo_data\package.json`文件，在`dependencies`里面添加`"hexo-deployer-git": "^0.3.1"`，其中0.3.1是版本号。  
备注：有一个安装指定版本的命令`npm install hexo-deployer-git@0.3.0 --save`测试失败了。先写在这里，以后再处理。  

## 修改_config.yml配置文件，使其能将网站部署到GitHub上。  

打开配置文件_config.yml，找到`deploy`部分，其内容可能为：  
```
# Deployment
## Docs: https://hexo.io/docs/deployment.html
deploy:
  type:
```
应当将其修改成  
```
# Deployment
## Docs: https://hexo.io/docs/deployment.html
deploy:
  type: git
  repo: https://github.com/zhangsan/zhangsan.github.io.git
  branch: master
```
或  
```
# Deployment
## Docs: https://hexo.io/docs/deployment.html
deploy:
  type: git
  repo: https://zhangsan@github.com/zhangsan/zhangsan.github.io.git
  branch: master
```
其中，repo的几种写法如下  
```
仅指定用户名：https://zhangsan@github.com/zhangsan/zhangsan.github.io.git
指定用户名和密码：https://zhangsan:mima@github.com/zhangsan/zhangsan.github.io.git
其通用格式为：https://{USERNAME}:{PASSWORD}@github.com/{USERNAME}/{REPOSITORY}.git
```

## 生成静态文件并部署网站到GitHub上以查看效果。  

打开`Git Bash`，切换到根目录(/d/hexo_data)下，执行`hexo g`和`hexo d`命令。  
注意，在执行`hexo d`后，可能会让你输入用户名和密码。  
`hexo generate`: 生成静态文件。  
`hexo deploy`  : 部署网站。  
```
USERNAME@MACHINE_NAME MINGW64 /d/hexo_data
$ hexo generate
...(略)...

USERNAME@MACHINE_NAME MINGW64 /d/hexo_data
$ hexo deploy
...(略)...

USERNAME@MACHINE_NAME MINGW64 /d/hexo_data
```
然后在浏览器输入`https://zhangsan.github.io/`查看效果。  
不出意外的话，网站已经部署到GitHub上了。  

## 从GitHub上克隆这个版本库到本地。  

打开 Git Bash ，在"/d"目录下执行clone命令，可以得到一个"zhangsan.github.io.git"文件夹。  
```
USERNAME@MACHINE_NAME MINGW64 /d
$ git clone https://github.com/zx9229/zx9229.github.io.git
...(略)...

USERNAME@MACHINE_NAME MINGW64 /d
$
```

## 将当前分支从master切换到my_blog  

先列出来几个关于分支的命令  
```
git branch -a    列出所有分支
git checkout -b my_blog remotes/origin/my_blog    checkout远程的my_blog分支，在本地起名为my_blog分支，并切换到本地的my_blog分支。
git checkout my_blog     切换到本地的my_blog分支。
```
我们要执行以下命令，以完成切换：  
```
USERNAME@MACHINE_NAME MINGW64 /d
$ cd zx9229.github.io/

USERNAME@MACHINE_NAME MINGW64 /d/zx9229.github.io (master)
$ git branch -a
* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/master
  remotes/origin/my_blog

USERNAME@MACHINE_NAME MINGW64 /d/zx9229.github.io (master)
$ git checkout -b my_blog remotes/origin/my_blog
Switched to a new branch 'my_blog'
Branch my_blog set up to track remote branch my_blog from origin.

USERNAME@MACHINE_NAME MINGW64 /d/zx9229.github.io (my_blog)
$ git branch -a
  master
* my_blog
  remotes/origin/HEAD -> origin/master
  remotes/origin/master
  remotes/origin/my_blog

USERNAME@MACHINE_NAME MINGW64 /d/zx9229.github.io (my_blog)
$
```

## 移动 zx9229.github.io 内的所有文件到 hexo_data 下。  

刚才我们在"D:\hexo_data"下执行"hexo deploy"把网站部署到GitHub上了。这里的hexo_data就是刚才的"D:\hexo_data"目录。  
```
USERNAME@MACHINE_NAME MINGW64 /d/zx9229.github.io (my_blog)
$ ls -a
./  ../  .git/  README.md

USERNAME@MACHINE_NAME MINGW64 /d/zx9229.github.io (my_blog)
$ mv * .[^.]* /d/hexo_data/

USERNAME@MACHINE_NAME MINGW64 /d/zx9229.github.io
$ cd /d/hexo_data/

USERNAME@MACHINE_NAME MINGW64 /d/hexo_data (my_blog)
$
```

## 编辑.gitignore文件，忽略无意义的文件。  

编辑.gitignore文件，忽略其他所有文件和文件夹，仅留下"source"文件夹和".gitignore"和"_config.yml"和"README.md"文件。  
编辑之后的.gitignore文件内容可能如下所示
```
.deploy*/
node_modules/
public/
scaffolds/
themes/
db.json
package.json
package-lock.json
```

## 提交有意义的文件到服务器的my_blog分支下。  
```
USERNAME@MACHINE_NAME MINGW64 /d/hexo_data (my_blog)
$ git add *
The following paths are ignored by one of your .gitignore files:
db.json
node_modules
package.json
public
scaffolds
themes
Use -f if you really want to add them.

USERNAME@MACHINE_NAME MINGW64 /d/hexo_data (my_blog)
$ git add -f .gitignore

USERNAME@MACHINE_NAME MINGW64 /d/hexo_data (my_blog)
$ git commit -m "初版提交"
[my_blog c43caab] 初版提交
 3 files changed, 118 insertions(+)
 create mode 100644 .gitignore
 create mode 100644 _config.yml
 create mode 100644 source/_posts/hello-world.md

USERNAME@MACHINE_NAME MINGW64 /d/hexo_data (my_blog)
$ git pull --rebase
Current branch my_blog is up to date.

USERNAME@MACHINE_NAME MINGW64 /d/hexo_data (my_blog)
$ git push
Username for 'https://github.com': zx9229
Counting objects: 7, done.
Compressing objects: 100% (5/5), done.
Writing objects: 100% (7/7), 1.66 KiB | 0 bytes/s, done.
Total 7 (delta 0), reused 0 (delta 0)
To https://github.com/zx9229/zx9229.github.io.git
   889a6e2..c43caab  my_blog -> my_blog

USERNAME@MACHINE_NAME MINGW64 /d/hexo_data (my_blog)
$
```

## 以后写文章并发布的步骤  
```
hexo new "新文章"
hexo server
hexo generate
hexo deploy
git add *
git commit -m "提交消息"
git pull --rebase
git push
```

#  从其他地方处理这个版本库的步骤  

## 安装基础软件  

安装 Git 和 TortoiseGit 和 Node.js 和 Hexo 。  

## 从GitHub上clone下来repository，并切换到相应的分支。  
```
$ git clone https://github.com/zx9229/zx9229.github.io.git
$ cd /d/zx9229.github.io/
$ git branch -a
$ git checkout -b my_blog remotes/origin/my_blog
$ git branch -a
```

## 选定一个目录作为Hexo的根目录，并初始化它。  

比如，我们选定"D:\hexo_blog"作为Hexo的根目录。那么需要
```
D:\> hexo init hexo_blog
D:\> cd hexo_blog
D:\hexo_blog> npm install
D:\hexo_blog> npm install hexo-deployer-git --save
```

## 将repository与hexo_blog合并  
```
$ # 人工第一步: 查看"zx9229.github.io.git"下的所有文件和文件夹。
$ # 人工第二步: 如果"hexo_blog"下存在这个文件/文件夹，手动删除掉它。
$ mv * .[^.]* /d/hexo_blog/
$ cd /d/hexo_blog/
```

## 修改文件并提交  

这就是正常的写文件并发布的步骤了。  
