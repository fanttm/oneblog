title: Zookeeper精要
date: 2016-05-26 14:34:49
updated: 2016-05-26 14:34:50
comments:
tags:
- zookeeper
categories:
- 大数据

---

## 基本概念

Zookeeper 分布式服务框架是 Apache Hadoop 的一个子项目，它主要是用来解决分布式应用中经常遇到的一些数据管理问题，如：统一命名服务、状态同步服务、集群管理、分布式应用配置项的管理等。

Zookeeper 从设计模式角度来看，是一个基于观察者模式设计的分布式服务管理框架，它负责存储和管理大家都关心的数据，然后接受观察者的注册，一旦这些数据的状态发生变化，Zookeeper 就将负责通知已经在 Zookeeper 上注册的那些观察者做出相应的反应，从而实现集群中类似 Master/Slave 管理模式。

Zookeeper 不仅能够帮你维护当前的集群中机器的服务状态，而且能够帮你选出一个“总管”，让这个总管来管理集群，这就是 Zookeeper 的另一个功能 Leader Election。

Zookeeper 作为 Hadoop 项目中的一个子项目，是 Hadoop 集群管理的一个必不可少的模块，它主要用来控制集群中的数据，如它管理 Hadoop 集群中的 NameNode，还有 Hbase 中 Master Election、Server 之间状态同步等。

## 单机部署

单机部署很简单，解压后，将conf目录下的zoo_sample.cfg复制成zoo.cfg（使用默认配置即可），运行命令bin/zkServer.sh start即可。

## 参考文档

[分布式服务框架 Zookeeper](https://www.ibm.com/developerworks/cn/opensource/os-cn-zookeeper/)
[ZooKeeper安装配置](https://taoistwar.gitbooks.io/spark-operationand-maintenance-management/content/spark_relate_software/zookeeper_install.html)
[Zookeeper安装和配置](http://coolxing.iteye.com/blog/1871009)