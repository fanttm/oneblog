title: Flume精要
date: 2016-05-25 10:12:07
updated: 2016-05-25 10:12:09
comments:
tags:
- flume
categories:
- 大数据

---

参考文档

[Flume NG 简介及配置实战](http://my.oschina.net/leejun2005/blog/288136) 对于基本概念和入手操作讲解的很好

多参考官方User Guide，大多数配置都有详细说明

client

```bash
# clientMainAgent
clientMainAgent.channels = c1
clientMainAgent.sources  = s1
clientMainAgent.sinks    = k1 k2

# clientMainAgent Spooling Directory Source
clientMainAgent.sources.s1.type = spooldir
clientMainAgent.sources.s1.spoolDir  = /opt/proxy/nginx/logs
clientMainAgent.sources.s1.fileHeader = true
clientMainAgent.sources.s1.deletePolicy = immediate
clientMainAgent.sources.s1.batchSize = 1000
clientMainAgent.sources.s1.channels = c1
clientMainAgent.sources.s1.deserializer.maxLineLength = 1048576

# clientMainAgent FileChannel
clientMainAgent.channels.c1.type = file
clientMainAgent.channels.c1.checkpointDir = /var/flume/client/fchannel/spool/checkpoint
clientMainAgent.channels.c1.dataDirs = /var/flume/client/fchannel/spool/data
clientMainAgent.channels.c1.capacity = 200000000
clientMainAgent.channels.c1.keep-alive = 30
clientMainAgent.channels.c1.write-timeout = 30
clientMainAgent.channels.c1.checkpoint-timeout = 600

# clientMainAgent Sinks
# k1 sink
clientMainAgent.sinks.k1.channel = c1
clientMainAgent.sinks.k1.type = avro
# connect to CollectorMainAgent
clientMainAgent.sinks.k1.hostname = 192.168.79.133
clientMainAgent.sinks.k1.port = 41415 
# k2 sink
clientMainAgent.sinks.k2.channel = c1
clientMainAgent.sinks.k2.type = avro
# connect to CollectorBackupAgentz
clientMainAgent.sinks.k2.hostname = 192.168.79.133
clientMainAgent.sinks.k2.port = 41416

# clientMainAgent sinks group
clientMainAgent.sinkgroups = g1
clientMainAgent.sinkgroups.g1.sinks = k1 k2

# load_balance type
clientMainAgent.sinkgroups.g1.processor.type = load_balance
clientMainAgent.sinkgroups.g1.processor.backoff   = true
clientMainAgent.sinkgroups.g1.processor.selector  = random
```

server

```bash
# collectorMainAgent
collectorMainAgent.channels = c2
collectorMainAgent.sources  = s2
collectorMainAgent.sinks    =k1 k2

# collectorMainAgent AvroSource
#
collectorMainAgent.sources.s2.type = avro
collectorMainAgent.sources.s2.bind = 192.168.79.133
collectorMainAgent.sources.s2.port = 41415
collectorMainAgent.sources.s2.channels = c2

# collectorMainAgent FileChannel
#
collectorMainAgent.channels.c2.type = file
collectorMainAgent.channels.c2.checkpointDir = /var/flume/server01/fchannel/spool/checkpoint
collectorMainAgent.channels.c2.dataDirs = /var/flume/server01/one/fchannel/spool/data,/var/flume/server01/two/fchannel/spool/data
collectorMainAgent.channels.c2.capacity = 200000000
collectorMainAgent.channels.c2.transactionCapacity=6000
collectorMainAgent.channels.c2.checkpointInterval=60000
# collectorMainAgent hdfsSink
collectorMainAgent.sinks.k2.type = hdfs
collectorMainAgent.sinks.k2.channel = c2
collectorMainAgent.sinks.k2.hdfs.path = hdfs://192.168.79.133:9000/user/hadoop/flume%{dir}
collectorMainAgent.sinks.k2.hdfs.filePrefix =k2_%{file}
collectorMainAgent.sinks.k2.hdfs.inUsePrefix =_
collectorMainAgent.sinks.k2.hdfs.inUseSuffix =.tmp
collectorMainAgent.sinks.k2.hdfs.rollSize = 0
collectorMainAgent.sinks.k2.hdfs.rollCount = 0
collectorMainAgent.sinks.k2.hdfs.rollInterval = 240
collectorMainAgent.sinks.k2.hdfs.writeFormat = Text
collectorMainAgent.sinks.k2.hdfs.fileType = DataStream
collectorMainAgent.sinks.k2.hdfs.batchSize = 6000
collectorMainAgent.sinks.k2.hdfs.callTimeout = 60000
collectorMainAgent.sinks.k1.type = hdfs
collectorMainAgent.sinks.k1.channel = c2
collectorMainAgent.sinks.k1.hdfs.path = hdfs://192.168.79.133:9000/user/hadoop/flume%{dir}
collectorMainAgent.sinks.k1.hdfs.filePrefix =k1_%{file}
collectorMainAgent.sinks.k1.hdfs.inUsePrefix =_
collectorMainAgent.sinks.k1.hdfs.inUseSuffix =.tmp
collectorMainAgent.sinks.k1.hdfs.rollSize = 0
collectorMainAgent.sinks.k1.hdfs.rollCount = 0
collectorMainAgent.sinks.k1.hdfs.rollInterval = 240
collectorMainAgent.sinks.k1.hdfs.writeFormat = Text
collectorMainAgent.sinks.k1.hdfs.fileType = DataStream
collectorMainAgent.sinks.k1.hdfs.batchSize = 6000
collectorMainAgent.sinks.k1.hdfs.callTimeout = 60000
```

启动命令

```bash
# 单节点配置
./bin/flume-ng agent --conf ./conf/ --conf-file ./conf/flume-single.conf --name a1 -Dflume.root.logger=INFO,console
# 单节点配置（写入HDFS）
./bin/flume-ng agent --conf ./conf/ -f ./conf/flume-writetohdfs.conf -n agent1 -Dflume.root.logger=INFO,console
# 客户端配置
./bin/flume-ng agent --conf ./conf/ -f ./conf/flume-client.conf -n clientMainAgent -Dflume.root.logger=DEBUG,console
# 服务端配置
./bin/flume-ng agent --conf ./conf/ -f ./conf/flume-server.conf -n collectorMainAgent -Dflume.root.logger=DEBUG,console
```

the serializer is a class that converts the Flume Event into an HBase-friendly format.

官方文档 
[Streaming data into Apache HBase using Apache Flume](https://blogs.apache.org/flume/entry/streaming_data_into_apache_hbase)
参考文档
[Flume-ng将数据插入hdfs与HBase-0.96.0](http://www.aboutyun.com/thread-7912-1-1.html)

```bash
agent1.sinks.log-sink1.channel = ch1
agent1.sinks.log-sink1.type = org.apache.flume.sink.hbase.AsyncHBaseSink
agent1.sinks.log-sink1.table = flume
agent1.sinks.log-sink1.columnFamily = logs
agent1.sinks.log-sink1.column = info
agent1.sinks.log-sink1.serializer = org.apache.flume.sink.hbase.SimpleAsyncHbaseEventSerializer
```

遭遇问题

2016-05-26 10:31:57,450 (conf-file-poller-0) [ERROR - org.apache.flume.node.PollingPropertiesFileConfigurationProvider$FileWatcherRunnable.run(PollingPropertiesFileConfigurationProvider.java:145)] Failed to start agent because dependencies were not found in classpath. Error follows.
java.lang.NoClassDefFoundError: org/apache/hadoop/hbase/HBaseConfiguration
    at org.apache.flume.sink.hbase.AsyncHBaseSink.configure(AsyncHBaseSink.java:393)
    at org.apache.flume.conf.Configurables.configure(Configurables.java:41)
    at org.apache.flume.node.AbstractConfigurationProvider.loadSinks(AbstractConfigurationProvider.java:413)
    at org.apache.flume.node.AbstractConfigurationProvider.getConfiguration(AbstractConfigurationProvider.java:98)
    at org.apache.flume.node.PollingPropertiesFileConfigurationProvider$FileWatcherRunnable.run(PollingPropertiesFileConfigurationProvider.java:140)
    at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:471)
    at java.util.concurrent.FutureTask.runAndReset(FutureTask.java:304)
    at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.access$301(ScheduledThreadPoolExecutor.java:178)
    at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.run(ScheduledThreadPoolExecutor.java:293)
    at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1145)
    at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:615)
    at java.lang.Thread.run(Thread.java:745)


