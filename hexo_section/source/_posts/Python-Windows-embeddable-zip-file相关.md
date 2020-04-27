---
title: Python-Windows-embeddable-zip-file相关
categories:
  - Python
toc: false
date: 2019-07-19 13:26:16
tags:
---
略。
<!-- more -->

[嵌入式Python : 如何在U盘安装绿色版 Python](https://baijiahao.baidu.com/s?id=1592976804446590381)。  
[Python 3.7.1 embeddable 及 PyQt5 开发环境搭建](https://blog.csdn.net/blackwoodcliff/article/details/84844917)。  

#### 下载Python嵌入包
[python-3.8.1-embed-amd64.zip](https://www.python.org/ftp/python/3.8.1/python-3.8.1-embed-amd64.zip)。  
我将其解压并匹配到`C:\program_files_zx\python\python-3.8.1-embed-amd64\python.exe`路径。  

#### 编辑`python38._pth`文件
文件路径`C:\program_files_zx\python\python-3.8.1-embed-amd64\python38._pth`。取消注释`import site`。  
```
python38.zip
.

# Uncomment to run site.main() automatically
# import site
# ##########################################
import site
```

#### 安装pip
[get-pip.py](https://bootstrap.pypa.io/get-pip.py)。  
下载`get-pip.py`，并将其匹配到`C:\program_files_zx\python\python-3.8.1-embed-amd64\get-pip.py`，然后：  
```
C:\program_files_zx\python\python-3.8.1-embed-amd64>python get-pip.py
...(略)...
Installing collected packages: pip, setuptools, wheel
  WARNING: The scripts pip.exe, pip3.8.exe and pip3.exe are installed in 'C:\program_files_zx\python\python-3.8.1-embed-amd64\Scripts' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
  WARNING: The scripts easy_install-3.8.exe and easy_install.exe are installed in 'C:\program_files_zx\python\python-3.8.1-embed-amd64\Scripts' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
  WARNING: The script wheel.exe is installed in 'C:\program_files_zx\python\python-3.8.1-embed-amd64\Scripts' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
Successfully installed pip-19.3.1 setuptools-45.0.0 wheel-0.33.6

C:\program_files_zx\python\python-3.8.1-embed-amd64>DIR /B .\Scripts\.
easy_install-3.8.exe
easy_install.exe
pip.exe
pip3.8.exe
pip3.exe
wheel.exe

C:\program_files_zx\python\python-3.8.1-embed-amd64>
```
它会在python目录下新建`Scripts`目录放置pip相关文件，以及`Lib\site-packages`目录放置pip未来下载的扩展依赖模块库。  
成功后，即可用类似`python -m pip install xxx`的方式安装自己的依赖包（这样可以安装xxx到python所在的目录下，记得将xxx替换为自己想安装的模块名）。  

#### 将路径加入PATH
建议将`python.exe`和`pip.exe`加入`PATH`。  
```bat
wmic ENVIRONMENT CREATE name="PYTHON_ROOT_38", username="<system>", VariableValue="C:\program_files_zx\python\python-3.8.1-embed-amd64"
wmic ENVIRONMENT WHERE "name='PATH'        AND username='<system>'" SET VariableValue="%PATH%;%PYTHON_ROOT_38%;%PYTHON_ROOT_38%\Scripts;"
REM 注意这条SET命令,如果PATH里面原来有(环境变量)的话,在设置之后,环境变量会被替换成对应的值.
```
备注：加入PATH时，至少需加入`%PYTHON_ROOT_38%`(python.exe)和`%PYTHON_ROOT_38%\Scripts`(pip.exe)。本信息可以从安装版的PATH中侧面窥得。  

#### 从PATH删除路径
对于删除，没有自动化的命令或脚本，建议从操作界面，删除它。  

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
VSCode的<label style="color:red">**用户**</label>级别的配置文件一般位于`%APPDATA%\Code\User\settings.json`(即`%USERPROFILE%\AppData\Roaming\Code\User\settings.json`)。  
VSCode的**工作区**级别的配置文件一般位于`工作目录\.vscode\settings.json`。  
VSCode中，**用户**级别的配置，优先于**工作区**级别的配置。  

1. 安装yapf  
`python -m pip install yapf`(这样可以安装yapf到python所在的目录下)。  
2. 设置VSCode  
`[File]文件`>`[Preferences]首选项`>`[Settings]设置(Ctrl+,)`然后搜索`python.formatting.provider`并为**用户**级别设置选项到`yapf`。  
3. 设置yapf的路径(可选)  
`[File]文件`>`[Preferences]首选项`>`[Settings]设置(Ctrl+,)`然后搜索`python.formatting.yapfPath`并为**用户**级别设置yapf的路径。  
备注：如果`Shift+Alt+F`无效，请尝试上面的设置。比如我的yapf的路径是`C:\program_files_zx\python\python-3.8.1-embed-amd64\Scripts\yapf.exe`，环境变量`PYTHON_ROOT_38`是`C:\program_files_zx\python\python-3.8.1-embed-amd64`，因此路径也是`%PYTHON_ROOT_38%\Scripts\yapf.exe`，所以，可以在配置里填写`C:\program_files_zx\python\python-3.8.1-embed-amd64\Scripts\yapf.exe`或`${env:PYTHON_ROOT_38}\Scripts\yapf.exe`。  

#### VSCode中python代码智能提示(IntelliSense)
1. 设置VSCode(可选)  
`[File]文件`>`[Preferences]首选项`>`[Settings]设置(Ctrl+,)`然后搜索`python.jediEnabled`并将用户级别的复选框取消勾选。这样就启用了默认的`Microsoft Python Analysis Engine`。  
