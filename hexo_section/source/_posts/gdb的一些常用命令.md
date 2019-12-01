---
title: gdb的一些常用命令
date: 2017-07-08 20:31:53
categories:
- Linux
tags:
toc: false
---
在使用gdb调试程序的过程中，有些命令是会被频繁使用的。  
对于我频繁用到的一些命令，在下面进行了举例说明。  

<!-- more -->

## 查看源代码

### 命令
```
(gdb) list                    输出从上次调用list命令开始往后的10行程序代码。
(gdb) list [file:]lineno      输出文件file的lineno行附近的10行程序代码。
(gdb) list [file:]line1,line2 输出文件file的line1到line2之间的程序代码。
(gdb) list [file:]function    输出文件file的函数function前后的10行程序代码。
```

### gdb给出的解释(输入"help all"后, 你可能找会到它的解释)
```
list -- List specified function or line
list -- 列出指定的函数或行。
```
### 例子
例：某程序有 main.cpp,my.h,my.cpp 共3个文件。
代码里有一个类MY，该类有个成员函数void MY::init()。
现在程序运行到main.cpp中了。
我想查看my.cpp中的MY::init函数，我要怎么做？
(gdb) list my.cpp:1  将list命令的默认文件切换到my.cpp中。
(gdb) list MY::init  查看默认文件里面的MY::init函数。

## 设置断点

### 命令
```
(gdb) break [file:]lineno     在文件file的第lineno行设置断点。
(gdb) break [file:]function   在文件file的函数function处(函数体里面的第一行代码所在的行号)设置断点。
```

### gdb给出的解释
```
break -- Set breakpoint at specified line or function
break -- 在指定的行或函数设置断点。
```

### 例子
例：某程序有 main.cpp,my.h,my.cpp 共3个文件。
代码里有一个类MY，该类有个成员函数void MY::init()。
现在程序运行到main.cpp中了。
我想在my.cpp中的MY::init函数处设置断点，我要怎么做？
(gdb) list my.cpp:1   将list命令的默认文件切换到my.cpp中，此时break命令的默认文件也变成my.cpp了。
(gdb) break MY::init  在默认文件的里面的MY::init函数处设置断点。

## 查看所有断点

### 命令
```
(gdb) info breakpoints(可缩写为"info b")
```

### gdb给出的解释
```
info breakpoints -- Status of user-settable breakpoints
info breakpoints -- 用户可设置的断点的状态。
```

## 给断点添加条件(条件断点?)  

### 命令  
```
condition <break_num> (condition_expression)    # 给断点增加条件
condition <break_num>                           # 删掉这个断点的条件
```

### gdb给出的解释  
```
condition -- Specify breakpoint number N to break only if COND is true
condition -- 只有当COND为true时，指定的断点号N才会中断。
```

### 例子  
例：某断点的断点号为"1"，当程序在此处中断时，我们能找到一个名为"buf"的字符数组变量。我们想修改这个断点的中断条件为`当buf的内容为"FAIL"时才中断`，我们需要：
```
(gdb) info breakpoints     # 此时，1号断点的条件是：只要执行到这儿，就中断。
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x00000000004005c0 in main() at test.cpp:9
(gdb) condition  1  (strcmp(buf, "FAIL") == 0)    # 修改为：执行到这儿时，buf的内容为"FAIL"时中断。
(gdb) info breakpoints     # 此时可以看到，这个断点已经加上条件判断了。
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x00000000004005c0 in main() at test.cpp:9
	stop only if (strcmp(buf, "FAIL") == 0)
(gdb) condition 1          # 删掉1号断点的条件。
Breakpoint 1 now unconditional.
(gdb) info breakpoints     # 此时可以看到，这个断点已经没有条件了。
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x00000000004005c0 in main() at test.cpp:9
(gdb)
```
备注：不知道为什么，为某个函数打断点时我在A线程里，为这个断点加条件时我也在A线程里，当B线程执行到这个断点处时，条件竟然失效了，同时断点还是生效的。表示很奇怪。

## 监视点

### 命令
```
watch (watch_expression)    # 监视条件
```

