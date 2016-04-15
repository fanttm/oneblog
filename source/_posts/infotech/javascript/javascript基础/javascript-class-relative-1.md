title: javascript的constructor|prototype|__proto__等总结
date: 2015-09-19 11:16:35
updated: 2015-09-19 11:16:37
tags:
categories:
- javascript
---

```
function Person() {}
var person = new Person()

typeof(person.__proto__)                            // object
typeof(Person.prototype)                            // object
typeof(person)                                      // object
typeof(Person)                                      // function
typeof(Person.__proto__)                            // function
typeof(Function.prototype)                          // function

Person.__proto__ === Function.prototype             // true
Function.prototype.isPrototypeOf(Person)            // true

person.__proto__ === Person.prototype               // true
Person.prototype.isPrototypeOf(person)              // true

person.__proto__ === person.constructor.prototype   // true
person.constructor === Person
person.constructor === person.__proto__.constructor // true

person.constructor.prototype === Person.prototype   // true
person.constructor.prototype instanceof Person      // false，Person是函数（构造函数），prototype是Ojbect子类
person.constructor.prototype instanceof Object      // true

person instanceof person.constructor                // true
person.__proto__ instanceof person.constructor      // false
person.__proto__ instanceof Object                  // true
```

Javascript中的所有对象都继承自Object

constructor是Object的一个属性，他指向：创建对象的函数的引用（指针）。（可以理解为constructor指向对象的构造函数）

prototype：构造器的原型，只有函数才具有这个属性,一般来说这个属性值应该是一个 "纯粹的" Object 类型对象("[object Object]")，如果过设置为其他类型，可能会有一些意外。

任何一个由构造器产生的对象都有__proto__属性，且此属性指向该构造器的prototype；所有构造器/函数的__proto__都指向Function的prototype（它是一个空函数（Empty function））

hasOwnProperty：如果对象obj上的属性property不是继承的来的，则obj.hasOwnProperty('property')返回true

delete：删除对象自身上的属性，不能删除继承来的属性，不能删除使用 var 声明的变量 ,不能删除函数声明，但是在如果在 firebug 和 IE9 的调试器里面执行代码，会发现全局变量被删除了，实际上这在页面上的代码中是不会发生的事。 另外，数组的 length 属性是不能删除的。

in：如果对象 obj  有属性 property(包括继承来的和不可列举属性)，不同于 for in 循环中的 in,for in 忽略了不可列举属性)， 则'property' in obj 返回 true，这个运算不存在于初期版本的javascript。 

propertyIsEnumerable：如果对象obj上的属性property可以被列举出来(可被 for in 循环遍历),则 obj.propertyIsEnumerable('property') 返回true，值得注意的是，propertyIsEnumerable对继承来的属性一律判断为false,这一般被认为是ECMA Script 规范的一个设计上的错误。

instanceof：如果obj对象是构造函数Fun的一个实例，则 obj instanceof Fun 返回 true，

值得注意的是，instanceof 并不检查 Fun 函数，其检测是基于"原形链"的，如果 Fun.prototype == obj.__proto__ 为 true, 或者 Fun.prototype.isPrototypeOf(obj)  为 true , 即 Fun.prototype.isPrototypeOf(obj) === true , 则 obj instcaneof Fun 返回 true . 

因此，即使 obj instanceof Fun 返回 true，obj 也可能不具有 Fun 构造器中定义的属性，因为 Fun 不一定是 obj 的构造器。


