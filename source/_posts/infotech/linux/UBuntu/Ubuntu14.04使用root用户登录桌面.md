title: Ubuntu14.04使用root用户登录桌面
date: 2016-05-30 17:42:54
updated: 2016-05-30 17:42:55
comments:
tags:
- ubuntu
categories:
- 

---

Ubuntu14.04桌面版，默认是不能使用root用户登录的。

如果确实需要root用户登录，在启用root账户之后，按照以下内容修改指定文件后，重启即可。

```bash

# vi root@ubuntu:~# cat /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf

[SeatDefaults]
autologin-user=root
user-session=ubuntu
greeter-show-manual-login=true

```
