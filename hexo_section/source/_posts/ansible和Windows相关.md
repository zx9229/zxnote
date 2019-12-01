---
title: ansible和Windows相关
categories:
  - python
  - Ansible
toc: true
date: 2018-06-29 00:14:25
tags:
---
摘要暂略。
<!-- more -->

### CentOS6安装pip

#### CentOS6安装python2的pip

方式1：`yum install python-setuptools && easy_install "pip<=9.0.3"`。  
参考：[Shadowsocks 使用说明](https://github.com/shadowsocks/shadowsocks/wiki/Shadowsocks-使用说明)。  
方式2：`curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python get-pip.py`。  
参考：[Installation — pip 10.0.1 documentation](https://pip.pypa.io/en/stable/installing/)。  

#### CentOS6安装python3的pip3

方式1：`yum install python34 python34-setuptools && easy_install-3.4 pip`。  
方式2：`wget https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py`。

### Ansible的Inventory文件

默认的inventory文件是`/etc/ansible/hosts`文件。文件中应当记录被控机器的连接信息。

#### Inventory文件有哪些参数

Linux：[Working with Inventory — Ansible Documentation](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html#list-of-behavioral-inventory-parameters)。  
Windows：[Windows Remote Management — Ansible Documentation](https://docs.ansible.com/ansible/latest/user_guide/windows_winrm.html#inventory-options)。  

#### Inventory文件的例子

下面是`/etc/ansible/hosts`的内容：
```
[Windows_Hosts]
m101 ansible_host="192.168.1.101" ansible_port="5985" ansible_user="mydomain\dun" ansible_password="密码" ansible_connection="winrm" ansible_winrm_transport="credssp"
192.168.1.102                     ansible_port=5985   ansible_user="mydomain\dun" ansible_password="密码" ansible_connection=winrm   ansible_winrm_transport=credssp
192.168.1.103:5985                                    ansible_user=dun@mydomain   ansible_password="密码" ansible_connection=winrm   ansible_winrm_transport=credssp
192.168.1.104:5985                                    ansible_user=Administrator  ansible_password="密码" ansible_connection=winrm   ansible_winrm_transport=credssp
[Linux_Hosts]
m105 ansible_host="192.168.1.105" ansible_port=22     ansible_user="root" ansible_connection="ssh" ansible_ssh_pass="SSH密码"
192.168.1.106:20022                                   ansible_user="root" ansible_connection="ssh" ansible_ssh_private_key_file="私钥文件的路径"
```
然后你可以执行下面的命令进行测试了：
```
ansible m101          --module-name=win_ping
ansible 192.168.1.104  -m           win_ping
ansible Windows_Hosts  -m           win_ping
ansible m105           -m               ping
ansible Linux_Hosts    -m               ping
```

### CentOS6安装Python35和Ansible

参考链接：  
[在 CentOS 6 系统上安装最新版 Python3 软件包的 3 种方法](https://linux.cn/article-9680-1.html)。  
[Python 3.5 — Software Collections](https://www.softwarecollections.org/en/scls/rhscl/rh-python35/)。  
如果想用`Ansible`控制Windows，那么至少需要Python35。  
因为`Ansible requires a minimum of Python2 version 2.6 or Python3 version 3.5.`，而`pip install pywinrm`时我们可以知道`pywinrm`已经不支持`Python2`了。  
然后我决定使用 Software Collections 源 （SCL）安装Python35和Ansible。下面是操作命令：
```
yum -y install centos-release-scl
yum-config-manager --enable rhel-server-rhscl-7-rpms
yum -y install rh-python35
scl enable rh-python35 bash
pip --version
pip install --upgrade pip
pip install ansible
pip install pywinrm
pip install pywinrm[kerberos]
pip install pywinrm[credssp]
```

### Windows设置WinRM

#### 确认主机满足最低要求

[Host Requirements](https://docs.ansible.com/ansible/latest/user_guide/windows_setup.html#host-requirements)。  
`Ansible requires PowerShell 3.0 or newer and at least .NET 4.0 to be installed on the Windows host.`
```
PS C:\> $PSVersionTable.PSVersion   # PowerShell version
PS C:\> $PSVersionTable.CLRVersion  # .NET Framework
```

#### 设置WinRM服务

下面是设置的步骤，请以管理员身份运行powershell并执行它们。  
如果已经创建了监听器，你可以直接下一步；或者删除它并重新创建，然后下一步。  
```
# 查看WinRM的监听器
winrm enumerate winrm/config/Listener
# 删除所有监听器(可选)
Remove-Item -Path WSMan:\localhost\Listener\* -Recurse
# 快速配置WinRM服务
winrm quickconfig
# 查看WinRM的监听器(确认之用)
winrm enumerate winrm/config/Listener
# 我认为统一使用CredSSP进行身份认证比较好,所以Basic就别用了.
winrm set winrm/config/service/auth '@{CredSSP="true";Basic="false"}'
# By default this is false and should only be set to true when debugging WinRM messages.
winrm set winrm/config/service '@{AllowUnencrypted="false"}'
# 使用win_ping模块进行测试
ansible  主机名  --module-name=win_ping
```
执行以上步骤之后，如果测试失败了，请尝试下面各项：
* 关闭杀软(请关闭`360安全卫士`等，或许可以忽略`Windows Defender`)
* 关闭Windows防火墙
* 重启机器
* 去官网看文档然后自己解决

#### 其他说明

WinRM可以监听一个或多个指定端口，因为我没有这方面的需求，所以没有进行相关了解。  
我`winrm quickconfig -?`之后尝试`winrm quickconfig -transport:https`失败了，决定不在`HTTPS`上面死磕，就用`HTTP`吧。  
你可以使用官方提供的`Upgrade-PowerShell.ps1`文件升级某些要求项。  
你可以使用官方提供的`ConfigureRemotingForAnsible.ps1`脚本对WinRM进行一些基本设置。  
Ansible管理Windows主机的指南：  
[Windows Guides — Ansible Documentation](https://docs.ansible.com/ansible/latest/user_guide/windows.html)。  
设置Windows主机的指南：  
[Setting up a Windows Host — Ansible Documentation](https://docs.ansible.com/ansible/latest/user_guide/windows_setup.html)。  
Ansible有哪些可用的Windows模块：  
[Windows modules — Ansible Documentation](https://docs.ansible.com/ansible/latest/modules/list_of_windows_modules.html)。  
以下链接给了我较多的帮助：  
[ansible管理windows实践](https://www.cnblogs.com/kingleft/p/6391652.html)。  
[PowerShell 远程执行任务的方法步骤](https://www.jb51.net/article/131532.htm)。  

#### 无法分类的内容
从[Get Certificate thumbprint using PowerShell](https://blogs.technet.microsoft.com/tune_in_to_windows_intune/2013/12/10/get-certificate-thumbprint-using-powershell/)中，我们可以发现，`Get-ChildItem -path cert:\LocalMachine\My`的值和`HTTPS`中的`CertificateThumbprint`有点像。它可能对设置`HTTPS`有帮助。  
CredSSP身份验证在Windows主机上未默认启用，但可以通过在PowerShell中运行以下命令来启用：`Enable-WSManCredSSP -Role Server -Force`。  
从[Windows Remote Management — Ansible Documentation](https://docs.ansible.com/ansible/latest/user_guide/windows_winrm.html#non-administrator-accounts)中，可以看到`winrm configSDDL default`命令，而官网也提到了它。它可能对设置域用户(domain account)有些帮助。  

#### linux和windows的包的对应
```
https://docs.ansible.com/ansible/latest/modules/win_file_module.html
https://docs.ansible.com/ansible/latest/modules/file_module.html
https://docs.ansible.com/ansible/latest/modules/win_copy_module.html
https://docs.ansible.com/ansible/latest/modules/copy_module.html
ansible "192.168.1.3:22222" --module-name=file --args="path=/tmp/myDir1/myDir2/ state=directory"
ansible 192.168.1.4          -m win_file        -a "path=F:\file\passwd state=absent"
```
