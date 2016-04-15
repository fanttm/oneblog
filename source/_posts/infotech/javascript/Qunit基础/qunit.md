title: Javascript的单元测试利器QUnit
date: 2015-09-28 16:26:42
updated: 2015-09-28 16:26:45
tags:
- qunit
categories:
---
十年前就听说过测试驱动开发，记得当时也很期望能在项目中应用，可是不知不觉一拖至今。最终还是因为做云图智这个产品，起初知识为了保证内部数据在各种操作后的正确性，避免不断的功能迭代可能带来的内部数据的错误，才开始真正有了做单元测试的意愿。

再次证明了一点，只有真正强烈的意愿，才有真正实施的动力；所以很可能我们总是在不经意间欺骗自己......

单元测试这东西，就上手而言，绝对是简单的，可以预见的未来，也不会有太复杂的地方。真正用一次，相信你一定会爱上它。因为它能够大大减少你在产品上测试的时间，大大降低你对产品BUG的莫名的担忧，让你的人生一下子有了舒展的希望。

单元测试写的好不好，就我个人的看法，技术上没有难度，而是在于对业务的理解以及自身代码的设计水平。

<!-- more -->

以下记录下，我对QUnit的学习情况，以备查询。

## 单元测试概述（官方）

官网上， Introduction to Unit Testing 都对单元测试做了简单的介绍，没有细看，应该也就是说明一下可以把一些测试项总结出来做成单元测试，有利于代码的重构。

Cookbook中对单元测试的相关方面做了介绍，包括：
+ Automate unit test
+ Assert Result
+ Syn Callbacks
+ Asyn Callbacks（异步处理）
+ Test user actions
+ keeping test atomic（原子性）
+ Group test（模块化）
+ Custom Assertions（自定义断言方法）

大部分QUnit中的代码都很容易理解，按照分类整理如下：

## Assert断言

QUnit.test()

+ ok notOk
+ equal notEqual
+ propEqual notPropEqual
+ strictEqual notStrictEqual
+ deepEqual notDeepEqual

## 异步处理（async）


## 预设预期（expect）


## 自定义断言（push）


## 模块化单元测试（module）

QUnit.module()

## 各阶段回调函数

QUnit.begin()
    QUnit.moduleStart()
        QUnit.testStart()
            QUnit.log()
        QUnit.testDone()
    QUnit.moduleDone()
QUnit.done()

## 扩展用法（extend）

QUnit.extend()

## 输出堆栈内容（stack）

QUnit.stack()

## 待进一步调查

+ throws
+ QUnit.skip()
+ QUnit.config
+ QUnit.dump.parse()


