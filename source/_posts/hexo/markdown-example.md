title: markdown语法示例
date: 2015-08-14 14:44:04
updated: 2015-08-17 10:54:39
comments: markdown语法示例
tags:
- markdown
categories:
- markdown
---
markdown语法样例整理，包括多级标题、有序列表、无序列表、引用、代码块、链接、图片、表格、特殊字符、反斜杠等初级和混合用法。主要满足文章结构划分、知识有序展示、内容便于阅读的要求。

## 多级标题

```
## 标题1
标题1的内容
### 标题1.1
标题1.1的内容
#### 标题1.1.1
标题1.1.1的内容
## 标题2
标题2的内容
```

<!-- more -->

## 列表

### 有序列表

1. 列表一
2. 列表二
3. 列表三

### 无序列表

+ 1
    * 1.1
    * 1.2
    * 1.3
+ 2
    * 2.1
    * 2.2
    * 2.3
+ 3
    * 3.1

## 代码块

```js
React.render(<HelloMessage name="foo" />, document.body);
React.render(<HelloMessage name="foo" />, document.body);
React.render(<HelloMessage name="foo" />, document.body);
```

混合显示代码写法`wordpress+jekyll`混合显示代码写法

## 引用

> ### 引用内的标题一
> 
> > 引用内的引用
> 
> + 无序列表一
> + 无序列表二 
> 
```bash
echo html # 引用内的代码块
echo html # 引用内的代码块
```
> 

+ 列表一
  正常内容
  > 列表一内的引用
  > 列表一内的引用
+ 列表二
  正常内容
  > 引用二
  > 引用二

## 表格

| Left | Center | Right | ttt |
|:-----|:------:|------:|----:|
|aaa   |bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb     |ccc    | ttt |
|ddd   |eee     |fff    | ttt |

---

 A | B 
---|---
123|456

---

A |B 
--|--
12|45

## 链接

[行内链接-百度](http://www.baidu.com "百度")
[参考式链接-百度][1] 参考式链接
[Google][] 谷歌

[1]: http://www.baidu.com "百度一下两下"
[google]: http://www.google.com "google地图"

## 图片

![在线图片](http://feimg.qiniudn.com/1002015r.jpg)

## 分割线

---

## 重点标记

*single asterisks*
_single underscores_
**double asterisks**
__double underscores__

Separates column by **pipe (|)** and header by **dashes (-)**, and uses *colon (:)* for alignment.
The outer **pipes (|)** and alignment are optional. There are *3 delimiters* each cell at least for separating header.

Inline link format like this: `[Link Text](URL "Title")`

## 特殊字符|转义字符|反斜杠

### 特殊字符

< > & @ AT&T 4 < 5
`&copy;` 被转义成 &copy;

### 转义字符和反斜杠

1\. 转义字符用法

\\   反斜线
\`   反引号
\*   星号
\_   底线
\{\}  花括号
\[\]  方括号
\(\)  括弧
\#   井字号
\+   加号
\-   减号
\.   英文句点
\!   惊叹号

## octpress插件用法

{% blockquote %}
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque hendrerit lacus ut purus iaculis feugiat. Sed nec tempor elit, quis aliquam neque. Curabitur sed diam eget dolor fermentum semper at eu lorem.
{% endblockquote %}

---

{% blockquote David Levithan, Wide Awake %}
Do not just seek happiness for yourself. Seek happiness for all. Through kindness. Through mercy.
{% endblockquote %}

---

{% blockquote @DevDocs https://twitter.com/devdocs/status/356095192085962752 %}
NEW: DevDocs now comes with syntax highlighting. http://devdocs.io
{% endblockquote %}

---

{% blockquote Seth Godin http://sethgodin.typepad.com/seths_blog/2009/07/welcome-to-island-marketing.html Welcome to Island Marketing %}
Every interaction is both precious and an opportunity to delight.
{% endblockquote %}

---

{% codeblock [title] [lang:language] [url] [link text] %}
code snippet
{% endcodeblock %}

---

{% codeblock lang:objc %}
[rectangle setX: 10 y: 10 width: 20 height: 20];
{% endcodeblock %}

---

{% codeblock Array.map %}
array.map(callback[, thisArg])
{% endcodeblock %}

---

{% codeblock _.compact http://underscorejs.org/#compact Underscore.js %}
_.compact([0, 1, false, 2, '', 3]);
=> [1, 2, 3]
{% endcodeblock %}

## 参考文档
+ [markdown官方语法](http://daringfireball.net/projects/markdown/syntax)
+ [markdown官方语法中文译文](http://www.appinn.com/markdown/)
+ [hexo主题参考](http://blog.zhangruipeng.me/hexo-theme-alex/2015/01/25/Markdown%20Example/)



