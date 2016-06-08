title: HADOOP测试环境安装部署
date: 2016-05-13 16:45:21
updated: 2016-05-13 16:45:22
comments:
tags:
- hadoop
- hdfs
categories:
- 大数据

---

## 参考文档

+ [Hadoop安装教程-单机和伪分布式部署](http://www.powerxing.com/install-hadoop/)

## JDK和SCALA环境部署 

> 注意：以下操作均使用root用户

下载jdk（jdk-7u79-linux-x64.tar.gz）和scala（scala-2.10.6.tgz）后，将两者解压移动到/usr/local目录下，在~/.bashrc末尾添加以下代码：

```bash
export JAVA_HOME=/usr/local/jdk1.7.0_79
# IDEA_JDK这个变量是给IDEA使用的，只有设置了这个，IDEA才能正常运行
# IDEA2016版本需要使用JDK1.8（UBUNTU 1404）
export IDEA_JDK=/usr/local/jdk1.8.0_91
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib/dt.jar:${JAVA_HOME}/lib/tools.jar:${JRE_HOME}/lib
export SCALA_HOME=/usr/local/scala-2.10.6
export HADOOP_HOME=/opt/hadoop-2.7.2
export PATH=${SCALA_HOME}/bin:${JAVA_HOME}/bin:${HADOOP_HOME}/bin:${PATH}
```

> 注意scala版本必须是2.10.X（spark-1.6.1依赖）

## HADOOP安装部署（伪分布式）

### SSH无密码登录配置

```bash
cd ~/.ssh/                     # 若没有该目录，请先执行一次ssh localhost
ssh-keygen -t rsa              # 会有提示，都按回车就可以
cat ./id_rsa.pub >> ./authorized_keys  # 加入授权
```

### 下载hadoop

官网下载hadoop-2.7.2.tar.gz，解压后移动到/opt

### 单机模式

单机模式无需安装，可以直接运行。

```bash
mkdir input
cp ./etc/hadoop/*.xml input
./bin/hadoop jar ./share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.2.jar grep ./input ./output 'dfs[a-z.]+'
# 正常执行完成后，查看output文件夹验证处理结果
```

### 伪分布式部署

> 先删除之前用到的input和output文件夹（保持工作环境整洁）

#### 文件配置

配置三个文件core-site.xml、hdfs-site.xml、hadoop-env.sh，它们都位于./etc/hadoop目录下，配置内容如下：

##### core-site.xml

```xml
<configuration>
    <property>
         <name>hadoop.tmp.dir</name>
         <value>file:/opt/hadoop/tmp</value>
         <description>Abase for other temporary directories.</description>
    </property>
    <property>
         <name>fs.defaultFS</name>
         <value>hdfs://localhost:9000</value>
    </property>
</configuration>
```

##### hdfs-site.xml

```xml
<configuration>
    <property>
         <name>dfs.replication</name>
         <value>1</value>
    </property>
    <property>
         <name>dfs.namenode.name.dir</name>
         <value>file:/opt/hadoop/tmp/dfs/name</value>
    </property>
    <property>
         <name>dfs.datanode.data.dir</name>
         <value>file:/opt/hadoop/tmp/dfs/data</value>
    </property>
</configuration>
```

##### hadoop-env.sh

```bash
# 特别注意，这个地方必须修改，否则运行会报错找不到JAVA_HOME
export JAVA_HOME=/usr/local/jdk1.7.0_79
```

#### namenode格式化

```bash
./bin/hdfs namenode -format
```

结果输出倒数几行中，有以下内容的表示成功格式化。

```
Storage directory /opt/hadoop/tmp/dfs/name has been successfully formatted
```

#### 启动namenode和datanode守护进程

```
one@ubuntu:/opt/hadoop-2.7.2$ ./sbin/start-dfs.sh
Starting namenodes on [localhost]
localhost: starting namenode, logging to /opt/hadoop-2.7.2/logs/hadoop-one-namenode-ubuntu.out
localhost: starting datanode, logging to /opt/hadoop-2.7.2/logs/hadoop-one-datanode-ubuntu.out
Starting secondary namenodes [0.0.0.0]
The authenticity of host '0.0.0.0 (0.0.0.0)' can't be established.
ECDSA key fingerprint is a1:a3:46:41:ab:db:f5:ca:04:df:54:84:99:ba:59:2c.
Are you sure you want to continue connecting (yes/no)? yes
0.0.0.0: Warning: Permanently added '0.0.0.0' (ECDSA) to the list of known hosts.
0.0.0.0: starting secondarynamenode, logging to /opt/hadoop-2.7.2/logs/hadoop-one-secondarynamenode-ubuntu.out
```

#### 测试验证

jps查看进程

```
root@ubuntu:/opt/hadoop-2.7.2# jps
2823 DataNode
3167 Jps
3021 SecondaryNameNode
2691 NameNode
```

运行examples

```bash
./bin/hdfs dfs -mkdir -p /user/hadoop
./bin/hdfs dfs -mkdir /user/hadoop/input
./bin/hdfs dfs -put ./etc/hadoop/*.xml /user/hadoop/input
./bin/hdfs dfs -ls /user/hadoop/input
./bin/hadoop jar ./share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.2.jar grep input output 'dfs[a-z.]+'
```

#### WEB访问测试

访问http://localhost:50070/查看运行情况。

