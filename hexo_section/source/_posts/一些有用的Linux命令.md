---
title: 一些有用的Linux命令
date: 2017-07-13 21:21:29
categories:
- Linux
tags:
---
有些Linux命令，虽然不太常用，但是值得记录下来备用。  

<!-- more -->

## (用sed)进行字符串替换  
### 命令  
```
sed    's/old_string/new_string/g' filename  # 将文件里的old_string全部替换为new_string,预览性质。
sed -i 's/old_string/new_string/g' filename  # 使用了"-i"选项就是真的修改filename了。
```
### 例子  
我们有大量的链接库，其命名规范为`Ui_NAME.dll`，比如"Ui.dll"、"Ui_fun1.dll"、"Ui_data1_to_data2.dll"。其在Linux下的命名为`libUi_NAME.so`。某配置文件configure.ini配有大量链接库的名字，其字符串格式为`value="./Ui_NAME.dll"`, 现在要将其批量替换为`value="./libUi_NAME.so"`，要怎么写替换命令。  
分析：  
sed的替换命令是支持正则表达式的，我们先写正则表达式匹配Windows下的字符串`value="./Ui_NAME.dll"`，为`value="\./Ui.*\.dll"`，我们为其分组成`(value="\./)(Ui.*\.)(dll)(")`，我们要在$1和$2之间插入"lib"，将$3替换成"so"，保留$4，如果你使用nodepad++的话，可以用正则表达式的选项将`(value="\./)(Ui.*\.)(dll)(")`替换成`$1lib$2so$4`进行测试，发现它是符合要求的。  
现在要将正则表达式整合到sed命令中去，需要将正则表达式中的元字符(在这里是小括号)和sed命令中的正斜杠进行转义，同时将`$1`替换成`\1`，然后就变成了
```
sed 's/\(value="\.\/\)\(Ui.*\.\)\(dll\)\("\)/\1lib\2so\4/g'  configure.ini
```
### 例子  
某文件是csv文件，各字段之间以逗号`,`分隔，每行有12个字段，最后一个字段后面是没有逗号的。现在我们要在第6个字段和第7个字段之间插入2个无效字段，在行尾再附加2个无效字段，以便进行其他任务。无效字段填入`placeholder`。要怎么写替换命令。  
过程：  
写出一个正则表达式匹配行首和前六个字段和剩余字段`^(([^,]*,){6})(.+)$`。  
写出替换的正则表达式`$1placeholder,placeholder,$3,placeholder,placeholder`。  
备注：`$1`,`$2`,`$3`等代表的是第几个分组的内容，你可以从左往右数小括号的左半部分，以确定分组的编号。  
搞一个demo性质的文件(比如取文件的前100行)，用Notepad++或其他可视编辑器验证我们书写的正则表达式，确保验证通过。  
备注：将正则表达式整合到sed中时，需要将"小括号"`()`和"花括号"`{}`和"至少匹配一次"`+`和"匹配0次或1次"`?`和"分支条件"`|`进行转义，(中括号`[]`不需要转义哈)，将`$1`替换成`\1`。
将正则表达式整合到sed命令中去，然后就变成了  
```
sed 's/^\(\([^,]*,\)\{6\}\)\(.\+\)$/\1placeholder,placeholder,\3,placeholder,placeholder/g' data.csv
```
### 备注  
对于sed在字符串替换中的几个特殊标识符`&`和`\1`至`\9`，参见`man sed`中`s/regexpp/replacement/`部分的说明。  

## 用awk查找(二维表内容的文件的)特定的行  
### 命令
```
awk -F '字段分隔符' '{ if($1=="某个值"){print $0} }'  "要搜索的文件名"
```
### 例子  
(awk中使用shell变量)有一个二维表内容的文件data.txt，字段之间用逗号分隔，文件中的第二个字段可能是无效字段，无效字段用"placeholder"填充，要将第二个字段是无效字段的行存到invalid.txt中备用。要求用shell脚本。  
```
#!/bin/bash
FIELD2="placeholder"
SRC_FILE="data.txt"
DST_FILE="invalid.txt"
awk -v f2="${FIELD2}" -F ',' '{ if($2==f2){print $0} }'  "${SRC_FILE}" > "${DST_FILE}"
```

## (用sed)对文件内容按照某字段进行排序  
### 命令  
```
sort --field-separator="字段分隔符" --general-numeric-sort --key=2 "文件1" "文件2" > "排序后的文件"
sort -t"字段分隔符"                 -g                     -k2     "文件1" "文件2" > "排序后的文件"
sort --field-separator="字段分隔符" --numeric-sort         --key=2 "文件1" "文件2" > "排序后的文件"
sort -t="字段分隔符"                -n                     --k2    "文件1" "文件2" > "排序后的文件"
```
### 例子  
字段以逗号分隔，先按照第二个字段正序排序，再按照第一个字段逆序排序：  
```
sort -t',' --key=2 --key=1r  data.txt
```
### 备注  
在`info sort`里可以找到`-g`和`-n`的区别。  

## 递归查找某目录下的(包含某字符串的)所有文件，只输出文件名  
### 命令  
```
find . -type f -iname "*.h" -or -iname "*.cpp" | xargs grep -il "字符串"
grep -ril "字符串" --include="*.cpp" --include="*.h"
```
### 备注  
可以在`man find`里面搜索`-not`和`-and`和`-or`以了解这几个操作符。  

## 递归查找某目录下的(不包含某字符串的)所有文件，只输出文件名  
### 命令  
```
find . -type f ! -iname "*.h" -and ! -iname "*.cpp" | xargs grep -il "字符串"
```
### 备注
可以用"!"对"-iname '*.h'"等参数进行取反。  

