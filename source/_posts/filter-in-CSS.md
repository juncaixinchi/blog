---
title: filter in CSS
date: 2017-07-10 20:21:23
tags:
	- CSS
---

### CSS3 中 Filter的应用

Filter是CSS3中对图片添加特效的方法，可以认为是一种滤镜

基本语法是：

```css
filter: <filter-function> [<filter-function>]* | none


/* examples */
.mydiv { filter: grayscale(50%) }

img {
  filter: grayscale(0.5) blur(10px);
}
```
<!-- more -->


主要有以下10种功能：

![filter results](../images/filter.png)

* blur: 虚化

```css
filter: blur(2px);
```

* brightness: 亮度

```css
filter: brightness(0.4);
```

* contrast： 对比度

```css
filter: contrast(200%);
```

* grayscale： 灰度

```css
filter: grayscale(80%);
```

* opacity: 透明度

```css
filter: opacity(60%);
```

* saturate: 饱和度

```css
filter: saturate(70%);
```

* invert: 反色

```css
filter: invert(85%);
```

* sepia: 褐色

```css
filter: sepia(30%);
```

* hue-rotate: 色相旋转

```css
filter: hue-rotate(90deg);
```

* drop-shadow: 添加阴影

```css
/* h-shadow v-shadow blur color */
filter: drop-shadow(4px 4px 8px blue);
```