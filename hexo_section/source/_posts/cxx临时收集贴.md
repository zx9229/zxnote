---
title: cxx临时收集贴
categories:
  - C/CXX
toc: false
date: 2019-07-09 18:52:53
tags:
---
略。
<!-- more -->

* C++的1句话读取文件内容到字符串
```c++
static void filename2content(const std::string& filename, std::string& content)
{
    std::copy(std::istreambuf_iterator<char>(std::ifstream(filename, std::ios_base::in | std::ios_base::binary).rdbuf()), std::istreambuf_iterator<char>(), std::back_inserter(content));
}
```
或
```c++
static void filename2content(const std::string& filename, std::string& content)
{
    content.clear();
    std::ifstream ifs;
    ifs.open(filename, std::ios_base::in | std::ios_base::binary);
    if (!ifs.is_open()) { return; }
    {
        ifs.seekg(0, std::ifstream::end);
        std::streamoff filesize = ifs.tellg();
        ifs.seekg(0, std::ifstream::beg);
        content.resize(std::size_t(filesize), 0x0);
        //ifs.read(&content[0], filesize);  // 读取到char*
        content.assign(std::istreambuf_iterator<char>(ifs), std::istreambuf_iterator<char>());  // 读取到std::string
    }
    ifs.close();
}
```
