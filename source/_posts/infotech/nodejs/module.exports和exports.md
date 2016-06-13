title: module.exports和exports
date: 2016-06-13 17:31:10
updated: 2016-06-13 17:31:17
comments:
tags:
- nodejs
categories:
- nodejs

---

模块module是nodejs中代码的基本组成，弄明白module.exports和exports，有助于提高代码的质量。

### 基础概念

先看看nodejs基础代码中的定义，从这段代码看出：
+ exports只是module.exports的引用，默认指向空对象{}；
+ require模块后，返回给调用者的是module.exports，而不是exports

```
exports = module.exports = {}; 
```

### 基本应用

#### exports仅能用于定义对象属性

exports仅仅只是module.exports = {}的引用，那么exports就不能用重新赋值来处理，即```exports = xxxxx```的形式在require时必然会报错的；而是只能使用```exports.xxx = yyy```的赋值方式。

错误示例：

```
exports = nano = function database_module(cfg) {return;}
```

#### module.exports才能赋予属性外的值

正确示例：

```
module.exports = exports = nano = function database_module(cfg) {return;}
module.exports = 'ROCK IT!';
module.exports = ['Lemmy Kilmister', 'Ozzy Osbourne', 'Ronnie James Dio', 'Steven Tyler', 'Mick Jagger'];
```

### 参考文档

+ [Node.js中exports与module.exports的区别](http://weizhifeng.net/node-js-exports-vs-module-exports.html)
+ [module.exports vs exports in Node.js](http://stackoverflow.com/questions/7137397/module-exports-vs-exports-in-node-js)
+ [module.exports 与 exports](http://www.ghostchina.com/module-exports-and-exports-in-node-js/)