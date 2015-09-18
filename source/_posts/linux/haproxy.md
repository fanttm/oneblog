title: 初步应用HAPROXY
date: 2015-09-18 10:54:16
updated: 2015-09-18 10:54:18
tags:
categories:
---
久仰HAPROXY大名已经很久了，昨日终于由于项目需要有机会进行了尝试，果然还是不错的。

项目中，由于网络限制的原因，tcp服务的访问必须要经由某台服务器进行中转。因为现网环境不便测试，所以使用了redis进行haproxy的tcp代理功能的验证。

## 安装部署

[haproxy下载地址](http://www.haproxy.org/download/1.5/src/)

```
cd haproxy-1.5.14
make TARGET=linux26
```

编译完成后，会在当前目录下生成可执行文件haproxy。

## haproxy的tcp代理配置

可以从src/examples目录下找到haproxy.cfg文件，参照进行修改。

以下配置，开放端口25000，提供tcp中转到本机12310端口（redis服务端口）的服务。

```
global
    log 127.0.0.1   local0
    log 127.0.0.1   local1 notice
    maxconn 4096
    daemon
    #debug
    #quiet

defaults
    log global
    option  dontlognull
    retries 3
    maxconn 2000

listen tcp_transfer
    mode tcp
    bind :25000
    server localhost1 127.0.0.1:12310
```


## 启动haproxy

```
./haproxy -f ./haproxy.cfg
```

## 测试验证

```
redis-cli -p 12310      # 先直接访问redis服务的12310端口，执行 keys *，get 等操作
redis-cli -p 25000      # 再访问haproxy的中转端口，执行相同命令，查看结果是否一致
```
