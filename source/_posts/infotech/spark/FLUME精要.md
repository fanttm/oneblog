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

[Flume NG 简介及配置实战](http://my.oschina.net/leejun2005/blog/288136)  

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

