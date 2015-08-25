title: TortoiseGit访问Github无需输入密码配置方法（两种）
date: 2015-08-25 10:00:37
updated: 2015-08-25 10:00:41
tags:
categories:
---
## [Github官方指南](https://help.github.com/articles/generating-ssh-keys/)

Git环境建议：Git+TortoiseGit+OpenSSH；

TortoiseGit要选择OpenSSH作为默认的控制台。可在TortoiseGit安装时选择，也可以在Setting -> Network中配置。

> 可能会出现的问题：执行ssh-add时可能会出现Could not open a connection to your authentication agent问题，此时执行以下命令即可：
> 
```bash
ssh-agent bash
```

## 本机配置方式

当安装好Git环境后，运行 Git bash 命令，进入控制台，在用户目录下，会找到.gitconfig文件，其中包含了已经配置的name和email等信息。

```bash
$ ls -a ~/ | grep git
.gitconfig
```

只需在.gitconfig文件中增加一行内容：

```bash
[credential]      
    helper = store
```

再次输入用户名密码，就会被本机Git环境记录下来，保存在用户目录的.git-credentials文件中。

```bash
$ ls -a ~/ | grep git
.git-credentials
.gitconfig
```

