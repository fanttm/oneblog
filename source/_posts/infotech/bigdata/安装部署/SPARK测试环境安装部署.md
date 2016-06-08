title: SPARK测试环境安装部署
date: 2016-05-13 16:45:21
updated: 2016-05-13 16:45:22
comments:
tags:
- spark
categories:
- 大数据

---

## 参考文档

+ [spark运行环境安装](http://www.w2bc.com/article/46602)

## JDK和SCALA环境部署 

官网下载jdk（jdk-7u79-linux-x64.tar.gz）和scala（scala-2.10.6.tgz）后，解压移动到/usr/local目录下，在.bashrc末尾添加以下代码：

```bash
export JAVA_HOME=/usr/local/jdk1.7.0_79
# IDEA_JDK是给IDEA使用的，只有设置了这个，IDEA采用使用专门的JDK环境
export IDEA_JDK=/usr/local/jdk1.8.0_91
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib/dt.jar:${JAVA_HOME}/lib/tools.jar:${JRE_HOME}/lib
export SCALA_HOME=/usr/local/scala-2.10.6
export HADOOP_HOME=/opt/hadoop-2.7.2
export PATH=${SCALA_HOME}/bin:${JAVA_HOME}/bin:${HADOOP_HOME}/bin:${PATH}
```

> 注意scala版本必须是2.10.X，因为spark-1.6.1是如此要求的。


## spark部署（单机）

### 官网下载TAR包

下载spark-1.6.1-bin-hadoop2.6.tgz，解压移动到/opt目录

### 配置文件修改

./conf/spark-env.sh

```bash
#JDK安装路径
export JAVA_HOME=/usr/local/jdk1.7.0_79
#SCALA安装路径
export SCALA_HOME=/usr/local/scala-2.10.6
#主节点的IP地址
export SPARK_MASTER_IP=192.168.79.133
#分配的内存大小
# export SPARK_WORKER_MEMORY=200m
#指定hadoop的配置文件目录
export HADOOP_HOME=/opt/hadoop-2.7.2
export HADOOP_CONF_DIR=/opt/hadoop-2.7.2/etc/hadoop
#指定worker工作时分配cpu数量
# export SPARK_WORKER_CORES=1
#指定spark实例，一般1个足以
# export SPARK_WORKER_INSTANCES=1
#jvm操作，在spark1.0之后增加了spark-defaults.conf默认配置文件，该配置参数在默认配置在该文件中
# export SPARK_JAVA_OPTS
```

### 启动master和worker

```bash
./sbin/start-master.sh
# WEB访问http://192.168.79.133:8080/，可以看到SPARK URL: spark://192.168.79.133:7077
./sbin/start-slave.sh spark://192.168.79.133:7077
```

> 启动slave时，需要加上master的URL

#### 查看进程

```bash
one@ubuntu:/opt/spark-1.6.1-bin-hadoop2.6$ jps
48196 Jps
47211 SecondaryNameNode
46997 DataNode
48015 Master    # spark master
48136 Worker    # spark slave
46873 NameNode
```

> NameNode\SecondaryNameNode\DataNode是Hadoop相关进程
> Master\Worker是spark相关进程

#### 测试验证

```bash
# 准备测试用的文本文件
hdfs dfs -mkdir /user/spark
hdfs dfs -put README.md /user/spark
# 开始测试
./bin/spark-shell spark://192.168.79.133:7077
val textFile = sc.textFile("hdfs://localhost:9000/user/spark/README.md")
textFile.count()
```

#### WEB访问

访问http://localhost:8080/查看spark的master和slave运行情况。