---
title: curl相关
categories:
  - Linux
toc: false
date: 2019-07-08 15:58:33
tags:
---
略
<!-- 略 -->

* 下载curl
[curl - Download](https://curl.haxx.se/download.html)。  
[curl for Windows](https://curl.haxx.se/windows/)。  

* 上传文件
`curl -F "file=@localfile;filename=nameinpost" url.com`。  
`To force the ’content’ part to be a file, prefix the file name with an @ sign.`。  

* 下载文件
`curl -O https://www.baidu.com/index.html`。  
`curl -o homepage.txt https://cn.bing.com/`。  

* sftp上传下载文件
[curl 使用举例详解(一）](https://blog.csdn.net/cmzsteven/article/details/73382333)。  
```shell
curl --insecure -T test.txt -u 用户:密码 sftp://主机:端口/tmp/
curl --insecure -T test.txt -u 用户:密码 sftp://主机:端口/tmp/test.log
curl --insecure -O          -u 用户:密码 sftp://主机:端口/tmp/test.log
curl --insecure -o test.txt -u 用户:密码 sftp://主机:端口/tmp/test.log
```

* sftp远端的几种写法示例
```shell
curl --insecure -T test.txt    -u 用户:密码                      sftp://主机:端口/
curl --insecure -T test.txt    -u 用户: --key OpenSSHprivateKey sftp://主机:端口/
curl --insecure -T test.txt    sftp://用户:密码@主机:端口/
curl --insecure -T test.txt    --key OpenSSHprivateKey sftp://用户@主机:端口/
curl --insecure -T test.txt    --key OpenSSHprivateKey sftp://用户:@主机:端口/
```
