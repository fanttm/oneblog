title: spark计算模型和工作机制
date: 2016-05-17 17:17:30
updated: 2016-05-17 17:17:30
tags:
categories:
---

Spark站在巨人的肩膀上，依靠Scala强有力的函数式编程、Actor通信模式、闭包、容器、泛型，借助统一资源分配调度框架Mesos，融合了MapReduce和Dryad，最后产生了一个简洁、直观、灵活、高效的大数据分布式处理框架。

> 与Hadoop不同，Spark一开始就瞄准性能，将数据（包括部分中间数据）放在内存，在内存中计算。用户将重复利用的数据缓存到内存，提高下次的计算效率，因此Spark尤其适合迭代型和交互型任务。Spark需要大量的内存，但性能可随着机器数目呈多线性增长。

RDD操作起来与Scala集合类型没有太大差别，这就是Spark追求的目标：像编写单机程序一样编写分布式程序，但它们的数据和运行模型有很大的不同，用户需要具备更强的系统把控能力和分布式系统知识。

用户程序对RDD通过多个函数进行操作，将RDD进行转换。Block-Manager管理RDD的物理分区，每个Block就是节点上对应的一个数据块，可以存储在内存或者磁盘。而RDD中的partition是一个逻辑数据块，对应相应的物理块Block。本质上一个RDD在代码中相当于是数据的一个元数据结构，存储着数据分区及其逻辑结构映射关系，存储着RDD之前的依赖转换关系。

（1）RDD的两种创建方式
1）从Hadoop文件系统（或与Hadoop兼容的其他持久化存储系统，如Hive、
Cassandra、Hbase）输入（如HDFS）创建。
2）从父RDD转换得到新的RDD。
（2）RDD的两种操作算子
对于RDD可以有两种计算操作算子：Transformation（变换）与Action（行动）。
1）Transformation（变换）。
Transformation操作是延迟计算的，也就是说从一个RDD转换生成另一个RDD的转换操
作不是马上执行，需要等到有Actions操作时，才真正触发运算。
2）Action（行动）
Action算子会触发Spark提交作业（Job），并将数据输出到Spark系统。
（3）RDD的重要内部属性
1）分区列表。
2）计算每个分片的函数
3）对父RDD的依赖列表。
4）对Key-Value对数据类型RDD的分区器，控制分区策略和分区数。
5）每个数据分区的地址列表（如HDFS上的数据块的地址）。

与DSM相比，RDD模型有两个优势。第一，对于RDD中的批量操作，运行时将根据数据
存放的位置来调度任务，从而提高性能。第二，对于扫描类型操作，如果内存不足以缓存整个RDD，就进行部分缓存，将内存容纳不下的分区存储到磁盘上。
另外，RDD支持粗粒度和细粒度的读操作。RDD上的很多函数操作（如count和collect等）都是批量读操作，即扫描整个数据集，可以将任务分配到距离数据最近的节点上。同时，RDD也支持细粒度操作，即在哈希或范围分区的RDD上执行关键字查找。

在Transformations算子中再将数据类型维度细分为：Value数据类型和Key-Value对数据类型的Transformations算子。Value型数据的算子封装在RDD类中可以直接使用，Key-
Value对数据类型的算子封装于PairRDDFunctions类中，用户需要引入import org.apache.spark.SparkContext._才能够使用。进行这样的细分是由于不同的数据类型处理思想不太一样，同时有些算子是不同的。

在物理上，RDD对象实质上是一个元数据结构，存储着Block、Node等的映射关系，以及其他的元数据信息。一个RDD就是一组分区，在物理数据存储上，RDD的每个分区对应的就是一个Block，Block可以存储在内存，当内存不够时可以存储到磁盘上。


1）输入：在Spark程序运行中，数据从外部数据空间（如分布式存储：textFile读取HDFS等，parallelize方法输入Scala集合或数据）输入Spark，数据进入Spark运行时数据空间，转化为Spark中的数据块，通过BlockManager进行管理。
2）运行：在Spark数据输入形成RDD后便可以通过变换算子，如fliter等，对数据进行操
作并将RDD转化为新的RDD，通过Action算子，触发Spark提交作业。如果数据需要复用，
可以通过Cache算子，将数据缓存到内存。
3）输出：程序运行结束数据会输出Spark运行时空间，存储到分布式存储中（如saveAsTextFile输出到HDFS），或Scala数据或集合中（collect输出到Scala集合，count返回Scala int型数据）。

大致可以分为三大类算子。
1）Value数据类型的Transformation算子，这种变换并不触发提交作业，针对处理的数
据项是Value型的数据。
2）Key-Value数据类型的Transfromation算子，这种变换并不触发提交作业，针对处理
的数据项是Key-Value型的数据对。
3）Action算子，这类算子会触发SparkContext提交Job作业。


spark执行机制总览

Spark应用提交后经历了一系列的转换，最后成为Task在每个节点上执行。Spark应用转
换（见图4-1）：RDD的Action算子触发Job的提交，提交到Spark中的Job生成RDD DAG，由
DAGScheduler转化为Stage DAG，每个Stage中产生相应的Task集合，TaskScheduler将任
务分发到Executor执行。每个任务对应相应的一个数据块，使用用户定义的函数处理数据
块。

