---
title: 基于Hexo+Next+GitHub搭建个人博客
date: 2017-02-12 16:24:56
tags: 
    - Hexo
    - next
    - GitHub Pages
    - blog
---


基于Hexo+Next+GitHub搭建个人博客
===

### 简介

Hexo是依赖于node.js的个人博客生成引擎，可以把基于Markdown的文件生成博客页面，所以整个项目分为两部分：

1. 网页生成

	安装配置Hexo及其主题Next，撰写整理博客文档，生成静态页面 [blog-generater](https://github.com/juncaixinchi/blog-generater)

2. 网页部署

	生成的网页存在于public文件夹内，将其部署到Github Pages或其他服务器即可 [Blogs](https://juncaixinchi.github.io/Blogs/)

<!-- more -->

### 安装和配置Hexo

首先要有node.js，然后用npm安装hexo

	npm install -g hexo-cli

切换到博客的位置

	cd ~/Github/

生成新的博客文件夹，这会需要一段时间

	hexo init blog
	cd blog


开启服务器，默认为 http://127.0.0.1:4000/ 可在本地查看

	hexo server

生成新的文章，这里"Hello Hexo"只是标题，然后可以编辑Hello-Hexo.md撰写博客

	vi ./source/_posts/Hello-Hexo.md

生成静态文件，以便部署到Github Pages，详细配置见下文

	hexo generate

	hexo deploy

或者合并

	hexo generate --deploy


### 自动生成静态页面和部署（generate and deploy）

安装 hexo-deployer-git.

	$ npm install hexo-deployer-openshift --save

编辑配置文件，需在github先新建repository：Blogs

	deploy:
	  type: git
	  repo: git@github.com:juncaixinchi/Blogs.git
	  branch: master
	  
生成静态文件和自动部署

	hexo generate --deploy


### 配置与添加主题

在 Hexo 中有两份主要的配置文件，其名称都是 _config.yml。 其中，一份位于站点根目录下，主要包含 Hexo 本身的配置；另一份位于主题目录下，这份配置由主题作者提供，主要用于配置主题相关的选项。

为了描述方便，在以下说明中，将前者称为 站点配置文件， 后者称为 主题配置文件。

#### 设置网站路径，很关键，否则上传至GitHub不能正确加载css和js

	url: https://juncaixinchi.github.io/Blogs/
	root: /Blogs/

#### 设置 语言

编辑 站点配置文件， 将 language 设置成你所需要的语言。建议明确设置你所需要的语言，例如选用简体中文，配置如下：

	language: zh-Hans

#### 设置 头像

将avatar.png放置在 source/images/ 目录下，站点配置文件新增字段 avatar，配置为：
	
	avatar: /images/avatar.png

#### 安装主题

因为添加主题next，在上传GitHub Pages的时候遇到了以下问题：

	Page build failed: Missing submodule

发现是submodule没有配置好，删除原来的 themes/next/ 文件使用以下代码重新配置

	$ git submodule add git@github.com:juncaixinchi/hexo-theme-next.git themes/next

	$ git submodule init

	$ git submodule update


#### 选择主题Scheme

Scheme 是 NexT 提供的一种特性，借助于 Scheme，NexT 为你提供多种不同的外观。同时，几乎所有的配置都可以 在 Scheme 之间共用。目前 NexT 支持三种 Scheme，他们是：

Muse - 默认 Scheme，这是 NexT 最初的版本，黑白主调，大量留白
Mist - Muse 的紧凑版本，整洁有序的单栏外观
Pisces - 双栏 Scheme，小家碧玉似的清新
Scheme 的切换通过更改 主题配置文件，搜索 scheme 关键字。 你会看到有三行 scheme 的配置，将你需用启用的 scheme 前面注释 # 即可。

	#scheme: Muse
	#scheme: Mist
	scheme: Pisces

