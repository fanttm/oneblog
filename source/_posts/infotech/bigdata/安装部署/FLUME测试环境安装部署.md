title: FLUME测试环境安装部署及使用
date: 2016-06-08 15:13:24
updated: 2016-06-08 15:13:31
comments:
tags:
- flume
categories:
- 大数据

---


## Flume核心概念

+ Agent
  使用JVM 运行Flume。每台机器运行一个agent，但是可以在一个agent中包含多个sources和sinks。
+ Client
  生产数据，运行在一个独立的线程。
+ Source  
  从Client收集数据，传递给Channel。
+ Sink
  从Channel收集数据，运行在一个独立线程。
+ Channel 
  连接 sources 和 sinks ，这个有点像一个队列。
+ Events  
  可以是日志记录、 avro 对象等。

## Flume安装部署

Flume只需要下载官方TAR包，根据需要配置即可使用。

## Flume配置案例

### 监控本地文件变化增量读取并写入到远端服务器的HDFS文件

#### 客户端配置文件

./conf/flume-client.conf

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

#### 启动客户端程序

```bash
./bin/flume-ng agent --conf ./conf/ -f ./conf/flume-client.conf -n clientMainAgent -Dflume.root.logger=DEBUG,console
```

#### 服务端配置文件

./conf/flume-server.conf

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

#### 启动服务端程序

```bash
./bin/flume-ng agent --conf ./conf/ -f ./conf/flume-server.conf -n collectorMainAgent -Dflume.root.logger=DEBUG,console
```

