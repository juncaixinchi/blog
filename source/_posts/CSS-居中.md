---
title: CSS 居中
date: 2019-10-12 19:52:56
tags:
    - CSS
---

### css居中

记录多种CSS居中方式

<!-- more -->

+ 文字居中, 设置 line-height = height

```css
.parent {
   height: 200px;
   line-height: 200px;
}
```

+ 绝对定位: 需要提前知道尺寸，margin-top: -(高度的一半); margin-left: -(宽度的一半)

```css
.parent {
    position: relative;
    height: 200px;
}
.child {
    position: absolute;
    left: 50%;
    top: 50%;
    margin-top: -20px;
    margin-left: -40px;
}
```

+ 绝对定位 + transform: 根据百分比

```css
.parent {
    position: relative;
    height: 200px;
}
.child {
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
}
```

+ 绝对定位 + margin: auto

```css
.parent {
    position: relative;
    height: 200px;
}
.child {
    position: absolute;
    left: 0;
    top: 0;
    right: 0;
    bottom: 0;
    margin: auto;
}
```

+ display: flex
```css
.parent {
    display: flex;
    align-items: center;        /* 垂直居中 */
    justify-content: center;    /* 水平居中 */
}
```