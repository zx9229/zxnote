---
title: Ansible弱智记录
date: 2017-10-28 19:44:41
categories:
- python
- Ansible
tags:
toc: true
---

记录了Ansible的一些东西

<!-- more -->

## Ansible中文权威指南  
Ansible中文权威指南: `http://www.ansible.com.cn/index.html`  
下面的文字基本上全部摘自该网站, 或根据该网站的内容总结出来.  

## 安装Ansible  
仅主控端(管理主机)需要安装Ansible, Ansible不必在远程被管理机器上安装任何软件. 主控端一般通过SSH操作被控端(托管节点).  
安装ansible的方式之一: `yum install ansible`  
查看ansible的版本号: `ansible --version`  

## inventory文件  
默认的inventory文件是"/etc/ansible/hosts"文件.  

## 配置托管节点(我将其理解为"被控机器")  
编辑(或创建)"/etc/ansible/hosts"并在其中加入一个或多个远程系统.  
配置托管节点, 指定用户名和密码的方式(因为显式的写出了密码, 所以不推荐):  
```
IP地址:端口  ansible_connection=ssh  ansible_ssh_user=某用户名  ansible_ssh_pass=某用户名的密码
```
配置托管节点, 指定密钥的方式:  
```
IP地址:端口  ansible_connection=ssh  ansible_ssh_user=某用户名  ansible_ssh_private_key_file=某用户名的私钥文件在主控端机器的路径
```
注: 具体参数详见"Inventory文件"->"Inventory 参数的说明"章节.  
注: 配置完毕后, 可以执行"ansible all -m ping"寻找成就感.  

## Ad-Hoc任务  
Ansible提供两种方式去完成任务, 一是 ad-hoc 命令, 一是写 Ansible playbook. 前者可以解决一些简单的任务, 后者解决较复杂的任务.  
如果我们敲入一些命令去比较快的完成一些事情, 而不需要将这些执行的命令特别保存下来, 这样的命令就叫做 ad-hoc 命令.  
"ad-hoc 命令"相对于"写 Ansible playbook", 类似于在命令行"敲入shell命令"和"写shell scripts"两者之间的关系.  
一个ad-hoc实例(本示例仍有BUG: 如果文件的权限不对, 有可能删除失败):  
```
ansible 某机器名 -m shell -a 'if [ ! -f "/tmp/just_test.txt" ]; then echo "just_test" > /tmp/just_test.txt; fi'
ansible 某机器名 -m shell -a 'if [   -f "/tmp/just_test.txt" ]; then              rm -f /tmp/just_test.txt; fi'
```

## Playbooks  
Playbooks 的格式是YAML. YAML格式的文件一般用".yml"标识.  
YAML基本语法: `http://www.ansible.com.cn/docs/YAMLSyntax.html`  
需要用"ansible-playbook"程序执行playbook文件, 该程序的路径一般是"/usr/bin/ansible-playbook".  
注: 并没有默认的playbook.yml文件. 需要你书写一个文件, 然后可以用"ansible-playbook 文件名"命令执行它.  
一个playbook.yml示例:  
```
---
- hosts: 机器名
  tasks:
  - name: 在被控机器(托管节点)(remote hosts)上面编译某程序
    remote_user: 某用户名
    shell: bash 编译脚本的路径
  - name: 从被控机器拉取文件到主控机器(管理主机)(control machine)
    remote_user: 某用户名
    synchronize:
      mode: pull
      src: 被控机器上的文件路径
      dest: 主控机器上的路径
  - name: 从主控机器拷贝文件到被控机器
    copy:
      src: 主控机器上的文件路径(相对/绝对)
      dest: 被控机器上的绝对路径
      backup: yes
  - name: 解压被控机器上的压缩包
    unarchive:
      remote_src: yes
      src: 被控机器上的归档的绝对路径
      dest: 解压到被控机器上的绝对路径
```
备注:  
shell: `http://docs.ansible.com/ansible/latest/shell_module.html`  
synchronize: `http://docs.ansible.com/ansible/latest/synchronize_module.html`  
copy: `http://docs.ansible.com/ansible/latest/copy_module.html`  
unarchive: `http://docs.ansible.com/ansible/latest/unarchive_module.html`

## 自己的笔记  
搜索"YAML文件规范"可以找到[The Official YAML Web Site](http://www.yaml.org/)网站。  

### YAML文件可以CRLF作为换行符  
Linux下的.sh文件必须UTF8格式+以LF为换行符, 而YAML文件对换行符无要求.

### YAML文件中的"#"  
在YAML文件中, 以"#"作为注释符.(#和#后面的文字都会被忽略)。  

### YAML文件中的"|"  
当一个字符串包含换行符, 您可以通过使用|符号表明该字符串将跨越数行. 从而使用传统的文本风格. 在这种风格下, 换行符将不被转义.  

### 几个例子  
一个使用#和|的例子：  
```
---
- hosts: 127.0.0.1
  tasks:
  #- name: 一个被注释掉的任务.
  #  shell: echo ""
  #  delegate_to: localhost  # 把这个任务委派给本机执行.
  - name: 将shell脚本写进yml文件的例子.
    remote_user: zhangsan                # 用哪一个用户登录127.0.0.1机器.
    shell: |                             # 用"|"表示下面的字符串将跨越数行.
      kill -9 $( pidof "PROGRAM_NAME" )  # 强杀程序.
      if [ -d "${HOME}/PROGRAM_FOLDER" ] # 备份程序文件(如果存在的话).
        then mv "${HOME}/PROGRAM_FOLDER" "${HOME}/PROGRAM_FOLDER.$(date +"%Y-%m-%d_%H-%M-%S").bak"
        if [ $? -ne 0 ]; then echo "[ERROR] Error occurred."; exit 1; fi
      fi
      mkdir "${HOME}/PROGRAM_FOLDER"     # 创建文件夹(模拟:将压缩包解压到特定目录).
      if [ $? -ne 0 ]; then echo "[ERROR] Error occurred."; exit 1; fi
      echo "start PROGRAM_NAME"          # (模拟:启动程序).
      exit 1                             # (模拟:启动程序,失败)(模拟成功时,修改成"exit 0").
    args:
      executable: /bin/bash  # 用哪一个shell执行命令,请写绝对路径.
      chdir: /opt/           # 在执行命令之前,先切到某目录.
  - name: 基本上绝对会执行成功的任务.
    shell: echo ""
```
