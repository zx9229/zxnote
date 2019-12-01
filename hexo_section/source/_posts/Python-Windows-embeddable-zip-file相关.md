---
title: Python-Windows-embeddable-zip-file相关
categories:
  - python
toc: false
date: 2019-07-19 13:26:16
tags:
---
略。
<!-- more -->

[嵌入式Python : 如何在U盘安装绿色版 Python](https://baijiahao.baidu.com/s?id=1592976804446590381)。  
[Python 3.7.1 embeddable 及 PyQt5 开发环境搭建](https://blog.csdn.net/blackwoodcliff/article/details/84844917)。  

#### 下载Python嵌入包
[python-3.7.4-embed-amd64.zip](https://www.python.org/ftp/python/3.7.4/python-3.7.4-embed-amd64.zip)。  
我将其解压并匹配到`C:\Program_Files_zx\python-3.7.4-embed-amd64\python.exe`路径。  

#### 编辑`python37._pth`文件
文件路径`C:\Program_Files_zx\python-3.7.4-embed-amd64\python37._pth`。取消注释`import site`。  
```
python37.zip
.

# Uncomment to run site.main() automatically
# import site
# ##########################################
import site
```

#### 安装pip
[get-pip.py](https://bootstrap.pypa.io/get-pip.py)。  
下载`get-pip.py`，并将其匹配到`C:\Program_Files_zx\python-3.7.4-embed-amd64\get-pip.py`，然后：  
```
C:\Program_Files_zx\python-3.7.4-embed-amd64>python.exe get-pip.py
...(略)...
Installing collected packages: pip, setuptools, wheel
  WARNING: The script wheel.exe is installed in 'C:\Program_Files_zx\python-3.7.4-embed-amd64\Scripts' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
Successfully installed pip-19.1.1 setuptools-41.0.1 wheel-0.33.4

C:\Program_Files_zx\python-3.7.4-embed-amd64>DIR /B .\Scripts\.
easy_install-3.7.exe
easy_install.exe
pip.exe
pip3.7.exe
pip3.exe
wheel.exe

C:\Program_Files_zx\python-3.7.4-embed-amd64>
```
它会在python目录下新建`Scripts`目录放置pip相关文件，以及`Lib\site-packages`目录放置pip未来下载的扩展依赖模块库。  
成功后，即可用类似`python -m pip install xxx`的方式安装自己的依赖包（xxx替换为自己想安装的模块名）。  

#### 加入PATH
建议将`python.exe`和`pip.exe`加入`PATH`。
```bat
wmic ENVIRONMENT CREATE name="PYTHON_ROOT_37", username="<system>", VariableValue="C:\Program_Files_zx\python-3.7.4-embed-amd64"
wmic ENVIRONMENT WHERE "name='PATH'        AND username='<system>'" SET VariableValue="%PATH%;%PYTHON_ROOT_37%;%PYTHON_ROOT_37%\Scripts;"
REM 注意这条SET命令,如果PATH里面原来有(环境变量)的话,在设置之后,环境变量会被替换成对应的值.
```
备注：加入PATH时，至少需加入`%PYTHON_ROOT_37%`(python.exe)和`%PYTHON_ROOT_37%\Scripts`(pip.exe)。本信息可以从安装版的PATH中侧面窥得。

#### ModuleNotFoundError
```python
>>> import my_module
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ModuleNotFoundError: No module named 'my_module'
```
简答：要么`my_module`不存在，要么`my_module`不在`sys.path`(模块的搜索路径)中。  
[sys — System-specific parameters and functions](https://docs.python.org/3/library/sys.html#sys.path)。  
[site — Site-specific configuration hook](https://docs.python.org/3/library/site.html)。  
[How does python find packages?](https://leemendelowitz.github.io/blog/how-does-python-find-packages.html)。  
* 往`sys.path`中加入路径的一个方式(荐)
Win:::　`os.path.realpath(os.path.join(sys.prefix, 'lib/site-packages'))`  
Win:::　`os.path.realpath(os.path.join(sys.exec_prefix, 'lib/site-packages'))`  
Linux:　`os.path.realpath(os.path.join(sys.prefix, 'lib/pythonX.Y/site-packages'))`  
Linux:　`os.path.realpath(os.path.join(sys.exec_prefix, 'lib/pythonX.Y/site-packages'))`  
在上述目录下，创建名称格式为`文件名.pth`的文件，每行一个路径，(如果路径存在)那么，这些路径便会添加到`sys.path`中。
* 往`sys.path`中加入路径的一个方式
`sys.path.insert(0, os.path.split(os.path.realpath(__file__))[0])`。

#### VSCode用yapf格式化python脚本
VSCode的用户级别的配置文件一般位于`%APPDATA%\Code\User\settings.json`(即`%USERPROFILE%\AppData\Roaming\Code\User\settings.json`)。  
1. 安装yapf：  
`python -m pip install yapf`。  
2. 设置VSCode：  
`[File]文件`>`[Preferences]首选项`>`[Settings]设置(Ctrl+,)`然后搜索`python.formatting.provider`并将用户级别的选项设置到`yapf`。  

#### VSCode中python代码智能提示(IntelliSense)
1. 设置VSCode
`[File]文件`>`[Preferences]首选项`>`[Settings]设置(Ctrl+,)`然后搜索`python.jediEnabled`并将用户级别的复选框取消勾选。这样就启用了默认的`Microsoft Python Analysis Engine`。  
