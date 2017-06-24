---
title: Display flex in css
date: 2017-04-09 11:40:08
tags: 
	- css
---

# CSS3 弹性盒子 —— Flex 布局

Flex 布局，是一种用于在页面上布置元素的布局模式，使得当页面布局必须适应不同的屏幕尺寸和不同的显示设备时，元素可预测地运行

<!-- more -->

## 实现水平+垂直居中

```CSS
display: flex
align-items: center
justify-content: center
```

## 基本概念

采用Flex布局的元素，称为Flex容器（flex container），简称"容器"。它的所有子元素自动成为容器成员，称为Flex项目（flex item），简称"项目"。

容器默认存在两根轴：水平的主轴（main axis）和垂直的交叉轴（cross axis）。主轴的开始位置（与边框的交叉点）叫做main start，结束位置叫做main end；交叉轴的开始位置叫做cross start，结束位置叫做cross end。
项目默认沿主轴排列。单个项目占据的主轴空间叫做main size，占据的交叉轴空间叫做cross size。

## 容器的属性

+ flex-direction
+ flex-wrap
+ flex-flow
+ justify-content
+ align-items
+ align-content