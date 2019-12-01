---
title: VS因为宏定义和函数重名导致编译失败
categories:
  - Windows
  - MSVC
toc: false
date: 2019-01-03 23:54:58
tags:
---
略。
<!-- more -->
```c++
/*
因为无意中包含了<errno.h>, 其中有一个 errno 宏,
我又巧合地定义了一个 errno 成员函数,
然后就出现了比较奇怪的编译错误,
此时可以通过 #undef 取消宏定义.
google 的 protobuf 就出现了这个问题.
*/
#include <errno.h>

class MyObject
{
public:
//#ifdef errno
//#undef errno
    int errno() const;
//#endif
    // a type qualifier is not allowed on a nonmember function
    // cannot create a pointer or reference to a qualified function type (requires pointer-to-member)
};

inline int MyObject::errno() const {
    // inline specifier allowed on function declarations only
    return 0;
}

int main()
{
    MyObject obj;
    return obj.errno();
}
```
