title: Ubuntu的cron任务运行日志
date: 2015-10-06 17:39:25
updated: 2015-10-06 17:39:25
tags:
- crontab
categories:
---
Ubuntu服务器版本`Ubuntu 12.04.5 LTS`，最近配置了一个hexo自动生成的定时任务，可惜没有正常执行，想查看下到底什么原因，就要从cron日志中去发现。

```
sudo vi /etc/rsyslog.d/50-default.conf
cron.*              /var/log/cron.log     # 删除该行注释

sudo service rsyslog restart
sudo service cron restart

less /var/log/cron.log
```


[参考文档](http://www.linuxidc.com/Linux/2013-02/79044.htm)