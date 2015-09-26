title: jQuery事件命名空间 event namespace
date: 2015-09-24 12:31:50
updated: 2015-09-24 12:32:07
tags:
categories:
---
jQuery事件的命名空间初看觉得没啥，仔细用来起发现还是有些道道，在这次总结下，免得用起来手忙脚乱。

## 命名空间事件范例

带有命名空间的事件，一般是这种形式 `event.namespace1.namespace2.namesspace3`。

> 带命名空间的事件名称，最前面，必须是event名称，event后面只能是命名空间，可以带多个。

，比如bootstrap中常见的一些带命名空间的事件名称如下：

```
show.bs.tab
shown.bs.tab
hide.bs.tab
hidden.bs.tab
show.bs.tooltip
shown.bs.tooltip
hide.bs.tooltip
hidden.bs.tooltip
inserted.bs.tooltip
```

<!-- more -->

## 回调函数触发方式

> 注意，trigger的事件字符串中，最前面的必须是事件，如果不是事件而是命名空间的话，无法触发。

```
function handler(event) {
    console.log("trigger event: " + event.namespace);
}
var $body = $("body");
$body.on("doing.foo.bar.example", handler);         // A
$body.on("doing.foo.bar.", handler);                // B
$body.on("doing.foo.example", handler);             // C
$body.on("doing.foo.white", handler);               // D

$body.trigger("doing");     // 触发ABCD，输出四次 trigger event: 
$body.trigger(".foo");      // 没有输出
$body.trigger("foo");       // 没有输出
$body.trigger("doing.foo.bar.example"); // 触发A，输出 trigger event: bar.example.foo
$body.trigger("doing.foo.example");     // 触发AC，输出两次 trigger event: example.foo
$body.trigger("doing.bar.white");       // 没有输出（没有配置同时处于bar和white这两个命名空间的doing事件）

```
