title: crontab中脚本的编写和加载方式
date: 2016-05-13 16:25:47
updated: 2016-05-13 16:25:49
comments:
tags:
- crontab
categories:
- 

---

由于crontab中的任务默认都是在nologin状态下运行，导致很多在login状态下可以执行的命令（脚本）无法在crontab中执行，这种情况下，目前整理了三种处理方式，见下文。

### 直接在脚本中设置环境变量

在脚本的编写中，直接加入```XXX=VALUE```的环境变量设置语句，这样直接保证了脚本可以正常运行。

```
# 设置环境变量
SHELL=/bin/bash
NVM_PATH=/home/one/.nvm/versions/node/v4.4.0/lib/node
NVM_DIR=/home/one/.nvm
PATH=/home/one/.nvm/versions/node/v4.4.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
NVM_BIN=/home/one/.nvm/versions/node/v4.4.0/bin
# 执行
hexo generate
```

### 执行脚本前先运行.bashrc文件

执行脚本前先运行.bashrc文件加载环境变量

```
* * * * * /bin/bash "source ~/.bashrc; /opt/hexo/auto_deploy.sh >> /opt/hexo/deploy.log 2>&1"
```

> 如果采用这种方式，一定要注意，一般.bashrc中都对nologin用户做了屏蔽，即nologin用户是无法执行.bashrc的，如果确实需要，必须修改.bashrc头部代码。以下这段代码是unbuntu14.04下的.bashrc头部代码

```
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac
```

所以，这么麻烦的话，一般不建议采用这种方式。

### 指定脚本采用login方式执行

在crontab中直接指定脚本采用login方式执行，代码如下，关键在其中的```-lc```

```
* * * * * /bin/bash -lc '/opt/hexo/auto_deploy.sh' >> /opt/hexo/deploy.log 2>&1
```
