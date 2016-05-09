title: Git常用命令
date: 2016-05-09 17:44:14
updated: 2016-05-09 17:44:18
tags:
- git
categories:

---

## 撤销

```bash
# 只能删除modified文件，不能删除新增的文件夹和文件
git checkout .

# git clean 可以完全清除修改和新增的文件夹和文件
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


