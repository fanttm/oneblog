title: bootstrap-3.x的submenu？
date: 2015-09-06 11:49:29
updated: 2015-09-06 11:49:34
comments: 
tags:
- bootstrap
categories:
---

bootstrap 3.x为了尽可能多地支持移动设备，果断放弃了对submenu的支持，真是令人遗憾啊，这个多级菜单在PC上实在是太太太常见的需求了。

好在，github上已经有大神给出了解决方案，还行，请参见 [bootstrap-submenu](https://github.com/vsn4ik/bootstrap-submenu) 。

[一个人的策展年代](/一个人的策展年代/)

> 注意 2.0.0 版本的使用，同之前有所区别。使用之前版本的同学，在升级时需要注意用法上的变化。

<!-- more -->

## JS|CSS脚本加载

```
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
  <link rel="stylesheet" href="dist/css/bootstrap-submenu.min.css">

  <script src="https://code.jquery.com/jquery-2.1.4.min.js" defer></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" defer></script>
  <script src="dist/js/bootstrap-submenu.min.js" defer></script>
</head>
<body>
  ...
</body>
</html>
```

## dropdown-submenu片段

```
<div class="dropdown m-b">
  <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" data-submenu="" aria-expanded="false">
    Dropdown <span class="caret"></span>
  </button>

  <ul class="dropdown-menu">
    <li><a tabindex="0">Action</a></li>
    <li class="dropdown-submenu">
      <a tabindex="0">Another action</a>

      <ul class="dropdown-menu">
        <li class="dropdown-header">Dropdown header</li>
        <li><a tabindex="0">Sub action</a></li>
        <li class="disabled"><a tabindex="0">Another sub action</a></li>
        <li><a tabindex="0">Something else here</a></li>
      </ul>
    </li>
    <li><a tabindex="0">Something else here</a></li>
    <li class="divider"></li>
    <li><a tabindex="0">Separated link</a></li>
  </ul>
</div>
```

## 启用submenu

```
$('[data-submenu]').submenupicker();        // bootstrap-submenu 2.0.0 以上版本
```

```
$('.dropdown-submenu > a').submenupicker(); // bootstrap-submenu 2.0.0 以下版本
```

