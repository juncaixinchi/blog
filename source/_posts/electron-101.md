---
title: electron 101
date: 2017-11-13 19:23:54
tags:
---

## electron相关 tips

### 简介

electron是用web技术编译原生桌面应用的框架，其基于`node.js`与`Chromium`。简单来讲就是让程序跑在`Chromium`中，然后结合`node.js`，通过`ipc`通讯，使应用可以突破浏览器沙盒的限制，访问本地资源。electron最重要的特点主要以下两个：

1. 基于web技术，开放效率高。

2. 跨平台能力强，一套代码可以几乎无成本生成windows、mac、linux三个平台应用。

<!-- more -->

### electron的几个坑及解决方法

然而在实践中，electron还是有许多坑的，以下是遇到的几个坑及解决办法。

#### 下载问题

electron可以通过npm安装，但是prebuild过程中需要额外下载一些内容。由于众所周知的原因，这个过程在国内会变得非常漫长，甚至根本不能成功。一个可行的解决方法是使用taobao的npm镜像:

```bash
npm install electron --registry=https://registry.npm.taobao.org
```

#### 编译二进制包

之前在项目中用到了[fs-xattr](https://github.com/LinusU/fs-xattr)这个包，这是用C++写的，安装时需要编译。正常的`npm install`后，启动electron，往往会报下面的错误：

```
fs-xattr was compiled against a different Node.js version using
NODE_MODULE_VERSION 57. This version of Node.js requires
NODE_MODULE_VERSION 54. Please try re-compiling or re-installing
the module
```

原因是electron编译的node版本与`npm install`使用的node版本不一致，而且可能electron的node版本根本没有对应的node官方的发行版。这个时候需要rebuild

```bash
npm i --save-dev electron-rebuild
node_modules/.bin/electron-rebuild
```

这里还有两个坑：

+ 如果使用`cnpm install`安装的包，`electron-rebuild`可能无法识别
+ `electron-rebuild`过程中可能需要联网下载prebuild的库，这个就往往会悲剧，所以可以制定本地的electron来编译（但是有时候还是会不行，我在mac上遇到过几次）

```bash
node_modules/.bin/electron-rebuild -e './node_modules/electron/dist' -v 1.7.9
```

#### `asar`文件与`fs`

`asar`是一种将多个文件合并成一个文件的类 tar 风格的归档格式。electron 可以无需解压，即从其中读取任意文件内容。
electron是使用自己编译的`node.js`，对其fs方法做了修改，这才使得其可以直接从`asar`包中读取文件。electron中以下命令可以成功读取文件夹内容。但是操作系统和一般的node.js则会把`example.asar`当做单个文件。

```js
fs.readdirSync('/path/to/example.asar')
```

之前笔者在处理`asar`文件的时候就被坑了，在使用`fs.lstat`和`rimraf`过程中都遇到了这个问题，明明是文件怎么就成了文件夹了呢？！解决的办法是使用`original-fs`

```js
const fs = require('original-fs')
fs.lstatSync('/path/to/example.asar')
rimraf('/path/to/example.asar', fs, callback) // 传入original-fs
```

#### 使用webpack

如果项目中使用了`webpack`, 在中`webpack.config.js` 中需要加入配置，目前使用的是2.7.0版本的webpack（想要升级，但似乎会涉及到热替换等许多问题，暂缓中）

```js
target: 'electron'
```