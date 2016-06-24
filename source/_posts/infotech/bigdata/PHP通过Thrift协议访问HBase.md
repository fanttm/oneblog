title: PHP通过Thrift协议访问HBase
date: 2016-06-21 14:42:59
updated: 2016-06-21 14:43:00
comments:
tags:
- php
- hbase
categories:
- 

---

虽然Java语言的使用者众多，但毕竟还是有很大部分开发者用了其它开发语言，因此HBase也针对性地提供了两种方式，REST接口服务和Thrift接口服务。

### REST网关

#### 启动REST服务

```bash
# 默认监听8080端口
./bin/hbase rest start
```

> 这种启动模式下，服务将运行在前台，如果需要运行在后台，请使用```./bin/hbase-daemon.sh start rest```命令启动服务

此时运行jps命令查看，会发现多了一个RESTServer进程。

#### 接口访问测试

```bash
# 返回hbaase中所有表名
curl http://localhost:8080/
# 返回指定表+行键+列族的内容
curl http://localhost:8080/myTable/rowKey/columnFamily
```

> 本次测试返回的都是文本数据结果，但上次测试返回的是Base64编码字符串，暂未发现这两次的区别。
> 如果是Base64编码字符串，则需要解码，```echo YWJjMTIz" | base64 --decode```

一般而言，HBase REST网关主要在简单测试或小规模部署中使用，如果是大规模线上应用，建议使用Thrift网关。

### Thrift网关

#### Thrift接口版本

目前Thrift接口已经有了两个版本，两者差别很大，无法兼容，官方目前推荐使用v2版本。希望了解两个版本的具体差别，可以下载HBASE源代码自行查看。

> http://mirrors.cnnic.cn/apache/hbase/1.2.1/网页中，下载hbase-1.2.1-src.tar.gz源代码文件，解压后，对比以下两个文件：
+ hbase-thrift/src/main/resources/org/apache/hadoop/hbase/thrift/Hbase.thrift
+ hbase-thrift/src/main/resources/org/apache/hadoop/hbase/thrift2/Hbase.thrift

#### 启动Thrift服务

> 使用Thrift2

```bash
# 默认监听9090端口
./bin/hbase thrift2 start
```

> 这种启动模式下，服务将运行在前台，如果需要运行在后台，请使用```./bin/hbase-daemon.sh start thrift2```命令启动服务

此时运行jps命令查看，会发现多了一个ThriftServer进程。

#### PHP访问接口案例

##### 编译Thrift协议

> 确认服务器上已安装autoconf automake make等工具

下载thrift最新版本，https://thrift.apache.org/，当前0.9.3版本，解压。

```bash
cd thrift-0.9.3
# 生成configure
./bootstrap.sh
# 生成Makefile，默认安装到/usr/local
./configure
# 编译安装
make && make install
```

##### 安装PHP包管理器composer

请自行搜索安装部署

##### 接口调用测试

手动部署较为复杂，正好已有先人帮忙整合代码，建议先行使用后，如果还想继续深入了解的话，可以自行手动尝试。

源码地址： https://github.com/Moln/php-thrift-optimize

下载到本地服务器后，根据使用说明，一共三个步骤：

1. ```composer install```，会自动下载安装thrift库
2. ```thrift -gen php THBaseService.thrift```，生成php相关的thrift代码
3. ```php bin/ThriftOptimize.php```，根据提示输入Hbase.THbaseService，则会自动生成相关代码

此时，修改THbaseServiceTest.php，将其中的table名修改后，运行```php THbaseServiceTest.php```即可测试。