### gdb给出的解释  
```
watch -- Set a watchpoint for an expression
watch -- 为一个表达式设置一个监视点
```

### 说明  
监视点的设定不依赖于断点的位置。但是与变量的作用域有关。也就是说，我们写了一个表达式，这个表达式涉及了很多变量，在某一个位置，要能同时访问到这些变量，我们才可以在程序运行到这个位置的时候设置监视点。在不确定发生问题的地方时，通过使用监视点的表达式，可以很方便的找出问题代码。比如我们`watch (20<i)`，一旦i大于20了，程序就会被中断，gdb会指出条件从false变成true的那一段代码。

## 查看监视点的状态  

### 命令
```
info watchpoints(可缩写为"info watch")
```

### gdb给出的解释  
```
info watchpoints -- Status of watchpoints
info watchpoints -- 监视点的状态
```

## 给断点设置要执行的命令列表

### 命令
```
commands <break_num>
```

### gdb给出的解释  
```
commands -- Set commands to be executed when a breakpoint is hit
commands -- 设置在命中断点时执行的命令
```

### 例子  
```
(gdb) info break
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x00000000004005c0 in main() at test.cpp:9
(gdb) commands 1    # 给断点1添加要执行的命令"打印buf的值"。
Type commands for breakpoint(s) 1, one per line.
End with a line saying just "end".
>print buf
>end
(gdb) info break    # 可以看到这个断点下面绑定了哪些命令。
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x00000000004005c0 in main() at test.cpp:9
        print buf
(gdb) commands 1    # 绑定一个空的命令列表，就是变相的清除其命令列表。
Type commands for breakpoint(s) 1, one per line.
End with a line saying just "end".
>end
(gdb) info break
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x00000000004005c0 in main() at test.cpp:9
(gdb)
```

## 启用断点/监视点  

### 命令  
```
(gdb) enable <break_num>
```

### gdb给出的解释  
```
enable -- Enable some breakpoints
enable -- 启用一些断点。
```

## 禁用断点/监视点  

### 命令  
```
(gdb) disable <break_num>
```

### gdb给出的解释  
```
disable -- Disable some breakpoints
disable -- 禁用一些断点。
```

## 附加到某进程上  

### 命令  
```
(gdb) attach <ProcessID>
```

### gdb给出的解释  
```
attach -- Attach to a process or file outside of GDB
attach -- 附加到GDB之外的进程或文件。
```

### 例子  
例：假定我写了一个名为"test_exe"的程序。其源码路径为"/root/src_folder/"，其可执行文件路径为"/root/exe_folder/test_exe"，程序已经启动，程序的PID为12345。此时，我要用gdb调试这个进程的话，我要：
```
# gdb                                        # 进入gdb
(gdb) directory "/root/src_folder/"          # 添加源码搜索路径(可选)
(gdb) file      "/root/exe_folder/test_exe"  # 使用test_exe作为要调试的程序(可选)
(gdb) attach    12345                        # 附加到进程12345上
...(执行调试操作)...
(gdb) detach                                 # 分离先前附加的进程或文件
(gdb) quit                                   # 退出gdb
# 
```

## 开始调试  

### 命令  
```
(gdb) start
```

### gdb给出的解释
```
start -- Run the debugged program until the beginning of the main procedure
start -- 运行调试程序，直到主程序开始
```

### 说明  
调试器会进入main函数，并停在main函数入口处。  

## 调试带参数的程序  

### 命令  
```
set args 参数1 参数2 参数3 ... 参数n
start
```
### 例子  
```
[root@localhost ~]# gdb
(gdb) file dmidecode
(gdb) set args -s system-serial-number
(gdb) start
```

## 下一步(相当于"F10")

### 命令
```
(gdb) next(可缩写为"n")
```

### gdb给出的解释
```
next -- Step program
next -- 步进程序。
```

## 进入函数(相当于"F11")

### 命令
```
(gdb) step(可缩写为"s")
```

### gdb给出的解释
```
step -- Step program until it reaches a different source line
step -- 步进程序，直到它到达了不同的源代码行。
```

## 跳出函数(相当于"Shift+F11")

