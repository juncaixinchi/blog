基于Hexo+Next+GitHub Pages搭建个人博客
===

### 简介

Hexo是依赖于node.js的个人博客生成引擎，可以把基于Markdown的文件生成博客页面，所以整个项目分为两部分：

1. 网页生成

	安装配置Hexo及其主题Next，撰写整理博客文档，生成静态页面 

2. 网页部署

	生成的网页存在于public文件夹内，将其部署到Github Pages或其他服务器即可 [Blogs](https://juncaixinchi.github.io/Blogs/)

### 安装和配置Hexo
首先要有node.js，然后用npm安装hexo

	npm install -g hexo-cli

切换到博客的位置

	cd ~/Github/

生成新的博客文件夹，这会需要一段时间

	hexo init blog
	cd blog


开启服务器，默认为 http://127.0.0.1:4000/，可在本地查看

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


### 添加主题主题

因为添加主题next，在上传GitHub Pages的时候遇到了以下问题：

	Page build failed: Missing submodule

发现是submodule没有配置好，删除原来的 themes/next/ 文件使用以下代码重新配置

	$ git submodule add git@github.com:juncaixinchi/hexo-theme-next.git themes/next

	$ git submodule init

	$ git submodule update

