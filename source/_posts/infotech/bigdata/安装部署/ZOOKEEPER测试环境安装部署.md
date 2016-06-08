title: ZOOKEEPER测试环境安装部署
date: 2016-06-08 15:13:24
updated: 2016-06-08 15:13:31
comments:
tags:
- zookeeper
categories:
- 大数据

---


### 官网下载TAR包

下载zookeeper-3.4.8.tar.gz，解压移动到/opt

### 配置文件

从配置文件模板中复制，仅修改文件名称，无需修改内容（使用默认配置）

```bash
cp ./conf/zoo_sample.cfg ./conf/zoo.cfg
```

### 启动zookeeper

./bin/zkServer.sh start

```bash
root@ubuntu:/opt/zookeeper-3.4.8# ./bin/zkServer.sh start
ZooKeeper JMX enabled by default
Using config: /opt/zookeeper-3.4.8/bin/../conf/zoo.cfg
Starting zookeeper ... STARTED
```

