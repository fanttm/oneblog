title: javascript原生解析URL
date: 2015-09-19 11:16:35
updated: 2015-09-19 11:16:37
tags:
categories:
---

曾经一直认为使用javascript解析URL，最好要使用相应的JS库，今天突然找到了更简单的办法，值得记录一下。

```
var parser = document.createElement('a')

parser.href = "http://oneblog.top/2015/09/14/javascript/javascript-json/query?param1=111&param2=222"
>> "http://oneblog.top/2015/09/14/javascript/javascript-json/query?param1=111&param2=222"

parser.protocol
>> "http:"

parser.pathname
>> "/2015/09/14/javascript/javascript-json/query"

parser.search
>> "?param1=111&param2=222"

parser.host
>> "oneblog.top"
```
