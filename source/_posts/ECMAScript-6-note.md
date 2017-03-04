---
title: ECMAScript-6-note
date: 2017-03-02 20:38:44
tags:
	- JavaScript
	- ES6
---


# 学习ES6的笔记

ECMAScript 6.0 是JavaScript语言的下一代标准，已经在2015年6月正式发布

主要学习了阮一峰老师的[ECMAScript 6 入门](http://es6.ruanyifeng.com/)

<!-- more -->

## ES6转码器

+ Babel转码器

	[Babel](https://babeljs.io/)是一个广泛使用的ES6转码器，可以将ES6代码转为ES5代码，可通过npm安装。同时Babel提供一个[REPL在线编译器](https://babeljs.io/repl/)，可以在线将ES6代码转为ES5代码

+ Traceur转码器

	[Traceur转码器](https://github.com/google/traceur-compiler)由Google公司开发，也可以将ES6代码转为ES5代码，也可通过[在线编译器](http://google.github.io/traceur-compiler/demo/repl.html)转换代码

## let和const命令

### 1. let命令

ES6新增了let命令，用来声明变量。它的用法类似于var，但是所声明的变量，只在let命令所在的代码块内有效

for循环的计数器，就很合适使用let命令

```javascript
for (let i = 0; i < 10; i++) {}
console.log(i);
```

let不存在变量提升，变量应该在声明语句之后才可以使用，且不允许在相同作用域内，重复声明同一个变量

```javascript
// var 的情况
console.log(foo); // 输出undefined
var foo = 2;

// let 的情况
console.log(bar); // 报错ReferenceError
let bar = 2;

// 报错
function () {
  let a = 10;
  var a = 1;
}

// 报错
function () {
  let a = 10;
  let a = 1;
}
```

在代码块内，使用let命令声明变量之前，该变量都是不可用的。这在语法上，称为“暂时性死区”（temporal dead zone，简称 TDZ）

```javascript
var tmp = 123;
if (true) {
  tmp = 'abc'; // ReferenceError
  let tmp;
}

typeof x; // ReferenceError
let x;
```

### 2.块级作用域

let实际上为JavaScript新增了块级作用域，{}内部即为一个块级作用域

```javascript
function f1() {
  let n = 5;
  if (true) {
    let n = 10;
  }
  console.log(n); // 5
}
```

块级作用域的出现，实际上使得获得广泛应用的立即执行函数表达式（IIFE）不再必要了

```javascript
// IIFE 写法
(function () {
  var tmp = ...;
  ...
}());

// 块级作用域写法
{
  let tmp = ...;
  ...
}
```

ES6 引入了块级作用域，明确允许在块级作用域之中声明函数

```javascript
'use strict';
if (true) {
  function f() {}
}
```

浏览器环境并一定完全兼容，故在块级作用域内声明函数时，建议用函数表达式，而不是函数声明语句

```javascript
// 函数表达式
{
  let a = 'secret';
  let f = function () {
    return a;
  };
}
```

### 3.const命令

const声明一个只读的常量。一旦声明变量，就必须立即初始化，只在声明所在的块级作用域内有效

```javascript
const PI = 3.1415;
PI // 3.1415

PI = 3;
// TypeError: Assignment to constant variable.
```

对于复合类型的变量，变量名不指向数据，而是指向数据所在的地址。const命令只是保证变量名指向的地址不变，并不保证该地址的数据不变，所以将一个对象声明为常量必须非常小心

```javascript
const foo = {};
foo.prop = 123;

foo.prop
// 123

foo = {}; // TypeError: "foo" is read-only
```

如果真的想将对象冻结，应该使用Object.freeze方法

```javascript
var constantize = (obj) => {
  Object.freeze(obj);
  Object.keys(obj).forEach( (key, value) => {
    if ( typeof obj[key] === 'object' ) {
      constantize( obj[key] );
    }
  });
};
```

### 4.顶层对象的属性

+ var命令和function命令声明的全局变量，依旧是顶层对象的属性
+ let命令、const命令、class命令声明的全局变量，不属于顶层对象的属性

```javascript
var a = 1;
// 如果在Node的REPL环境，可以写成global.a
// 或者采用通用方法，写成this.a
window.a // 1

let b = 1;
window.b // undefined
```

### 5.global 对象

ES5的顶层对象，本身也是一个问题，因为它在各种实现里面是不统一的。

+ 浏览器里面，顶层对象是window，但 Node 和 Web Worker 没有window。
+ 浏览器和 Web Worker 里面，self也指向顶层对象，但是Node没有self。
+ Node 里面，顶层对象是global，但其他环境都不支持。

同一段代码为了能够在各种环境，都能取到顶层对象，现在一般是使用this变量，但是有局限性。

+ 全局环境中，this会返回顶层对象。但是，Node模块和ES6模块中，this返回的是当前模块。
+ 函数里面的this，如果函数不是作为对象的方法运行，而是单纯作为函数运行，this会指向顶层对象。但是，严格模式下，这时this会返回undefined。
+ 不管是严格模式，还是普通模式，new Function('return this')()，总是会返回全局对象。但是，如果浏览器用了CSP（Content Security Policy，内容安全政策），那么eval、new Function这些方法都可能无法使用。

综上所述，很难找到一种方法，可以在所有情况下，都取到顶层对象。下面是两种勉强可以使用的方法。

```javascript
// 方法一
(typeof window !== 'undefined'
   ? window
   : (typeof process === 'object' &&
      typeof require === 'function' &&
      typeof global === 'object')
     ? global
     : this);

// 方法二
var getGlobal = function () {
  if (typeof self !== 'undefined') { return self; }
  if (typeof window !== 'undefined') { return window; }
  if (typeof global !== 'undefined') { return global; }
  throw new Error('unable to locate global object');
};
```

## 变量的解构赋值