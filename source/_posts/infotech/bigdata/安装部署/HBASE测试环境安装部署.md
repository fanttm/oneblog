title: HBASE测试环境安装部署
date: 2016-06-08 15:13:24
updated: 2016-06-08 15:13:31
comments:
tags:
- hbase
categories:
- 大数据

---

HBASE集群安装需要使用到HDFS和ZOOKEEPER，这里作为开发环境的部署，仅使用HDFS，需要提前部署好HADOOP运行环境。

## HBASE安装部署（伪分布式）

### 官网下载TAR包

下载hbase-1.2.1-bin.tar.gz，解压移动到/opt目录

### 配置文件

./conf/hbase-site.xml

```xml
<configuration>
  <property>
    <name>hbase.rootdir</name>
    <value>hdfs://192.168.79.133:9000/hbase</value>
  </property>
  <property>
    <name>dfs.replication</name>
    <value>1</value>
  </property>
</configuration>
```

> 注意：事先需要创建hdfs://192.168.79.133:9000/下的hbase目录

### 启动hbase

```bash
root@ubuntu:/opt/hbase-1.2.1# ./bin/start-hbase.sh 
starting master, logging to /opt/hbase-1.2.1/bin/../logs/hbase-root-master-ubuntu.out
```

jps查看启动进程

```bash
root@ubuntu:/opt/hbase-1.2.1# jps
3303 Worker
2823 DataNode
4194 Jps
3021 SecondaryNameNode
3208 Master
3838 HMaster    # hbase进程
2691 NameNode
```

### 使用hbase命令行交互

```bash
root@ubuntu:/opt/hbase-1.2.1# ./bin/hbase shell
```

启动速度较慢，需耐心等待，启动后，可以执行list等命令进行交互操作

```bash
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/opt/hbase-1.2.1/lib/slf4j-log4j12-1.7.5.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/opt/hadoop-2.7.2/share/hadoop/common/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
HBase Shell; enter 'help<RETURN>' for list of supported commands.
Type "exit<RETURN>" to leave the HBase Shell
Version 1.2.1, r8d8a7107dc4ccbf36a92f64675dc60392f85c015, Wed Mar 30 11:19:21 CDT 2016

hbase(main):001:0> list
TABLE                  
flumeinputdata2            
1 row(s) in 0.5190 seconds

=> ["flumeinputdata2"]
hbase(main):002:0>
```


