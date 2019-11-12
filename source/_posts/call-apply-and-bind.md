---
title: 'call(), apply() and bind()'
date: 2018-11-19 21:58:51
tags:
    - JavaScript
---

### call(), apply()和bind()

js中的call(), apply()和bind()是Function.prototype下的方法，都是用于改变函数运行时上下文，最终的返回值是你调用的方法的返回值，若该方法没有返回值，则返回undefined。

+ apply()

使用 apply， 你可以继承其他对象的方法：注意这里apply()的第一个参数是null，在非严格模式下，第一个参数为null或者undefined时会自动替换为指向全局对象，apply()的第二个参数为`数组或类数组`。

```javascript
const arr = [1,2,3,4,9,8,7]
const max = Math.max.apply(Math, arr)
```

+ call()

call()是apply()的一颗语法糖，作用和apply()一样，同样可实现继承，唯一的区别就在于call()接收的是`参数列表`，而apply()则接收参数数组。

```javascript
const arr = [1,2,3,4,9,8,7]
const max = Math.max.apply(Math, ...arr)
```

+ bind()

bind()的作用与call()和apply()一样，都是可以改变函数运行时上下文，区别是call()和apply()在调用函数之后会立即执行，而bind()方法调用并改变函数运行时上下文后， `返回一个新的函数，供我们需要时再调用`。