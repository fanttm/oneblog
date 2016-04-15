title: hexo-theme-next和微搜索
date: 2015-10-14 16:16:01
updated: 2015-10-14 16:16:04
tags:
- hexo
categories:
- hexo
---

全站搜索是每个博客站点必须的功能。HEXO没有提供自带的搜索功能，需要外部支持。

目前HEXO全站搜索的主要方案有swiftype和微搜索，意外地发现swiftype已经开始收费，只好转投微搜索，这家号称免费版本永久不收费。

在此记录下基于HEXO的主题NEXT的整合微搜索的步骤。

<!-- more -->

## （步骤一）注册微搜索

访问[微搜索](http://tinysou.com/)，并注册。

## （步骤二）创建搜索引擎

![创建engine](/images/hexo-next-tinysou-create-engine.png)
![engine列表](/images/hexo-next-tinysou-engine-list.png)

## （步骤三）添加待搜索站点域名

![在engine中添加待搜索站点域名](/images/hexo-next-tinysou-add-domain.png)
![在engine中待搜索站点域名列表](/images/hexo-next-tinysou-domain-list.png)

当域名对应的爬虫状态变为`finish`时，表示该站点的搜索索引已经创建完成。

## （步骤四）HEXO配置

微搜索的配置，并非在HEXO的配置中，而是在其主题THEME的配置文件中设置。以NEXT主题为例，配置如下：

```
# 微搜索
tinysou_Key: 687cxxxxxxxxxxxxx2df
```

tinysou_Key的值，参照下图获取。

![获取微搜索的KEY](/images/hexo-next-tinysou-get-enginekey.png)


## （步骤五）开始搜索

![搜索体验-1](/images/hexo-next-tinysou-try-1.png)
![搜索体验-2](/images/hexo-next-tinysou-try-2.png)





