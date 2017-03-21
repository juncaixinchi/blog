---
title: npm and googleapis mirror 
date: 2017-03-20 22:55:06
tags: 
	- npm
	- googleapis
---

最近家里网络很糟糕，上不了npm，很是纠结，于是修改设置使用国内的taobao镜像

<!-- more -->

## NPM

镜像使用方法（三种办法任意一种都能解决问题，建议使用第三种，将配置写死，下次用的时候配置还在）:

1.通过config命令

	npm config set registry https://registry.npm.taobao.org 
	npm info underscore （如果上面配置正确这个命令会有字符串response）

2.命令行指定

	npm --registry https://registry.npm.taobao.org info underscore 

3.编辑 ~/.npmrc 加入下面内容

	registry = https://registry.npm.taobao.org

搜索镜像: https://npm.taobao.org

建立或使用镜像,参考: https://github.com/cnpm/cnpmjs.org

## googleapis

另外google的字体也需要国内镜像，可以考虑中科大的镜像服务[LUG](fonts.lug.ustc.edu.cn)，在源代码内做以下替换即可

```
ajax.googleapis.com => ajax.lug.ustc.edu.cn
fonts.googleapis.com => fonts.lug.ustc.edu.cn
themes.googleusercontent.com => google-themes.lug.ustc.edu.cn
```