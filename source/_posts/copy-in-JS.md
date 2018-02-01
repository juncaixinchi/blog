---
title: copy in JS
date: 2017-09-17 21:58:25
tags: 
    - JavaScript
    - Copy
---

JavaScript 中的拷贝操作
===

学习整理了js中数据拷贝相关的知识，做个笔记记录一下。

<!-- more -->

### js的数据类型

Js中共有六种原型数据类型:

+ Boolean.  布尔值，true 和 false.
+ null. 一个表明 null 值的特殊关键字。 JavaScript 是大小写敏感的，因此 null 与 Null、NULL或其他变量完全不同。
+ undefined.  变量未定义时的属性。
+ Number.  表示数字，例如： 42 或者 3.14159。
+ String.  表示字符串，例如："Howdy"
+ Symbol ( 在 ECMAScript 6 中新添加的类型).。一种数据类型，它的实例是唯一且不可改变的。

以及 Object 对象，其他引用类型（Array、Date、RegExp、Function、基本包装类型（Boolean、String、Number）、Math等）都是Object类型的实例对象


对于copy操作，基本逻辑是：

**原始数据 => 复制这个变量；引用数据 => 拷贝引用**

```js
// primitives
str1 = 1
str2 = str1
str2 = 2
str1 // 1

// array
arr1 = [1, 2]
arr2 = arr1
arr2.push(3)
arr1 // [1, 2, 3]

// map or filter will not change the raw array
arr3 = arr2.map(v => v * v)
arr3 // [1, 4, 9]
arr2 // [1, 2, 3]
```