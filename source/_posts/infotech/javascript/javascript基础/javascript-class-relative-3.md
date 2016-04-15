title: javascript的继承
date: 2015-09-19 11:16:35
updated: 2015-09-19 11:16:37
tags:
categories:
- javascript
---

[讲解最清晰的参考文档](http://www.jianshu.com/p/a6c005228a75)
[官方的Object.create](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Object/create)

```
function AAA() {}
function BBB() {}
BBB.prototype = new AAA()
function CCC() {}
CCC.prototype = new BBB();

var ccc = new CCC()

ccc.constructor         // function AAA() {}

ccc instanceof CCC      // true
ccc instanceof BBB      // true
ccc instanceof AAA      // true

CCC.prototype.isPrototypeOf(ccc)
BBB.prototype.isPrototypeOf(ccc)
AAA.prototype.isPrototypeOf(ccc)

CCC.prototype.isPrototypeOf(ccc)
true
BBB.prototype.isPrototypeOf(ccc)
true
AAA.prototype.isPrototypeOf(ccc)
true
ccc.__proto__
BBB {}
ccc.__proto__.constructor
AAA() {}
ccc.__proto__.__proto__
AAA {}
ccc.__proto__.__proto__.__proto__
AAA {}constructor: AAA()__proto__: Object
ccc.__proto__.__proto__.__proto__.__proto__
Object {}
ccc.__proto__.__proto__.__proto__.__proto__.__proto__
null
ccc.__proto__.__proto__ === AAA.prototype
false
ccc.__proto__ === AAA.prototype
false
ccc.__proto__.__proto__.__proto__ === AAA.prototype
true
ccc.__proto__ === CCC.prototype
true
ccc.__proto__.__proto__ === BBB.prototype
true
BBB.prototype
AAA {}
AAA.prototype
AAA {}
```

