title: javascript的继承
date: 2015-09-19 11:16:35
updated: 2015-09-19 11:16:37
tags:
categories:
- javascript
---

[参考文档一](http://www.cnblogs.com/snandy/archive/2012/09/01/2664134.html)
[参考文档二](http://blog.csdn.net/lmj623565791/article/details/24423881)
[参考文档三](http://jingyan.baidu.com/article/29697b912f9939ab20de3c8c.html)

```
Number.__proto__ === Function.prototype  // true
Boolean.__proto__ === Function.prototype // true
String.__proto__ === Function.prototype  // true
Object.__proto__ === Function.prototype  // true
Function.__proto__ === Function.prototype // true
Array.__proto__ === Function.prototype   // true
RegExp.__proto__ === Function.prototype  // true
Error.__proto__ === Function.prototype   // true
Date.__proto__ === Function.prototype    // true
```

JavaScript中有内置(build-in)构造器/对象共计12个（ES5中新加了JSON），这里列举了可访问的8个构造器。剩下如Global不能直接访问，Arguments仅在函数调用时由JS引擎创建，Math，JSON是以对象形式存在的，无需new。它们的__proto__是Object.prototype。如下

Math.__proto__ === Object.prototype  // true
JSON.__proto__ === Object.prototype  // true

[最变态最混乱的继承关系](http://blog.sina.com.cn/s/blog_70a3539f0102v41r.html)

