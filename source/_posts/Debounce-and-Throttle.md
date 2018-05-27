---
title: Debounce and Throttle
date: 2018-03-25 22:02:50
tags: 
    - JavaScript
---

防抖（Debounce）和节流（Throttle）都是用来控制某个函数在一定时间内执行多少次的技巧

* Debounce: 把触发非常频繁的事件合并成一次执行。
* Throttle: 把触发非常频繁的事件变成每隔一定时间触发一次。

<!-- more -->
### 含义理解

以乘电梯为例子，假设电梯的延时为5s，那么

* Debounce: 第一个人上来后，等待5s，如果没有新人就开始运行，如果期间有新人则重新计时5s，直到5s超时才运行
* Throttle：第一个人上来后，5s后准时启动，不等待。如果没有人就待机

### 代码实现

+ Debouce:

```js
let timer = null
const debounce = (fn, delay) => {
    clearTimeout(timer)
    timer = setTimeout(fn, delay)
}
```
+ Throttle
```js
let WIP = false // work in  process
const throttle = (fn, delay) => {
    if (WIP) return
    WIP = true
    setTimeout(() => {
        fn()
        WIP = false
    }, delay)
```