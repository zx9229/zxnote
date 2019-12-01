---
title: golang的protobuf例子
categories:
  - Go
toc: false
date: 2018-08-06 23:47:12
tags:
---
摘要暂略。
<!-- more -->

### 一些参考网页
[Google Protocol Buffer 的使用和原理](https://www.ibm.com/developerworks/cn/linux/l-cn-gpb/index.html)。  
[grpc / grpc.io](https://grpc.io/)。  
[Go Quick Start](https://grpc.io/docs/quickstart/go.html)。  


### 在Windows下配置Go的gRPC环境

1. 安装golang
`Go version`。  
例如可以安装`go1.10.3.windows-amd64.msi`。

2. 安装git
例如可以安装`Git-2.18.0-64-bit.exe`。

3. 安装gRPC
`Install gRPC`。  
例如可以执行`go get -u -v google.golang.org/grpc`。  
然后执行命令`cd /d C:\Users\%USERNAME%\go\src\google.golang.org\grpc`应当可以切换到对应目录下。

4. 下载`protoc.exe`可执行文件
`Install Protocol Buffers v3`。  
`Install the protoc compiler that is used to generate gRPC service code.`。  
例如可以下载`protoc-3.6.1-win32.zip`。  
然后把`protoc.exe`加入到环境变量`PATH`中。  
或者把`protoc.exe`放到`C:\Users\%USERNAME%\go\bin\`目录下。

5. 安装Go的protoc插件
`install the protoc plugin for Go`。  
例如可以执行`go get -u -v github.com/golang/protobuf/protoc-gen-go`。  
然后执行命令`cd /d C:\Users\%USERNAME%\go\src\github.com\golang\protobuf\proto`应当可以切换到对应目录下。


### 一个例子

1. 创建`testProtocolBuffer`和`mytest`和`mytest.proto`和`test.go`。
```cmd
mkdir      C:\Users\%USERNAME%\go\src\my_code\testProtocolBuffer\mytest\
type NUL > C:\Users\%USERNAME%\go\src\my_code\testProtocolBuffer\mytest\mytest.proto
type NUL > C:\Users\%USERNAME%\go\src\my_code\testProtocolBuffer\test.go
```
然后目录树应当如下所示：
```
└─testProtocolBuffer    ( cd /d C:\Users\%USERNAME%\go\src\my_code\testProtocolBuffer )
   │  test.go
   │
   └─mytest
           mytest.proto
```

2. 令文件`mytest.proto`的内容如下所示：
```
syntax = "proto3";

package mytest;

message HelloworldData {
    int32  id = 1;   // ID
    string str = 2;  // str
    int32  opt = 3;  //optional field
}

message Person {
    string name = 1;
    int32 id = 2;    // Unique ID number for this person.
    string email = 3;
 
    enum PhoneType {
        MOBILE = 0;
        HOME = 1;
        WORK = 2;
    }
 
    message PhoneNumber {
        string number = 1;
        PhoneType type = 2;
    }
    repeated PhoneNumber phone = 4;
}
```

3. 生成gRPC代码
参照官网的命令，我们可以仿写出来自己的命令：
```
官网: protoc -I           helloworld/ helloworld/helloworld.proto --go_out=plugins=grpc:helloworld
自己: protoc --proto_path=./mytest/       mytest/mytest.proto     --go_out=plugins=grpc:./mytest/   (在testProtocolBuffer下)
自己: protoc --proto_path=./                     mytest.proto     --go_out=plugins=grpc:./          (在mytest下)
```
对于`protoc.exe`程序，我们可以`protoc --help`获取帮助：  
`Usage: protoc [OPTION] PROTO_FILES`  
`protoc  --proto_path=PATH  --go_out=OUT_DIR  PROTO_FILES`

4. 令文件`test.go`的内容如下所示：
```golang
package main

import (
	"fmt"
	"my_code/testProtocolBuffer/mytest"

	"github.com/golang/protobuf/proto"
)

func main() {
	persion := mytest.Person{}
	persion.Name = "zhangsan"
	persion.Phone = make([]*mytest.Person_PhoneNumber, 0)
	persion.Phone = append(persion.Phone, &mytest.Person_PhoneNumber{Number: "12312341234", Type: mytest.Person_MOBILE})
	persion.Phone = append(persion.Phone, &mytest.Person_PhoneNumber{Number: "12356785678", Type: mytest.Person_WORK})
	var err error
	var data []byte
	if data, err = proto.Marshal(&persion); err != nil {
		panic(err)
	}
	invalidData := new(mytest.HelloworldData)
	if err = proto.Unmarshal(data, invalidData); err != nil {
		fmt.Println("HelloworldData", err)
	} else {
		fmt.Println("HelloworldData", invalidData)
	}
	validData := new(mytest.Person)
	if err = proto.Unmarshal(data, validData); err != nil {
		fmt.Println("Person", err)
	} else {
		fmt.Println("Person", validData)
	}
}
```
然后在文件所在目录下`go build`应当可以通过。
