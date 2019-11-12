---
title: CSS Flex布局
date: 2018-9-21 18:55:29
tags:
    - CSS
---

### Flex布局
Flex是Flexible Box的缩写，即“弹性盒子”

+ flex-direction，决定主轴的方向（即项目的排列方向）: row | row-reverse | column | column-reverse;

+ flex-wrap，定义换行情况: nowrap | wrap | wrap-reverse;

+ flex-flow：flex-direction和flex-wrap的简写，默认row nowrap

+ justify-content属性，定义项目在主轴上的对齐方式：flex-start | flex-end | center space-between | space-around

+ align-items属性，定义在交叉轴上的对齐方式：flex-start | flex-end | center | baseline | stretch;

+ 子项目： flex-grow，定义项目的放大比例，默认值为0，即如果空间有剩余，也不放大