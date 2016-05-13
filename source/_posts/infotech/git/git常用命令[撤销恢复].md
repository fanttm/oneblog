title: Git常用命令[撤销恢复]
date: 2016-05-09 17:44:14
updated: 2016-05-09 17:44:18
tags:
- git
categories:

---

## 撤销

### git checkout

```bash
# 只能恢复对文件的修改，不能删除新增的文件夹和文件
git checkout . # 取消修改所有文件
git checkout -- <file> # 取消修改单个文件
```

### git clean

```
# git clean 可以完全取消修改和删除新增的文件夹和文件
# -n 列出待删除的文件（不会列出文件夹）
git clean -n
# -dn 列出待删除的文件夹和文件
git clean -dn
# -f 强制删除文件（不会删除文件夹）
git clean -f
# -df 强制删除文件夹和文件
git clean -df
```

> 注意 -f 配置，依赖于 ~/.gitconfig 中 clean.requireForce 参数的配置是 true 还是 false

### git commit

```
# 修改最后一次提交
git commit --amend
```

参考 [Git-基础-撤销操作](https://git-scm.com/book/zh/v1/Git-%E5%9F%BA%E7%A1%80-%E6%92%A4%E6%B6%88%E6%93%8D%E4%BD%9C)

