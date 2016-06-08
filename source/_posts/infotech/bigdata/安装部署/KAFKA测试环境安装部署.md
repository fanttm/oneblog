title: KAFKA测试环境安装部署
date: 2016-06-08 15:13:24
updated: 2016-06-08 15:13:31
comments:
tags:
- kafka
categories:
- 大数据

---

### 官网下载TAR包

下载kafka_2.10-0.10.0.0.tgz，解压移动到/opt目录

### 启动kafka

使用默认配置启动kafka

#### 启动zookeeper

如果zookeeper没有启动，kafka中也在其中集成了，可以直接在kafka中启动zookeeper

```bash
./bin/zookeeper-server-start.sh config/zookeeper.properties
```

#### 启动kafka

```bash
./bin/kafka-server-start.sh config/server.properties
```

### 验证测试

#### 创建topic

```bash
./bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic test
```

查看创建的topic

```bash
./bin/kafka-topics.sh --list --zookeeper localhost:2181
```

#### 发送消息

```bash
./bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test
This is a message
This is another message
```

#### 读取消息

```bash
./bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic test --from-beginning
This is a message
This is another message
```

