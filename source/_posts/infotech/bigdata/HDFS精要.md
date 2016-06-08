title: HDFS精要
date: 2016-05-25 10:00:55
updated: 2016-05-25 10:00:56
comments:
tags:
- hdfs
categories:
- 大数据

---

首先用户启动hdfs的守护进程的时候，那个用户就被归属为supergroup，这个supergroup用户当当与root用户，能够删除hdfs上面的所有文件，所以如果你的hdfs上面存储了比如hbase的数据信息，有这么一个超级用户存在，的确是比较危险的。 