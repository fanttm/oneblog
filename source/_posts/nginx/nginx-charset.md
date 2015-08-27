title: nginx编码参数charset设置
date: 2015-08-27 14:24:06
updated: 2015-08-27 14:24:09
tags:
categories:
---
在nginx配置文件里，有个`charset`配置参数，平时很少留意，这次遭遇了乱码问题，关注了一下。

简单来说，这个配置项，是用来设置nginx返回结果的编码格式，即在返回的 HTTP RESPONSE 的 HEADER 的 CONTENT-TYPE 中，加入 charset=utf8 这样的代码，如下：

```bash
Connection:keep-alive
Content-Type:text/plain; charset=utf8
Date:Thu, 27 Aug 2015 06:31:55 GMT
Server:openresty
Transfer-Encoding:chunked
```

在nginx.conf文件中，可以全局配置charset，也可以在server或location中配置charset。

<!-- more -->

```bash
http {
    ...
    charset  utf-8;
    ...
    include /etc/nginx/conf.d/*.conf;
}
```

```bash
server {
    listen       80;
    server_name  www.xxxxx.com xxxxx.com;

    location /apachedoc/ {
        charset  gbk;
    }
}
```

