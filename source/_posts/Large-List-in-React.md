---
title: Large List in React
date: 2017-04-13 21:11:39
tags:
	- JavaScript
	- React
---

## 超大列表的显示

* 直接全部显示一个超大的列表是十分消耗资源的，所以必须要采取对策，主流的有两种对策：

	1. Lazyloading: 即开始至加载一部分，每次需要的时候再加载新的内容，一个形象的例子就是“刷微博”

	2. 局部加载: 每次计算当前页面应当展示的内容

## [react-virtualized](https://github.com/bvaughn/react-virtualized)

* react-virtualized list 是一个对付超大列表很有用的react组件

* 页面中显示固定数目的div，如20个，每次用户操作滚动条时，再对这20个div的内容进行实时改变，使得当前页面显示正确的内容

## 代码

```jsx
import React from 'react';
import ReactDOM from 'react-dom';
import { List } from 'react-virtualized';

// List data as an array of strings
const list = [
  'Brian Vaughn'
  // And so on...
];

function rowRenderer ({
  key,         // Unique key within array of rows
  index,       // Index of row within collection
  isScrolling, // The List is currently being scrolled
  isVisible,   // This row is visible within the List (eg it is not an overscanned row)
  style        // Style object to be applied to row (to position it)
}) {
  return (
    <div
      key={key}
      style={style}
    >
      {list[index]}
    </div>
  )
}

// Render your list
ReactDOM.render(
  <List
    width={300}
    height={300}
    rowCount={list.length}
    rowHeight={20}
    rowRenderer={rowRenderer}
  />,
  document.getElementById('example')
);
```