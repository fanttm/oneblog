title: hexo简明手册
date: 2015-08-17 11:10:52
updated: 2015-08-17 11:10:58
comments: 
tags:
- hexo
categories:
- hexo
---

## hexo概述

Hexo是一款基于node.js的静态博客框架。
相比jekyll而言，它的主题（themes）更多，也更漂亮；同时，javascript/node.js将取代ruby/rails，成为更主流的编程语言和应用服务器，这两个原因是选择hexo的关键。

## hexo运行环境

Node.js + Git，建议将hexo运行环境配置和文档内容都保存在Github上。

> nodejs环境安装，有两种方式：下载源码包编译安装；nvm安装

### 安装hexo

```bash
$ npm install -g hexo-cli
```

### 初始化工作目录

```bash
$ hexo init <folder>
$ cd <folder>
$ npm install  # 视情况使用 sudo
```

### 工作目录结构

```bash
├── _config.yml         # hexo站点配置文件
├── package.json        # 应用程序配置清单，包括应用名称、依赖包等信息
├── public              # 默认的静态文件生成目录｛初始化时不会创建｝
├── scaffolds           # post、page、draft默认的文档结构，主要包括了front-matter内容
├── scripts             # 扩展hexo功能的脚本
├── source              # 内容文档
|   ├── _drafts         # 草稿目录
|   └── _posts          # 正式文档目录
└── themes              # 主题目录
```

## hexo主要配置

根目录_config.yml中，主要参数配置说明如下：

```bash
language: zh-Hans               # 注意，是 zh-Hans

url: http://oneblog.top         
root: /                         
# 如果url是http://oneblog.top/public，则root变为/public/
# 同时，nginx配置也应改为
# location /public {
#     root /opt/hexo/myblog;     # 内容文件放在 /opt/hexo/myblog/public 目录下   
# }

theme: next
```

### next主题配置

next主题根目录的_config.yml，主要参数配置说明如下：

```bash
scheme: Mist            # 页眉样式切换

sidebar: post           # 在post文档有章节目录需要显示时，自动展示sidebar
#sidebar: always        # 总是显示sidebar
#sidebar: hide          # 总是隐藏sidebar

auto_excerpt:           # 仅显示文章摘要，否则会在首页上显示每篇文章的完整内容，可能导致页面非常长。
  enable: true
  length: 300
```

## hexo文档写作

目前主要在sublime中创建编辑文档，因此不使用命令行`hexo new [layout] <title>`创建文档，而使用sublime的snippet功能快速生成hexo文档的front-matter内容。

（sublime snippet） hexo.post

```yaml
title: 
date: 
updated: 
comments: 
tags:
categories:
---
```

## hexo部署建议

从Github上`git pull`最新代码后，执行`hexo generate`，按照默认目录（public）生成最终静态文件，即可。

因为目前hexo开发环境和最终环境放在同一台服务器，因此直接由nginx指定root目录即可，暂时无需使用hexo提供的几种部署方式。

## hexo常见命令

目前可能会用到的hexo命令，如下：

```bash
$ hexo clean              # 当文档没有正常被更新时，用该命令清除缓存
$ hexo list <type>        # type: post page route tag
$ hexo version
$ hexo --safe             # Disables loading plugins and scripts.查找错误时使用
$ hexo --debug                      
```

## hexo深入

+ Tag Plugin
+ Asset Folders
+ Data Files
+ Permalinks
+ Templates
+ Variables
+ Helps
+ Internationalization (i18n)
