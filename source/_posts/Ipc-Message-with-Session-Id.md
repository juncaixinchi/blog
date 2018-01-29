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
    const session = UUID.v4()
	const { digest } = photo
	ipcRenderer.send('mediaShowThumb', session, digest, 200, 200)

	ipcRenderer.on('getThumbSuccess', (event, data) => {
	  if (data && session === data.session) {
       // blabla
      }
	})
//	...
```