title: ruby和gem环境安装部署
date: 2016-05-10 15:20:57
updated: 2016-05-10 15:20:59
comments:
tags:
- ruby
- gem
categories:
- 

---

## ruby环境安装

选择下载ruby-2.0.0-xxx.tar.gz下载、编译和安装。

```bash
# 网络搜索文章推荐安装到 /usr/local
./configure --prefix=/usr/local --enable-shared --enable-pthread --disable-install-doc --with-opt-dir=/usr/local/lib
# 个人推荐安装到 /usr/local/ruby 目录下
./configure --prefix=/usr/local/ruby --enable-shared --enable-pthread --disable-install-doc
```

安装完成后，将ruby可执行文件路径加入到PATH中

```
# .bashrc 或 .bash_profile 中
export PATH=/usr/local/ruby/bin:$PATH
```

### gem环境配置

gem作为包管理器，如果使用默认的源（https://rubygems.org/）,可能速度很慢，所以一般考虑替换成 https://ruby.taobao.org/ 或 https://gems.ruby-china.org/

在使用以下命令添加新源时：

```
gem sources --add https://gems.ruby-china.org/
```

可能会报错：

```
Error fetching https://gems.ruby-china.org/:
        SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed (https://gems.ruby-china.org/specs.4.8.gz)
```

此时，可用通过下载SSL证书，并在环境变量中新增变量的方式来解决：

```
# 下载证书
wget http://curl.haxx.se/ca/cacert.pem
# export环境变量（可以加到.bashrc或.bash_profile文件末尾）
export SSL_CERT_FILE=/path/cacert.pem
```

再次执行```gem sources --add https://gems.ruby-china.org/```即可正常执行。

## 参考文档

[关于 Windows 下证书无法验证问题](https://github.com/ruby-china/rubygems-mirror/wiki)

## rubygems镜像

+ https://rubygems.org/
+ https://ruby.taobao.org/
+ http://gems.ruby-china.org/