title: 遍历JSON和ARRAY数据
date: 2015-09-14 18:39:25
updated: 2015-09-14 18:39:29
tags:
- json
categories:
---

遍历JSON数据结构是个常见的数据处理需求。

## JSON|ARRAY数据遍历通用的两种方法

### for-in

```
var json = { "a": 1, "b": 2 };
for (var key in json) {
    console.log(key, json[key]);
}
```

> 注意： for-in会输出自有属性，可以使用hasOwnProperty函数判断是否自有属性，并进行过滤。

<!-- more -->

### jQuery-each

```
var json = { "a": 1, "b": 2 };
$.each(json, function(key, val) {
    console.log(key, val);
});
```

## 仅可用于ARRAY数组遍历的一种方法

### for

```
var json = { "a": 1, "b": 2 };
for (var i=0,len=json.length; i<len; i++) {
    console.log(i, json[i])
}
```

> 注意：json.length，json数据没有length属性

## ARRAY数组遍历特殊情况

### 数据缺失

> 当array数组中有缺失数据时，for和jQuery.each遍历时，会把空数据的位置也一并处理了。

```
var arr = []
arr[3] = "c"
for (var i=0,len=arr.length; i<len; i++) {
    console.log(i, arr[i]);
}
```
输出
```
0 undefined
1 undefined
2 undefined
3 "c"
```

> for-in不会输出空数据的位置，但是，会输出自有属性的信息

```
var arr = []
arr[3] = "c"
for (var key in arr) {
    console.log(key, arr[key]);
}
```
输出
```
3 c
remove Array.remove(from, to)
removeSvgByHref Array.removeSvgByHref(node)
removeNode Array.removeNode(node)
indexNode Array.indexNode(node)
```

### 自有属性

```
var arr = []
arr[3] = "c"
for (var key in arr) {
    // 自有属性过滤
    if (arr.hasOwnProperty(key)) {
        console.log(key, arr[key]);
    }
}
```


## 数据类型检测（ARRAY|简单对象(JSON)|空对象）

### 检测是否ARRAY

```
jQuery.isArray({})      // false
jQuery.isArray([])      // true
```

### 检测是否简单对象

> 也可以用于检测JSON数据，简单对象即是JSON数据结构

```
jQuery.isPlainObject([])        // false
jQuery.isPlainObject("{}")      // false
jQuery.isPlainObject({})        // true
jQuery.isPlainObject({"a":1,"b":{"c":{"d":{"e":2}}}})    // true
```

### 检测是否空对象

```
jQuery.isEmptyObject({});               // true
jQuery.isEmptyObject({ foo: "bar" });   // false
```

## 检测字符串是否JSON数据

```
var msg = "{\"a\":1}"
var IS_JSON = true;
try {
    var json = jQuery.parseJSON(msg);
} catch(err) {
    IS_JSON = false;
}
```
