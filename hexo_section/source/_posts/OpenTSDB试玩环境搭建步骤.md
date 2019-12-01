---
title: OpenTSDB试玩环境搭建步骤
categories:
  - MyDefaultCategory
toc: true
date: 2018-08-17 00:38:13
tags:
---
安装 Java 8, HBase, Zookeeper, OpenTSDB 的操作步骤。

<!-- more -->

此文参考了以下链接：  
[OpenTSDB2.3.0安装部署](https://blog.csdn.net/u012842205/article/details/72817966)。  
[opentsdb+hbase的安装部署](https://www.jianshu.com/p/ba8f6e733886)。  
[openTSDB的安装与部署](https://blog.csdn.net/liu16659/article/details/81038756)。  
[OpenTSDB安装与使用](https://blog.csdn.net/liuxiao723846/article/details/52351919)。  

从`OpenTSDB 2.3 documentation`可以知道OpenTSDB依赖了HBase和Zookeeper。  

### 安装 Java 8
目前(2018-08)，最新版的 HBase 和 OpenTSDB 需要 Java 8 。
```
yum install java-1.8.0-openjdk-devel ( 运行 HBase 需要 java, 编译 OpenTSDB 需要 javac )
```
然后`find / -type f -name java`就知道java安装到哪里去了。  
`find / \( -path /dev -o -path /mnt/hgfs \) -prune -o -type f -name java -print`。  
在`/`下面(不包含`/dev`和`/mnt/hgfs`路径)寻找(类型是"文件")的("名字"是`java`)的文件。  
我的安装在了`/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.181-3.b13.el6_10.x86_64/bin/java`  
执行`vi ~/.bash_profile`并在最后添加
```shell
JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.181-3.b13.el6_10.x86_64
PATH=$PATH:$JAVA_HOME/bin
export JAVA_HOME
export PATH
```
并执行`source ~/.bash_profile`让设置生效。

### 安装 HBase
[Apache HBase – Apache HBase™ Home](https://hbase.apache.org/)。  
[hbase-2.1.0-bin.tar.gz](http://mirrors.tuna.tsinghua.edu.cn/apache/hbase/2.1.0/hbase-2.1.0-bin.tar.gz)。  
[Apache HBase ™ Reference Guide](https://hbase.apache.org/book.html)。  
[HBase安装 - HBase教程™](https://www.yiibai.com/hbase/hbase_installation.html)。  
```
mkdir -p /opt/mytest
cp ./hbase-2.1.0-bin.tar.gz /opt/mytest
tar -xf /opt/mytest/hbase-2.1.0-bin.tar.gz -C /opt/mytest
```
执行`vi ~/.bash_profile`并在最后添加
```shell
HBASE_HOME=/opt/mytest/hbase-2.1.0
PATH=$PATH:$HBASE_HOME/bin
export HBASE_HOME
export PATH
```
并执行`source ~/.bash_profile`让设置生效。  
打开`/opt/mytest/hbase-2.1.0//conf/hbase-site.xml`文件，在`configuration`中配置如下内容（略，可选）。  

### 安装 Zookeeper
[Zookeeper 安装_w3cschool](https://www.w3cschool.cn/zookeeper/zookeeper_installation.html)。  
[Apache ZooKeeper - Releases](http://zookeeper.apache.org/releases.html)。  
[zookeeper-3.4.12.tar.gz](https://mirrors.tuna.tsinghua.edu.cn/apache/zookeeper/stable/zookeeper-3.4.12.tar.gz)。  
```shell
cp ./zookeeper-3.4.12.tar.gz /opt/mytest
cd /opt/mytest
tar -xf zookeeper-3.4.12.tar.gz
cd zookeeper-3.4.12
cp /opt/mytest/zookeeper-3.4.12/conf/zoo_sample.cfg /opt/mytest/zookeeper-3.4.12/conf/zoo.cfg
# 视情况修改 conf/zoo.cfg 文件
```

### 安装 OpenTSDB
[OpenTSDB - A Distributed, Scalable Monitoring System](http://opentsdb.net/)。  
[opentsdb-2.3.1.tar.gz](https://github.com/OpenTSDB/opentsdb/releases/download/v2.3.1/opentsdb-2.3.1.tar.gz)。  
[Installation — OpenTSDB 2.3 documentation](http://opentsdb.net/docs/build/html/installation.html)。  
```shell
yum install gnuplot automake autoconf  # (源码编译需要Java,GnuPlot,Autotools,Make,Python,Git)
cp ./opentsdb-2.3.1.tar.gz /opt/mytest
cd /opt/mytest
tar -xf opentsdb-2.3.1.tar.gz
cd opentsdb-2.3.1
./build.sh
cp -r ./third_party/ ./build
./build.sh
# 此时应当编译成功了
# env COMPRESSION=NONE HBASE_HOME=/opt/mytest/hbase-2.1.0 ./src/create_table.sh
env COMPRESSION=NONE ./src/create_table.sh
mkdir -p /tmp/tsd
./build/tsdb tsd --port=4242 --staticroot=./build/staticroot --cachedir=/tmp/tsd --zkquorum=localhost:2181
#浏览器打开 http://127.0.0.1:4242
```

### 使用
[User Guide — OpenTSDB 2.3 documentation](http://opentsdb.net/docs/build/html/user_guide/index.html)。  
[Quick Start — OpenTSDB 2.3 documentation](http://opentsdb.net/docs/build/html/user_guide/quickstart.html)。  
[/api/put — OpenTSDB 2.3 documentation](http://opentsdb.net/docs/build/html/api_http/put.html)。  

#### 创建 metric
格式: `./tsdb mkmetric metric_name_1 metric_name_2 metric_name_n`。  
示例: `./tsdb mkmetric mydata.cpu.1s mydata.cpu.5s mydata.cpu.1m`。  
解释: `mydata.cpu.1s`和`mydata.cpu.5s`和`mydata.cpu.1m`的metric。

#### 用 telnet 上报数据
格式: `put metric_name_1 Unix时间戳 value tagK1=tagV1 tagK2=tagV2 tagKn=tagVn`。  
示例: `put mydata.cpu.1s 1514779200 0.6 host=machine1 collector=test_exe`。  
解释: 上报的`metric`=`mydata.cpu.1s`，时间=`20180101-120000`，主机`host`=`machine1`，采集程序`collector`=`test_exe`。

#### 用 HTTP 的 API 上报数据
[/api/put — OpenTSDB 2.3 documentation](http://opentsdb.net/docs/build/html/api_http/put.html)。  
```
curl -d '
{"metric":"mydata.cpu.1s",
  "timestamp":1514779200,
  "value":0.6,
  "tags":{
    "host":"machine1",
    "collector":"test_exe"
  }
}' "http://127.0.0.1:4242/api/put"
```

完。