### 命令
```
(gdb) finish
```

### gdb给出的解释
```
finish -- Execute until selected stack frame returns
finish -- 执行直到所选的堆栈帧返回。
```

## 开始运行(相当于启动调试时按"F5")

### 命令
```
(gdb) run(可缩写为"r")
```

### gdb给出的解释
```
run -- Start debugged program
run -- 开始被调试的程序。
```

## 继续运行(相当于调试过程中按"F5")

### 命令
```
(gdb) continue(可缩写为"c")
```

### gdb给出的解释
```
continue -- Continue program being debugged
continue -- 继续被调试的程序。
```

## 查看调用堆栈

### 命令
```
(gdb) backtrace(可缩写为"bt") 或 info stack
```

### gdb给出的解释
```
backtrace -- Print backtrace of all stack frames
backtrace -- 打印所有堆栈帧的追溯。
info stack -- Backtrace of the stack
info stack -- 堆栈的追溯。
```

## 调到编号为NUM的栈帧

### 命令
```
(gdb) frame <NUM>(可缩写为"f <NUM>")
```

### gdb给出的解释
```
frame -- Select and print a stack frame
frame -- 选择并打印某个栈帧。
```

## 跳出循环

### 命令
```
(gdb) until 循环之后的lineno
```

### gdb给出的解释
```
until -- Execute until the program reaches a source line greater than the current
until -- 设定一个比当前行号大的行，程序执行到该行时会被暂停住。
```

## 设置要调试的程序

### 命令
```
(gdb) file <FILE>
```

### gdb给出的解释
```
file -- Use FILE as program to be debugged
file -- 使用FILE作为程序进行调试
```

## 设置要调试的core文件  

### 命令  
```
(gdb) core-file <FILE>
```

### gdb给出的解释  
```
core-file -- Use FILE as core dump for examining memory and registers
core-file -- 使用FILE作为核心转储文件来检查内存和寄存器
```

### 例子  
例：假定我写了一个名为"test_exe"的程序。其源码路径为"/root/src_folder/"，其可执行文件路径为"/root/exe_folder/test_exe"，程序崩溃后自动生成了core.12345文件。此时，我要用gdb分析这次崩溃的话，我要：
```
# gdb                                        # 进入gdb
(gdb) directory "/root/src_folder/"          # 添加源码搜索路径(可选)
(gdb) file      "/root/exe_folder/test_exe"  # 使用test_exe作为要调试的程序(可选)
(gdb) core-file core.12345                   # 设置要分析的core文件
(gdb) backtrace                              # 查看调用堆栈
(gdb) frame NUM                              # 显示编号为NUM的那个栈帧
...(执行调试操作)...
(gdb) quit                                   # 退出gdb
#
```

## 给gdb添加源码搜索路径

### 命令
```
(gdb) directory <DIR>(可缩写为"dir <DIR>")
```

### gdb给出的解释
```
directory -- Add directory DIR to beginning of search path for source files
directory -- 将目录DIR添加到源文件的搜索路径的开头/搜索(源文件的)路径的开头。
```

## 查看gdb的源码搜索路径

### 命令
```
(gdb) show directories(可缩写为"show dir")
```

### gdb给出的解释
```
show directories -- Current search path for finding source files
show directories -- (查找源文件的)当前搜索路径。
```

## 查看变量的值

### 命令
```
(gdb) print <EXP>
```

### gdb给出的解释
```
print -- Print value of expression EXP
print -- 显示变量或表达式的值。
```

## 显示当前工作目录

### 命令
```
(gdb) pwd
```

### gdb给出的解释
```
pwd -- Print working directory
pwd -- 显示工作目录。
```

## 查看某表达式的数据类型

### 命令
```
(gdb) whatis <EXP>
```

### gdb给出的解释
```
whatis -- Print data type of expression EXP
whatis -- 打印表达式EXP的数据类型。
```

## 显示一个类/数据结构的定义

### 命令
```
(gdb) ptype <TYPE>
```

### gdb给出的解释
```
ptype -- Print definition of type TYPE
ptype -- 显示类型TYPE的定义。
```
