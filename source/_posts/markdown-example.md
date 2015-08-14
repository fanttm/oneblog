title: markdown语法示例
date: 2015-08-14 14:44:04
---
## 参考文档
+ [markdown官方语法](http://daringfireball.net/projects/markdown/syntax)
+ [markdown官方语法中文译文](http://www.appinn.com/markdown/)
+ [hexo主题参考](http://blog.zhangruipeng.me/hexo-theme-alex/2015/01/25/Markdown%20Example/)

特殊字符

< > & @ AT&T 4 < 5
`&copy;` 被转义成 &copy;

## 标题1
标题1的内容
### 标题1.1
标题1.1的内容
#### 标题1.1.1
标题1.1.1的内容
## 标题2
标题二的内容

> 混合显示代码写法`wordpress+jekyll`混合显示代码写法

> 代码块的写法

```js
React.render(<HelloMessage name="foo" />, document.body);
React.render(<HelloMessage name="foo" />, document.body);
React.render(<HelloMessage name="foo" />, document.body);
```

> ## 引用内的标题一
> 
> 1. 列表一
> 2. 列表二
> 3. 列表三
> 
> *重点加粗*
> 
> > 引用内的引用
> 
> + 无序列表一
> + 无序列表二 
> + 无序列表三
>  
> <code>echo html</code>
> 
```bash
echo html # 引用内的代码块
echo html # 引用内的代码块
echo html # 引用内的代码块
```
> 
>

---

+ 列表一
  正常内容
  > 列表一内的引用
  > 列表一内的引用
+ 列表二
  正常内容
  > 引用二
  > 引用二

[行内链接-百度](http://www.baidu.com "百度")
[参考式链接-百度][1] 参考式链接
[Google][] 谷歌

[1]: http://www.baidu.com "百度一下两下"
[google]: http://www.google.com "google地图"

*single asterisks*
_single underscores_
**double asterisks**
__double underscores__

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

图片显示

![在线图片](http://feimg.qiniudn.com/1002015r.jpg)

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

---

Separates column by **pipe (|)** and header by **dashes (-)**, and uses *colon (:)* for alignment.
The outer **pipes (|)** and alignment are optional. There are *3 delimiters* each cell at least for separating header.

Inline link format like this: `[Link Text](URL "Title")`


