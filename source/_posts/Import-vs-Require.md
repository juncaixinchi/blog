---
title: Import vs Require
date: 2018-03-18 22:42:41
tags:
    -- Node.js
---

node编程中最重要的思想之一就是模块，而正是这个思想，让JavaScript的大规模工程成为可能。
但是由于JS发展历史的原因，发展出了不同的模块化规范，`require`与`import`就是这种环境下的产物。

<!-- more -->

+ 不同的模块化规范

`require/exports`出自CommonJS，这是JavaScript 社区中的开发者自己草拟的规则，但得到了大家的承认或者广泛的应用。

`import/export`TC39 制定的新的 ECMAScript 版本，即 ES6（ES2015）中包含进来。

+ 形式差异

require/exports 的用法相对简单但可以条件调用而更灵活：

```js
const fs = require('fs')
const mod = process.env.NODE_ENV = 'dev' ? require('./dev') : require('./prod')
exports.fs = fs
module.exports = { a, b }
```

而 import/export 的写法就多种多样，但一般要写在模块最前面：

```js
import fs from 'fs'
import * as fs from 'fs'

export default fs
export const fs
export function readFile
export { readFile, read }
export * from 'fs'
```

+ 本质差异

require/exports 模块输出的是一个值的拷贝，import/export 模块输出的是值的引用。
require/exports 模块是运行时加载，import/export 模块是编译时输出接口。

这部分可以看阮一峰老师的详解 [module](http://es6.ruanyifeng.com/#docs/module-loader#ES6-%E6%A8%A1%E5%9D%97%E4%B8%8E-CommonJS-%E6%A8%A1%E5%9D%97%E7%9A%84%E5%B7%AE%E5%BC%82)

+ 现实状况

截止2018年3月，并没有任何JS的runtime完全实现了import/export，node也只是部分实现，
所以现有的import/export都是通过babel转码成require/exports，希望相应的支持能更快到来吧。