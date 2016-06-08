title: scala编程中文版
date: 2016-05-23 10:27:24
updated: 2016-05-23 10:27:25
comments:
tags:
- scala
categories:
- 

---


scala特点：面向对象、函数式、兼容Java、简洁、高级（代码复杂性）、静态类型

scala解释器

变量定义，scala具有类型推断的能力，即根据输入的value判断变量的类型，但是类型一旦设定就不能改变？所谓静态类型；

val设置的变量一旦初始化则不能再被修改，

以下写法结果相同：
val msg = "Hello world"
val msg: String = "Hello world"
val msg: java.lang.String = "Hello world"

函数定义

def max(x: Int, y: Int): Int = {
    if (x > y) x else y
}
def max(x: Int, y: Int): Int = if (x > y) x else y

def greeting() = println("Hello world")
def greeting(): Unit = println("Hello world")

scala脚本 args args(0)

函数式编程风格

args.foreach(arg => println(arg))
args.foreach((arg: String) => println(arg))
args.foreach(println)

类型参数化数组

val greetStrings = new Array[String](3)
greetStrings(0) = "Hello"

greetStrings作为new Array[String](3)不能被修改，但是可以给数组元素赋值

Array：元素在物理上连续存储；
List：元素在物理上的存储靠链表连接
元组：存储不同类型的元素，比如作为函数返回值
Set：唯一元素？
Map：key-value

函数式编程：没有副作用（println就是副作用之一）或var的函数

// 不推荐
def printArgs(args: Array[String]): Unit = {
    args.foreach(println)
}
// 推荐
def formatArgs(args: Array[String]) = args.mkString("\n")
println(formatArgs(args))

## 类和对象

class ChecksumAccumulator {
    private var sum = 0
    def add(b: Byte) { sum += b }
    def checksum(): Int = ~(sum & 0xFF) + 1
}
# 同一文件里，单例对象与某个类共享同一个名称，则其被成为伴生对象
# 伴生对象主要用于实现静态方法
object ChecksumAccumulator {
    def calculate(s: String): Int = {
        ......
    }
}

独立运行的scala程序，必须是object带有main方法，如下

Summer.scala

```scala
object Summer {
  def main(args: Array[String]) {
    println("object Summer")
  }
}
```

Scala提供了特质scala.Application，可以减少一些输入工作，比如以下代码减少了main函数的定义，但也带来了两个限制，如下：

+ 无法访问命令行参数（因为args数组不可访问了）
+ 对于多线程程序需要自行编写main方法
+ 某些JVM的实现没有优化被Application特质执行的对象的初始化代码

所以，只有当程序相对简单，并且是单线程情况下，才可以继承Application特质。

ExtendApp.scala

```scala
object ExtendApp extends App {
  println("object ExtendApp")
}
```


