title: Spark集群硬件配置要求
date: 2016-05-13 17:39:32
updated: 2016-05-13 17:39:34
comments:
tags:
- spark
categories:
- 

---

## 参考文档

+ [spark官网推荐硬件配置](http://ifeve.com/spark-hardware-provisioning/)
+ [Hadoop平台架构--硬件篇](http://www.itweet.cn/2016/01/26/Hadoop-Hardware-Planning/)
+ [INFOQ-Spark的硬件配置](http://www.infoq.com/cn/news/2014/08/spark-hardware-configure)
+ [SPARK硬件配置](http://ju.outofmemory.cn/entry/74070)

对于Hbase这样的低延迟的系统，就不要部署在同样的机器上面，避免干扰

当Spark没办法把所有的内容放在内存中计算的时候，它会把部分内容存储到硬盘当中，如果该节点上也有HDFS目录，可以和HDFS共用同一个块磁盘

Spark最少在运行8GB以上的内存的机器上面

Spark是网络绑定型的系统，使用10GB以上的网络，会使程序运行得更快，可以通过http://<driver-node>:4040来查看Spark shuffles在网络当中传输的数据量

Spark支持扩展数十个CPU核心一个机器，它实行的是线程之间最小共享。我们需要至少使用8-16个核心的机器

HBASE集群硬件要求
HDFS集群硬件要求

轻型处理配置（1U/machine）的：两个四核CPU，8GB内存，4个磁盘驱动器（1TB或2TB）。注意CPU密集型的工作，如自然语言处理涉及加载到RAM的大型模型在数据处理之前，应配置2GB内存每核心，而不是1GB内存每核心。
平衡计算配置（1U/machine）的两个四核CPU，16到24GB内存，4个磁盘驱动器直接连接使用的主板控制器（1TB或2TB）。这些往往是因为有两个主板和8个驱动器在一个单一的2U机柜的。
重配置存储（2U/machine）：两个四核CPU，16到24GB的内存，和12个磁盘驱动器（1TB或2TB）。这种类型的机器的功耗开始〜200W左右，处于闲置状态，可以去〜350W高活动时。
计算密集配置（2U/machine）：两个四核CPU，48-72GB的内存，8个磁盘驱动器（1TB或2TB）。这些都需要一个大的内存模型和沉重的参考数据缓存的组合时经常使用。

官网硬件配置要求

只要有可能，就尽量在HDFS相同的节点上部署Spark。最简单的方式就是，在HDFS相同的节点上独立部署Spark（standalone mode cluster），并配置好Spark和Hadoop的内存和CPU占用，以避免互相干扰（对Hadoop来说，相关的选项有 mapred.child.java.opts – 配置单个任务的内存，mapred.tasktracker.map.tasks.maximun和mapred.tasktracker.reduce.tasks.maximum – 配置任务个数）。当然，你也可以在一些通用的集群管理器上同时运行Hadoop和Spark，如：Mesos 或 Hadoop YARN。
如果不能将Spark和HDFS放在一起，那么至少要将它们部署到同一局域网的节点中。
对于像HBase这类低延迟数据存储来说，比起一味地避免存储系统的互相干扰，更需要关注的是将计算分布到不同节点上去。

Spark可以在8GB~几百GB内存的机器上运行得很好。不过，我们还是建议最多给Spark分配75%的内存，剩下的内存留给操作系统和系统缓存。

每次计算具体需要多少内存，取决于你的应用程序。如需评估你的应用程序在使用某个数据集时会占用多少内存，可以尝试先加载一部分数据集，然后在Spark的监控UI（http://<driver-node>:4040）上查看其占用内存大小。

之所以大幅度聚焦内存和CPU的利用，其主要原因就在于：对比IO和网络通信，Spark在CPU和内存上遭遇的瓶颈日益增多；Tungsten项目将是Spark自诞生以来内核级别的最大改动，以大幅度提升Spark应用程序的内存和CPU利用率为目标，旨在最大程度上压榨新时代硬件性能。

为什么CPU会成为新的瓶颈？这里存在多个问题：首先，在硬件配置中，IO带宽提升的非常明显，比如10Gbps网络和SSD存储（或者做了条文化处理的HDD阵列）提供的高带宽；从软件的角度来看，通过Spark优化器基于业务对输入数据进行剪枝，当下许多类型的工作负载已经不会再需要使用大量的IO；在Spark Shuffle子系统中，对比底层硬件系统提供的原始吞吐量，序列化和哈希（CPU相关）成为主要瓶颈。从种种迹象来看，对比IO，Spark当下更受限于CPU效率和内存压力。

在JVM上的应用程序通常依赖JVM的垃圾回收机制来管理内存。毫无疑问，JVM绝对是一个伟大的工程，为不同工作负载提供了一个通用的运行环境。然而，随着Spark应用程序性能的不断提升，JVM对象和GC开销产生的影响将非常致命。