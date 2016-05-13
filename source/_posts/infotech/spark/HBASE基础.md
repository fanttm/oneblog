title: HBASE基础
date: 2016-05-13 17:35:11
updated: 2016-05-13 17:35:13
comments:
tags:
- hbase
categories:
- 

---

## HBASE和Cassandra区别

Hbase更加适合于数据仓库、大型数据的处理和分析（如进行Web页面的索引等），而Cassandra则更适合于实时事务处理和提供交互型数据

Cassandra做的还不够好的一件事情就是MapReduce！对于不精通此项技术同学简单的解释一句，这是一个用于并行处理大量数据的系统，比如从上百万从网络上抓取的页面提取统计信息。MapReduce和相关系统，比如Pig和Hive可以和HBase一起良好协作，因为它使用HDFS来存储数据，这些系统也是设计用来使用HDFS的。如果你需要进行这样的数据处理和分析的话，HBase可能是你目前的最佳选择。

## HBASE查询模式

HBase的查询实现只提供两种方式：

+ 按指定RowKey获取唯一一条记录，get方法（org.apache.hadoop.hbase.client.Get）
+ 按指定的条件获取一批记录，scan方法（org.apache.hadoop.hbase.client.Scan）


实现条件查询功能使用的就是scan方式，scan在使用时有以下几点值得注意：

+ scan可以通过setCaching与setBatch方法提高速度（以空间换时间）；
+ scan可以通过setStartRow与setEndRow来限定范围。范围越小，性能越高。
  通过巧妙的RowKey设计使我们批量获取记录集合中的元素挨在一起（应该在同一个Region下），可以在遍历结果时获得很好的性能。
+ scan可以通过setFilter方法添加过滤器，这也是分页、多条件查询的基础。