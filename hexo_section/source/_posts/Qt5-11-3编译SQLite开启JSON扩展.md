---
title: Qt5.11.3编译SQLite开启JSON扩展
categories:
  - Qt
toc: false
date: 2019-05-19 00:31:45
tags:
  - Qt
  - SQLite
---
略。
<!-- more -->

* 参考
[Qt5.9 build-in SQLite 3.16 not support JSON1 Extension](https://bugreports.qt.io/browse/QTBUG-63498)。  
[Allow sqlite extensions](https://bugreports.qt.io/browse/QTBUG-70972)。  
[Qt 5.9.1 (MinGW) 编译MySQL驱动的步骤](https://blog.csdn.net/chinley/article/details/77711971)。  
[The JSON1 Extension](https://www.sqlite.org/json1.html)。  
`C:\Qt\Qt5.11.3\Docs\Qt-5.11.3\qtsql\sql-driver.html`。  
在`Assistant`的`搜索`这个Tab页里面检索`SQLITE3_PREFIX`而找到的内容。  

* 可能涉及的参考路径
```
C:\Qt\Qt5.11.3\5.11.3\mingw53_32\plugins\sqldrivers\
C:\Qt\Qt5.11.3\5.11.3\Src\qtbase\src\3rdparty\sqlite.pri
C:\Qt\Qt5.11.3\5.11.3\Src\qtbase\src\3rdparty\sqlite\sqlite3.c
C:\Qt\Qt5.11.3\5.11.3\Src\qtbase\src\3rdparty\sqlite\sqlite3.h
C:\Qt\Qt5.11.3\5.11.3\Src\qtbase\src\plugins\sqldrivers\configure.json
```

1. 下载编译用途的SQLite源码
略。

2. 确认自己的Qt版本
我的版本为Qt5.11.3。相关路径为`C:\Qt\Qt5.11.3\5.11.3\Src\qtbase\src\plugins\sqldrivers\sqlite\sqlite.pro`。

3. 下载对应版本的`qtbase`部分的源码
[qtbase-everywhere-src-5.11.3.tar.xz](http://download.qt.io/archive/qt/5.11/5.11.3/submodules/qtbase-everywhere-src-5.11.3.tar.xz)。

4. 解压到指定目录
比如我将其解压并匹配到`E:\qtbase-everywhere-src-5.11.3\src\plugins\sqldrivers\sqlite\sqlite.pro`。  
此时，我们即将涉及到以下文件：
```
E:\qtbase-everywhere-src-5.11.3\src\3rdparty\sqlite.pri
E:\qtbase-everywhere-src-5.11.3\src\3rdparty\sqlite\sqlite3.c
E:\qtbase-everywhere-src-5.11.3\src\3rdparty\sqlite\sqlite3.h
E:\qtbase-everywhere-src-5.11.3\src\plugins\sqldrivers\configure.json
```

5. 修改`sqlite.pri`文件
删除`SQLITE_OMIT_LOAD_EXTENSION`增加`SQLITE_ENABLE_JSON1`。例如：
```shell
# DEFINES += SQLITE_ENABLE_COLUMN_METADATA SQLITE_OMIT_LOAD_EXTENSION SQLITE_OMIT_COMPLETE SQLITE_ENABLE_FTS3 SQLITE_ENABLE_FTS3_PARENTHESIS SQLITE_ENABLE_FTS5 SQLITE_ENABLE_RTREE
DEFINES   += SQLITE_ENABLE_COLUMN_METADATA                            SQLITE_OMIT_COMPLETE SQLITE_ENABLE_FTS3 SQLITE_ENABLE_FTS3_PARENTHESIS SQLITE_ENABLE_FTS5 SQLITE_ENABLE_RTREE SQLITE_ENABLE_JSON1
```

6. 更新`sqlite3.c`和`sqlite3.h`文件
将下载好的SQLite源码覆盖过去。

7. 修改`configure.json`文件
此步骤为可选项。将`summary`备份为`summary.bak`，创建`summary`仅保留sqlite的配置。然后执行默认编译操作，这样(或许)可以编译较少的组件：
```json
    "summary.bak": [
        {
            "section": "Qt Sql",
            "entries": [
                "sql-db2", "sql-ibase", "sql-mysql", "sql-oci", "sql-odbc", "sql-psql",
                "sql-sqlite2", "sql-sqlite", "system-sqlite", "sql-tds"
            ]
        }
    ],
    "summary": [
        {
            "section": "Qt Sql",
            "entries": [ "sql-sqlite" ]
        }
    ]
}
```
8. 使用什么编译环境
我要编译`mingw53_32`和`android_armv7`的库。涉及的路径为：  
`C:\Qt\Qt5.11.3\5.11.3\mingw53_32\bin\qmake.exe`。  
`C:\Qt\Qt5.11.3\5.11.3\android_armv7\bin\qmake.exe`。  

9. 生成Makefile文件
检查qmake版本`qmake --version`（以`mingw53_32`为例）。  
切换到编译目录`cd /d E:\qtbase-everywhere-src-5.11.3\src\plugins\sqldrivers`。  
执行配置的命令`qmake --`。
示例：
```cmd
E:\> qmake --version
QMake version 3.0
Using Qt version 5.6.0 in C:/Program Files/Anaconda3/Library/lib

E:\> SET PATH=C:\Qt\Qt5.11.3\5.11.3\mingw53_32\bin;%PATH%

E:\> qmake --version
QMake version 3.1
Using Qt version 5.11.3 in C:/Qt/Qt5.11.3/5.11.3/mingw53_32/lib

E:\> cd /d E:\qtbase-everywhere-src-5.11.3\src\plugins\sqldrivers\

E:\qtbase-everywhere-src-5.11.3\src\plugins\sqldrivers> qmake --
Info: creating stash file E:\qtbase-everywhere-src-5.11.3\src\plugins\sqldrivers\.qmake.stash

Running configuration tests...
Checking for DB2 (IBM)... no
Checking for InterBase... no
Checking for MySQL... no
Checking for OCI (Oracle)... no
Checking for ODBC... yes
Checking for PostgreSQL... no
Checking for SQLite (version 2)... no
Checking for TDS (Sybase)... no
Done running configuration tests.

Configure summary:

Qt Sql:
  SQLite ................................. yes

Qt is now configured for building. Just run 'mingw32-make'.
Once everything is built, Qt is installed.
You should NOT run 'mingw32-make install'.
Note that this build cannot be deployed to other machines or devices.

Prior to reconfiguration, make sure you remove any leftovers from
the previous build.

E:\qtbase-everywhere-src-5.11.3\src\plugins\sqldrivers>ECHO %ERRORLEVEL%
0
```

10. 执行编译命令
执行`mingw32-make`。一切顺利的话，你至少能看到：
```cmd
E:\qtbase-everywhere-src-5.11.3\src\plugins\sqldrivers\plugins\sqldrivers> DIR /B
libqsqlite.a
libqsqlited.a
qsqlite.dll
qsqlited.dll
```

11. 替换默认文件
Qt5.11.3的默认文件在`C:\Qt\Qt5.11.3\5.11.3\mingw53_32\plugins\sqldrivers\`目录下。备份原文件，添加新文件，即可。

12. 测试
参考[The JSON1 Extension](https://www.sqlite.org/json1.html)自行测试。

* 编译Android用的库
命令行编译Android需求NDK，我用了`android-ndk-r16b-windows-x86_64.zip`并将其匹配到了`C:\android-ndk-r16b-windows-x86_64\android-ndk-r16b\toolchains\arm-linux-androideabi-4.9\prebuilt\windows-x86_64\bin\arm-linux-androideabi-g++.exe`。  
此时`SET ANDROID_NDK_ROOT=C:\android-ndk-r16b-windows-x86_64\android-ndk-r16b`。  
(可选项)我们或许还要拷贝一份`C:\android-ndk-r16b-windows-x86_64\android-ndk-r16b\toolchains\arm-linux-androideabi-4.9\prebuilt\windows-x86_64`并命名为`windows`。因为知识不够，不知道怎么做，所以只能搞一个副本以规避某些错误。  
示例：
```cmd
E:\> qmake --version
QMake version 3.0
Using Qt version 5.6.0 in C:/Program Files/Anaconda3/Library/lib

E:\> SET PATH=C:\Qt\Qt5.11.3\5.11.3\android_armv7\bin;%PATH%

E:\> qmake --version
QMake version 3.1
Using Qt version 5.11.3 in C:/Qt/Qt5.11.3/5.11.3/android_armv7/lib

E:\> SET ANDROID_NDK_ROOT=C:\android-ndk-r16b-windows-x86_64\android-ndk-r16b

E:\> REM 请先了解下面的这个 XCOPY /FRYE 命令, 或者先跳过它, 继续后面的命令.

E:\> echo D | XCOPY /FRYE C:\android-ndk-r16b-windows-x86_64\android-ndk-r16b\toolchains\arm-linux-androideabi-4.9\prebuilt\windows-x86_64  C:\android-ndk-r16b-windows-x86_64\androi
d-ndk-r16b\toolchains\arm-linux-androideabi-4.9\prebuilt\windows

E:\> cd /d E:\qtbase-everywhere-src-5.11.3\src\plugins\sqldrivers\

E:\qtbase-everywhere-src-5.11.3\src\plugins\sqldrivers> qmake --
Info: creating stash file E:\qtbase-everywhere-src-5.11.3\src\plugins\sqldrivers\.qmake.stash

Running configuration tests...
Checking for DB2 (IBM)... no
Checking for InterBase... no
Checking for MySQL... no
Checking for OCI (Oracle)... no
Checking for ODBC... no
Checking for PostgreSQL... no
Checking for SQLite (version 2)... no
Checking for TDS (Sybase)... no
Done running configuration tests.

Configure summary:

Qt Sql:
  SQLite ................................. yes

Qt is now configured for building. Just run 'mingw32-make'.
Once everything is built, Qt is installed.
You should NOT run 'mingw32-make install'.
Note that this build cannot be deployed to other machines or devices.

Prior to reconfiguration, make sure you remove any leftovers from
the previous build.

E:\qtbase-everywhere-src-5.11.3\src\plugins\sqldrivers>ECHO %ERRORLEVEL%
0
```
如果`mingw32-make`顺利的话，应当能看到：
```cmd
E:\qtbase-everywhere-src-5.11.3\src\plugins\sqldrivers\plugins\sqldrivers> DIR /B
libqsqlite.so
```
Qt5.11.3的默认文件在`C:\Qt\Qt5.11.3\5.11.3\android_armv7\plugins\sqldrivers\`目录下。备份原文件，添加新文件，即可。
