title: sublime插件推荐
date: 2015-08-19 09:17:18
updated: 2015-08-19 09:17:23
comments:
tags:
- sublime plugins
categories:
- sublime

---

## SFTP
远程服务器文件编辑、同步插件。
+ 付费说明
  虽然是需要付费的，但是不付费的情况下，也仅仅会提示要付费，功能使用方面没有差异。）
+ 简单配置
  在sublime的sidebar中指定目录上右键， SFTP/FTP -> Map to Remote...，就会在该目录下生成sftp-config.json文件，配置参考如下：

```bash
    "upload_on_save": true,

    "host": "xxx.xxx.xxx.xxx",
    "user": "xxxxx",
    "password": "xxxxx",
    //"port": "22",

    "remote_path": "/xxx/xxx/xxx/",
    "ignore_regexes": [
        "\\.sublime-(project|workspace)", "sftp-config(-alt\\d?)?\\.json", "node_modules",
        "sftp-settings\\.json", "/venv/", "\\.svn/", "\\.hg/", "\\.git/",
        "\\.bzr", "_darcs", "CVS", "\\.DS_Store", "Thumbs\\.db", "desktop\\.ini"
    ],
```

<!-- more -->

+ 基本用法
    当sftp-config.json中的`upload_on_save`被设置成true时，该文件夹的的文件修改保存后，会自动连接到指定服务器，并在指定的目录下查找是否有相同文件名存在，如果存在，则会自动同步上去。（并未严格要求服务器目录和本地目录所有文件都一致）

## [Emmet](https://github.com/sergeche/emmet-sublime)
快速编辑HTML和CSS的工具。[官网](http://emmet.io/)
用法推荐阅读，http://www.iteye.com/news/13149

## [Sublime Navigation History](https://github.com/timjrobinson/SublimeNavigationHistory)
代码的Jump back|Jump forward功能。sublime text 3已经在内置该功能。其Jump back的默认快捷键是`Alt+minus`，即`Alt+-`；似乎没有默认的Jump forward快捷键。

因此建议配置快捷键如下：

```json
{ "keys": ["ctrl+alt+left"], "command": "jump_back" },
{ "keys": ["ctrl+alt+right"], "command": "jump_forward" }
```

## Snippet
### HTML5
### jQuery

## AutoPrefixer

## sublimeLinter
js脚本自动检查工具。待调查。

## Can I Use

## DocBlockr
文档快速注释插件。

> 输入 /**，按tab键。

## Trimmer
删除多余空格的插件。

## AutoFileName
自动填充文件完整路径的插件。

```html
<!-- 会逐次自动提示输入 assets css admin AdminLTE.css 同级目录洗所有文件和文件夹  -->
<link rel="stylesheet" href="assets/css/admin/AdminLTE.css">
```

## [HTML|CSS|JS Prettify](https://github.com/victorporof/Sublime-HTMLPrettify)
HTML|CSS|JS|JSON格式化插件，其默认格式就不错。
安装配置中需要注意，其需要nodejs支持，从preferences中可以看到有个`set node path`的菜单，其中已经有默认的node可执行程序的路径，可以根据自身的安装路径进行调整。

> 快捷键：`Ctrl+Alt+H`，注意最好选中整个文件内容进行格式化。

### JsFormat
Prettify可以完全替代JsFormat。

> 快捷键：`ctrl+alt+f`，注意，工具栏中 view -> indentation -> Tab Width 的配置会影响格式化默认的indentation宽度。

### Alignment
有了Prettify，基本也不考虑使用Alignment。

## BracketHighlighter
高亮显示各种tag开始和结束位置的插件。

## SVN

## Git && GitGutter
Git在sublime text 3中没有发现乱码问题。
GitGutter可以在代码中标明变化的行，便于定位修改位置。

GitGutter在安装后，需要配置git的路径，否则无法使用。在用户配置文件中，增加配置如下：

```bash
{
    "git_binary": "C:\\Program Files (x86)\\Git\\bin\\git.exe"
}
```

## SideBarEnhancements
Sublime侧边栏功能增强插件。

## MarkdownEditing
Markdown文本编辑插件。

## [InsertDate](https://packagecontrol.io/packages/InsertDate)
快速插入各种日期格式的插件。

> 比如想设置按两次快捷键ctrl+f5，可以插入%Y-%m-%d %H:%M:%S格式的日期数据，可以在Preferences > Key Bindings - User文件中设置，如果不确定格式，可以参考Preferences -> Package Settings -> InsertDate下的Key Bindings相关设置

```json
  { 
    "keys": ["ctrl+f5", "ctrl+f5"],
      "command": "insert_date",
      "args": {"format": "%Y-%m-%d %H:%M:%S"}
  }
```

## SublimeREPL
直接执行脚本代码的插件。

> 可以在Command Palette中快速选择调用。推荐`Alt+Shift+2`新建窗口使用

## ColorPicker
快速选择颜色（通过面板）的插件。

## 其它插件

+ Terminal
+ CSSComb
+ EasyDiff
+ SublimeCodeIntel
+ less（less代码高亮）
+ minifier
+ Placeholder
+ Hex to HSL
+ GBK to UTF8
+ PackageResourceViewer


