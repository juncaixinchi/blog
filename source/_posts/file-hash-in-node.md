---
title: file hash in node
date: 2017-07-25 18:44:44
tags:
    - sha256
    - node
---

利用node中的加密模块crypto计算文件的hash值
===

用`readStream`的方式读取文件并同时使用`crypto.createHash`计算hash值。

```js
/*
 * usage: node hash.js fileToHash
 */
const fs = require('fs')
const path = require('path')
const crypto = require('crypto')

const file = path.resolve(process.argv[2])
const rs = fs.createReadStream(file, { highWaterMark: 4194304 })

const start = (new Date()).getTime()
const type = 'sha256' // 'md5', 'sha512', etc.
const hash = crypto.createHash(type).setEncoding('hex')
const size = fs.lstatSync(file).size

rs.on('end', () => {
  hash.end()
  console.log('file: ', file, '\nsize: ', size, 'B\ntime: ', (new Date()).getTime() - start, 'ms\nhash: ', hash.read())
})

rs.pipe(hash)
```