在./conf/flume-env.sh中加入```FLUME_CLASSPATH="/opt/hbase-1.2.1/lib/*"```即可解决该问题

问题参考
[Flume to HBase dependencie failure](http://stackoverflow.com/questions/28600781/flume-to-hbase-dependencie-failure)
[Flume agent failed because dependencies were not found in classpath.](https://community.hortonworks.com/questions/22067/flume-agent-failed-because-dependencies-were-not-f.html)


如果需要控制如何拆分字段到hbase指定的字段，则需要自行编写serializer代码HbaseEventSerializer类，在apache-flume-1.6.1-src/flume-ng-sinks/flume-ng-hbase-sink/src/main/java中定义自己的类，实现flume中的HbaseEventSerializer接口，需要重新编译来实现。


## flume和kafka

在flume 1.6中，才正式集成了flume-kafka插件（https://github.com/thilinamb/flume-ng-kafka-sink）

```
# kafka作为sink的配置
a1.sinks.k1.type = org.apache.flume.sink.kafka.KafkaSink
a1.sinks.k1.topic = mytopic
a1.sinks.k1.brokerList = localhost:9092
a1.sinks.k1.requiredAcks = 1
a1.sinks.k1.batchSize = 20
a1.sinks.k1.channel = c1
```

### CDH相关配置

参考文档 
+ [Flafka: Apache Flume Meets Apache Kafka for Event Processing](http://blog.cloudera.com/blog/2014/11/flafka-apache-flume-meets-apache-kafka-for-event-processing/)
+ [Using Kafka with Flume](http://www.cloudera.com/documentation/kafka/latest/topics/kafka_flume.html)