---
title: Check Chinese Word
date: 2019-1-7 21:05:35
tags:
---

使用`grep -r`读取当前文件夹下的所有文件内容，使用正则匹配筛选中文
```js
const child = require('child_process')
const all = child.execSync(`grep -r ''`).toString().split('\n').map(l => l.trim()).filter(l => l.length)
const chinese = all.filter(l => /[\u4E00-\u9FFF\u3400-\u4dbf\uf900-\ufaff\u3040-\u309f\uac00-\ud7af]+/.test(l))
```