Spark执行的底层实现原理，如图4-2所示。在Spark的底层实现中，通过RDD进行数据
的管理，RDD中有一组分布在不同节点的数据块，当Spark的应用在对这个RDD进行操作
时，调度器将包含操作的任务分发到指定的机器上执行，在计算节点通过多线程的方式执行任务。一个操作执行完毕，RDD便转换为另一个RDD，这样，用户的操作依次执行。Spark
为了系统的内存不至于快速用完，使用延迟执行的方式执行，即只有操作累计到Action（行动），算子才会触发整个操作序列的执行，中间结果不会单独再重新分配内存，而是在同一个数据块上进行流水线操作。


spark应用概念

Spark应用（Application）是用户提交的应用程序。执行模式有Local、Standalone、YARN、Mesos。根据Spark Application的Driver Program是否在集群中运行，Spark应用的运行方式又可以分为Cluster模式和Client模式。图4-3为Application包含的组件。
应用的基本组件如下。
·Application：用户自定义的Spark程序，用户提交后，Spark为App分配资源，将程序转换并执行。
·Driver Program：运行Application的main（）函数并创建SparkContext。
·RDD Graph：RDD是Spark的核心结构，可以通过一系列算子进行操作（主要有Transformation和Action操作）。当RDD遇到Action算子时，将之前的所有算子形成一个有向无环图（DAG），也就是图中的RDD Graph。再在Spark中转化为Job，提交到集群执行。一个App中可以包含多个Job。
·Job：一个RDD Graph触发的作业，往往由Spark Action算子触发，在SparkContext中通过runJob方法向Spark提交Job。
·Stage：每个Job会根据RDD的宽依赖关系被切分很多Stage，每个Stage中包含一组相同的Task，这一组Task也叫TaskSet。
·Task：一个分区对应一个Task，Task执行RDD中对应Stage中包含的算子。Task被封装好后放入Executor的线程池中执行。


应用提交方式

·Driver进程运行在客户端，对应用进行管理监控。
·主节点指定某个Worker节点启动Driver，负责整个应用的监控。
Driver进程是应用的主控进程，负责应用的解析、切分Stage并调度Task到Executor执
行，包含DAGScheduler等重要对象。

spark调度和任务分配

从Spark整体上看，调度可以分为4个级别，Application调度、Job调度、Stage的调度、Task的调度与分发。


spark的I/O机制：序列化、压缩、spark块管理

spark通信模块：RPC RMI JMS EJB WEB-SERVICE（通信框架AKKA）

容错机制 Lineage机制 + checkpoint

此外，如果某个errors分区丢失，则Spark只在相应的lines分区上执行filter操作来重建该errors分区。，RDD的Lineage记录的是粗颗粒度的特定数据Transformation操作（如filter、map、join等）行为。当这个RDD的部分分区数据丢失时，它可以通过Lineage获取足够的信息来重新运算和恢复丢失的数据分区。

检查点（本质是通过将RDD写入Disk做检查点）是为了通过lineage做容错的辅助，lineage过长会造成容错成本过高，这样就不如在中间阶段做检查点容错，如果之后有节点出现问题而丢失分区，从做检查点的RDD开始重做Lineage，就会减少开销。

Shuffle的本义是洗牌、混洗，即把一组有一定规则的数据打散重新组合转换成一组无规则随机数据分区。Spark中的Shuffle更像是洗牌的逆过程，把一组无规则的数据尽量转换成一组具有一定规则的数据，Spark中的Shuffle和MapReduce中的Shuffle思想相同，在实现
节和优化方式上不同

为什么Spark计算模型需要Shuffle过程？我们都知道，Spark计算模型是在分布式的环境下计算的，这就不可能在单进程空间中容纳所有的计算数据来进行计算，这样数据就按照Key进行分区，分配成一块一块的小分区，打散分布在集群的各个进程的内存空间中，并不是所有计算算子都满足于按照一种方式分区进行计算。例如，当需要对数据进行排序存储时，就有了重新按照一定的规则对数据重新分区的必要，Shuffle就是包裹在各种需要重分区的算子之下的一个对数据进行重新组合的过程。


主要介绍了Spark的执行机制和调度机制，包括调度与任务分配机制、I/O机制、通信机制、容错机制和Shuffle机制。Spark在执行过程中由Driver控制应用生命周期。调度中，Spark采用了经典的FIFO和FAIR等调度算法对内部的资源实现不同级别的调度。在Spark的I/O中，将数据抽象以块为单位进行管理，RDD中的一个分区就是需要处理的一个块。集群中的通信对于命令和状态的传递极为重要，Spark通过AKKA框架进行集群消息通信。Spark通过Lineage和Checkpoint机制进行容错性保证，Lineage进行重算操作，Checkpoint进行数据冗余备份。最后介绍了Spark中的Shuffle机制，Spark也借鉴了MapReduce模型，但是其Shuffle机制进行了创新与优化。

RDDs support two types of operations: transformations, which create a new dataset from an existing one, and actions, which return a value to the driver program after running a computation on the dataset. For example, map is a transformation that passes each dataset element through a function and returns a new RDD representing the results. On the other hand, reduce is an action that aggregates all the elements of the RDD using some function and returns the final result to the driver program (although there is also a parallel reduceByKey that returns a distributed dataset).