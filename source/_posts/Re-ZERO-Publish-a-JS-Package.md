---
title: 'Re:ZERO - Publish a JS Package'
date: 2017-08-22 19:26:51
tags:
    - npm
---

My First Javascript Package in Npm
===

写了个基于node的操作`NTFS Alternate Data Stream`的库，发布在了npm，特此记录一下流程

<!-- more -->

### 创建github项目

在github上新建项目 [fs-ads](https://github.com/juncaixinchi/fs-ads)

码好代码，写好测试。

### 注册npm账号

在本地代码池使用`npm adduser`创建新的账户

如果已经有账户，可以用`npm login`来登录账户

### 发布与更新

使用`npm publish`发布package

更新package可以使用 `npm version <update_type>`命令，

其中`<update_type>`可以是`patch`, `minor`, or `major`，分别对应三个版本号。

npm 会自动提交一个新的commit，新建tag

再次使用`npm publish`即可更新原有版本