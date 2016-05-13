title: spark应用程序开发
date: 2016-05-13 17:42:47
updated: 2016-05-13 17:42:49
comments:
tags:
- spark
categories:
- 

---

## 参考文档

+ [使用IntelliJ IDEA配置Spark应用开发环境及源码阅读环境](http://blog.tomgou.xyz/shi-yong-intellij-ideapei-zhi-sparkying-yong-kai-fa-huan-jing-ji-yuan-ma-yue-du-huan-jing.html)
+ [官网-Creating and Running Your Scala Application](https://www.jetbrains.com/help/idea/2016.1/creating-and-running-your-scala-application.html)
+ [官网-Getting Started with SBT](http://www.jetbrains.com/help/idea/2016.1/getting-started-with-sbt.html?origin=old_help)
+ [使用 Scala 语言开发 Spark 应用程序](https://www.ibm.com/developerworks/cn/opensource/os-cn-spark-practice1/)
+ [spark ecological environment](https://taoistwar.gitbooks.io/spark-developer-guide/content/spark_brief/sparp_ecological_environment.html)
+ [Spark-submit提交任务到集群](http://blog.csdn.net/kinger0/article/details/46562473)

### 问题参考

+ [ClassNotFoundException anonfun when deploy scala code to Spark](http://stackoverflow.com/questions/33222045/classnotfoundexception-anonfun-when-deploy-scala-code-to-spark)
+ [用IDEA开发spark应用，发生java.lang.ClassNotFoundException的解决](http://blog.csdn.net/qq_22091165/article/details/40780331)

## 实战

从各方面考虑，我们建议在Unbuntu上搭建开发环境，包括spark运行环境和IDEA开发环境，这样可以直接运行测试，比较方便。具体参考[使用IntelliJ IDEA配置Spark应用开发环境及源码阅读环境](http://blog.tomgou.xyz/shi-yong-intellij-ideapei-zhi-sparkying-yong-kai-fa-huan-jing-ji-yuan-ma-yue-du-huan-jing.html)即可

> 注意在运行spark应用程序时，必须配置 VM options 为 -Dspark.master=local，否则会报错，见下文。
> ```
> 15/10/19 19:40:11 WARN TaskSetManager: Lost task 1.0 in stage 0.0 (TID 1, 127.0.0.1): java.lang.ClassNotFoundException: HelloSpark$$anonfun$1
> ```

因为不在localhost，必然会造成spark访问不到HelloSpark文件的情况。