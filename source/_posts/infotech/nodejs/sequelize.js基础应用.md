title: sequelize.js基础应用
date: 2016-06-13 17:50:22
updated: 2016-06-13 17:50:30
comments:
tags:
- sequelize
categories:
- nodejs

---


sequelize cli

sequelize init
可以设置指定目录来创建 migrations、config/config.json、models、seeders

sequelize model:create --name User --attributes "openid:string, login:string, hashed_password:string"
默认自动创建自增id

sequelize db:migrate
sequelize db:migrate[:undo]
sequelize db:seed[:undo]

sequelize seed:create
sequelize migration:create
sequelize model:create

sequelize model:create同时生成migrations和models，可以修改models下的类，添加新方法

config/config.json配置文件



