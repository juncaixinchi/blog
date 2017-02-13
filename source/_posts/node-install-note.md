---
title: node install note
date: 2017-02-12 16:39:15
tags: 
    - node.js
---

Node安装与npm环境变量配置
===

<!-- more -->

# Node安装

进入nodejs官方网站下载软件(nodejs.org)

Windows环境下的NodeJS+NPM+Bower安装配置

Windows环境下的NodeJS+NPM+Bower安装配置


下载完成后，双击默认安装。安装程序会自动添加环境变量
Windows环境下的NodeJS+NPM+Bower安装配置

检测nodejs是否安装成功。打开cmd命令行 输入 node - v 显示当前版本号

Windows环境下的NodeJS+NPM+Bower安装配置

检查npm是否安装。由于新版的NodeJS已经集成了npm，所以之前npm也一并安装好了。同样可以使用cmd命令行中键入 npm -v

Windows环境下的NodeJS+NPM+Bower安装配置

# npm环境变量配置

npm作为一个NodeJS的模块管理，之前我由于没有系统地看资料所以导致安装配置模块的时候走了一大段弯路，所以现在很有必要列出来记录下。我们要先配置npm的全局模块的存放路径以及cache的路径，例如我希望将以上两个文件夹放在NodeJS的主目录下，便在NodeJs下建立“node_global”及“node_cache”两个文件夹。我们就在cmd中键入两行命令：
	npm config set prefix "D:\Program Files\nodejs\node_global"
	和
	npm config set cache "D:\Program Files\nodejs\node_cache"

下面这一步非常关键，我们需要设置系统变量。进入我的电脑→属性→高级→环境变量。在系统变量下新建“NODE_PATH”，输入“D:\Program Files\nodejs\node_global\node_modules”。
安装bower, npm install bower -g; -g表示全局

输入 node，require('bower') 测试是否安装成功！
