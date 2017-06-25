---
title: Ipc Message with Session Id
date: 2017-04-15 20:22:50
tags:
---

# 使用带session的ipc通讯

* 在发送的信息中添加一个唯一的uuid，用于标记当前消息的id。

* 适用于多组件可能重复发送相同message的情况，如同一页面同时载入多张图片等情况。

<!-- more -->

```js
import UUID from 'node-uuid'
import { ipcRenderer } from electron

//	...
	this.session = UUID.v4()
	this.digest = this.props.items[currentIndex][0]
	this.photo = this.props.items[currentIndex][1]
	this.props.ipcRenderer.send('mediaShowThumb', this.session, this.digest, 210, 210)
//	...
```