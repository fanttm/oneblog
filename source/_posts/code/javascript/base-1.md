title: Javascript
date: 2015-011-06 11:49:29
updated: 2015-11-06 11:49:34
comments: 
tags:
categories:
---

[Javascript的连续赋值运算](http://www.iteye.com/topic/785445)
实际工作中，应该不会遭遇如此写法的语句。

```
var a = {n:1};  
var b = a; // 持有a，以回查  
a.x = a = {n:2};        // 等价于 a.x = (a = {n:2})
alert(a.x);// --> undefined  
alert(b.x);// --> [object Object]
```

```
function fun(){  
    var a = b = 5;  
}  
fun();  
alert(typeof a); // --> undefined  
alert(typeof b); // --> number ， b溢出成为了全局变量
```

> 连续赋值语句中，特别注意每个变量需要用var声明，否则未定义的变量会直接成为了全局变量

Javascript语句末尾是否需要加分号的问题，[参考文档](http://hax.iteye.com/blog/1563585)， [参考文档](http://www.blueidea.com/tech/web/2009/7261.asp)

> 建议不要在Javascript语句末尾加上分号。此时需要处理一些特殊情况，即在下一行的开头是 [ (  + - / 等时，上一行不会被自动加上分号；因此需要在下一行开头加上分号


document.querySelectorAll()返回的是NodeList，其只有item(idx)方法。
```
var divs = document.querySelectorAll('div');

[].forEach.call(divs, function(div) {
  // do whatever
  div.style.color = "red";
});
```

> Array.prototype.forEach.call(...)也是相同的用法，当然[].forEach.call(...)简洁。

还可以将NodeList转换成Array

```
var div_list = document.querySelectorAll('div'); // returns NodeList
var div_array = Array.prototype.slice.call(div_list); // 方法一，slice
var div_array = [...div_list];  // 方法二， ...
var div_array = Array.from(div_list);  // 方法三， Array.from
```

> ...是ES6中未确定的方法，暂不推荐使用
> Array.from用法很丰富，需要时再细查，以下几个例子可以看看

```
// Set
var s = new Set(["foo", window]);
Array.from(s);   
// ["foo", window]

// Map
var m = new Map([[1, 2], [2, 4], [4, 8]]);
Array.from(m);                          
// [[1, 2], [2, 4], [4, 8]]  

// String
Array.from("foo");                      
// ["f", "o", "o"]

// Using an arrow function as the map function to
// manipulate the elements
Array.from([1, 2, 3], x => x + x);      
// [2, 4, 6]

// Generate a sequence of numbers
Array.from({length: 5}, (v, k) => k);    
// [0, 1, 2, 3, 4]
```


```
SVG.supported = (function() {
  return !! document.createElementNS &&
         !! document.createElementNS(SVG.ns,'svg').createSVGRect
})()
```

