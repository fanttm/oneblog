title: hexo-next-theme使用指南
date: 2015-08-24 14:26:56
updated: 2015-08-24 14:27:02
tags:
- hexo
categories:
- hexo
---

[Next主题的官方文档](http://theme-next.iissnan.com/)，非常详细，推荐！

这里不再重复说明，仅列出了一些不容易注意到的使用技巧。

## [主题设定](http://theme-next.iissnan.com/theme-settings.html)

<!-- more -->

+ 自定义LOGO和主题图标
+ RSS链接
+ 标签云页面
+ 分类页面
+ 站点建立时间
+ 数字公式显示
+ 侧边栏头像
+ 侧边栏社交链接
+ About页面
+ 友情链接
+ 404页面

## 摘要设置

next支持三种摘要的设置方式：

+ 在文章中使用 `<!-- more -->` 手动进行截断
+ 在文章的 front-matter 中添加 description，并提供文章摘录
+ 自动形成摘要，在 主题配置文件 中添加：

```bash
auto_excerpt:
  enable: true
  length: 150
```

默认截取的长度为 150 字符，可以根据需要自行设定

> 推荐第一种方式，即使用 `<!-- more -->` 手动进行截断

第二种方式比较麻烦，需要多写一段文字；第三种方式的话，显示比较难看。

## 设置归档页面文章篇数

安装hexo插件，在站点目录下使用 `npm install --save` 安装如下扩展：

+ hexo-generator-index
+ hexo-generator-archive
+ hexo-generator-tag

安装完成后，在 站点配置文章 中，设定：

```bash
index_generator:
  per_page: 5

archive_generator:
  per_page: 20
  yearly: true
  monthly: true

tag_generator:
  per_page: 10
```

将 per_page 设定成所需要的篇数

## 设置 favicon

将 favicon 放置到站点的 source 目录下即可

## 站内搜索

支持[Swiftypes搜索](https://swiftype.com)，而且提供了[详细的使用说明](http://theme-next.iissnan.com/third-party-services.html)。

## 禁止用户评论

如需取消某个 页面/文章 的评论，在 md 文件的 front-matter 中增加 comments: false
