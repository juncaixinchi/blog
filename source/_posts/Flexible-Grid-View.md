---
title: Flexible Grid View
date: 2019-12-11 22:18:54
tags:
    - JavaScript
---

参考Flutter的GridView，在Web环境下用JS实现一个自适应的GridView

基本思路是利用react-virtualized-auto-sizer获取当前容器大小，再根据crossAxisCount和childAspectRatio计算布局

<!-- more -->