---
title: Oracle重置SYS和SYSTEM用户的密码
date: 2017-08-31 11:14:42
categories:
- MyDefaultCategory
tags:
toc: true
---
重置SYS和SYSTEM的密码的操作详情。  

<!-- more -->

## SYS和SYSTEM的区别  
具体区别我也不知道，不过在网上看到了一个很形象的比喻：用QQ群作个比喻, sys就相当于群主, system就相当于群管理员.  


## 重置SYS和SYSTEM密码的步骤  

### 用管理员用户登录操作系统  
建议用`Administrator`登录操作系统。  
假如我们使用一个普通用户登录操作系统，然后以管理员身份运行PowerShell，重置密码时，可能会出现权限不足的情况。举例如下：  
```
Windows PowerShell
版权所有 (C) 2013 Microsoft Corporation。保留所有权利。

PS C:\Windows\system32> sqlplus /nolog

SQL*Plus: Release 11.2.0.1.0 Production on 星期四 8月 31 10:09:36 2017

Copyright (c) 1982, 2010, Oracle.  All rights reserved.

SQL> conn /as sysdba
ERROR:
ORA-01031: 权限不足


SQL> exit
PS C:\Windows\system32>
```

### 在sqlplus环境下修改某用户的密码  
下面是用Administrator登录操作系统后，运行PowerShell的情况：  
```
Windows PowerShell
版权所有 (C) 2013 Microsoft Corporation。保留所有权利。

PS C:\Users\Administrator>
PS C:\Users\Administrator> sqlplus /nolog

SQL*Plus: Release 11.2.0.1.0 Production on 星期四 8月 31 09:45:04 2017

Copyright (c) 1982, 2010, Oracle.  All rights reserved.

SQL> conn /as sysdba
已连接。
SQL> ALTER USER system IDENTIFIED BY system_pwd;

用户已更改。

SQL> exit
从 Oracle Database 11g Enterprise Edition Release 11.2.0.1.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options 断开
PS C:\Users\Administrator>
```
