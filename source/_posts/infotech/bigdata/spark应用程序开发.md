title: spark应用程序开发
date: 2016-05-13 17:42:47
updated: 2016-05-13 17:42:49
comments:
tags:
- spark
categories:
- 

---

### 参考文档

+ [使用IntelliJ IDEA配置Spark应用开发环境及源码阅读环境](http://blog.tomgou.xyz/shi-yong-intellij-ideapei-zhi-sparkying-yong-kai-fa-huan-jing-ji-yuan-ma-yue-du-huan-jing.html)
+ [官网-Creating and Running Your Scala Application](https://www.jetbrains.com/help/idea/2016.1/creating-and-running-your-scala-application.html)
+ [官网-Getting Started with SBT](http://www.jetbrains.com/help/idea/2016.1/getting-started-with-sbt.html?origin=old_help)
+ [使用 Scala 语言开发 Spark 应用程序](https://www.ibm.com/developerworks/cn/opensource/os-cn-spark-practice1/)
+ [spark ecological environment](https://taoistwar.gitbooks.io/spark-developer-guide/content/spark_brief/sparp_ecological_environment.html)
+ [Spark-submit提交任务到集群](http://blog.csdn.net/kinger0/article/details/46562473)

### 问题参考

+ [ClassNotFoundException anonfun when deploy scala code to Spark](http://stackoverflow.com/questions/33222045/classnotfoundexception-anonfun-when-deploy-scala-code-to-spark)
+ [用IDEA开发spark应用，发生java.lang.ClassNotFoundException的解决](http://blog.csdn.net/qq_22091165/article/details/40780331)

### 实战

开发环境可以搭建在Windows，也可以搭建在Ubuntu上，如果是在windows上搭建，到官网下载IDEA安装包直接安装即可使用；如果是在Ubuntu上，除了到官网下载指定平台的IDEA安装包外，还要注意Ubuntu（应该是所有Linux服务器）上，都需要JDK1.8的支持，即在PATH中需要加入类似```export IDEA_JDK=/usr/local/jdk1.8.0_91```的语句。

在Ubuntu中部署IDEA，可以直接在IDEA中运行spark程序，但是经过尝试，目前发现spark定时程序的输出似乎不能在console中打印出来。

在Windows中部署IDEA，暂时没有找到直接在IDEA中运行spark程序的办法，需要编译出jar包后，上传到部署spark的服务器，再使用submit方式运行spark程序。

一般而言，在windows中安装IDEA使用性能比安装在虚拟机中Ubuntu的IDEA要高不少，除了不能直接在IDEA中运行spark程序外，还是建议在windows中使用IDEA。

具体的spark程序开发详细说明，请参考文档，IDEA配置Spark应用开发环境及源码阅读环境](http://blog.tomgou.xyz/shi-yong-intellij-ideapei-zhi-sparkying-yong-kai-fa-huan-jing-ji-yuan-ma-yue-du-huan-jing.html)即可

> 注意在运行spark应用程序时，必须配置 VM options 为 -Dspark.master=local，否则会报错，报错内容起始部分见下文，可能是因为不指定成local，会造成spark访问不到HelloSpark文件的情况。
> ```
> 15/10/19 19:40:11 WARN TaskSetManager: Lost task 1.0 in stage 0.0 (TID 1, 127.0.0.1): java.lang.ClassNotFoundException: HelloSpark$$anonfun$1
> ```

