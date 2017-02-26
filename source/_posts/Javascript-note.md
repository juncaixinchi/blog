---
title: Javascript-note
date: 2017-02-22 21:57:57
tags: 
- javascript
- ES6
---

# 学习javascript的笔记

主要学习了

[JavaScript教程](http://www.liaoxuefeng.com/wiki/001434446689867b27157e896e74d51a89c25cc8b43bdb3000)

[ECMAScript 6 入门](http://es6.ruanyifeng.com/)

[JS函数式编程指南](https://llh911001.gitbooks.io/mostly-adequate-guide-chinese/content/)

<!-- more -->

## 字符串

多行字符串

`这是一个
多行
字符串`;

`toUpperCase()`,`toLowerCase()` 把一个字符串全部变为大写或小写

```javascript
var s = 'Hello';
s.toUpperCase(); // 返回'HELLO'
s.toLowerCase(); // 返回'hello'
```

`indexOf()`搜索指定字符串出现的位置

```javascript
var s = 'hello, world';
s.indexOf('world'); // 返回7
s.indexOf('World'); // 没有找到指定的子串，返回-1
```

`substring()`返回指定索引区间的子串

```javascript
var s = 'hello, world'
s.substring(0, 5); // 从索引0开始到5（不包括5），返回'hello'
s.substring(7); // 从索引7开始到结束，返回'world'
```

## 数组

通过`Array.length`获取数组长度，给length赋一个新的值或索引赋值时索引超过了范围，会导致Array大小的变化

```javascript
var arr = [1, 2, 3.14];
arr.length; // 3
arr.length = 4;
arr; // arr变为[1, 2, 3.14, undefined]
arr[5] = 'x';
arr; // arr变为[1, 2, 3, undefined, undefined, 'x']
```

通过`indexOf()`来搜索Array中一个指定的元素的位置

```javascript
var arr = [10, 20, '30', 'xyz'];
arr.indexOf(10); // 元素10的索引为0
arr.indexOf(30); // 元素30没有找到，返回-1
```

通过`slice()`截取Array的部分元素，然后返回一个新的Array

```javascript
var arr = ['A', 'B', 'C', 'D', 'E', 'F', 'G'];
arr.slice(0, 3); // 从索引0开始，到索引3结束，但不包括索引3: ['A', 'B', 'C']
arr.slice(3); // 从索引3开始到结束: ['D', 'E', 'F', 'G']
```
`push()`向Array的末尾添加若干元素，`pop()`则把Array的最后一个元素删除掉,`unshift()`往Array的头部添加若干元素，`shift()`则把Array的第一个元素删掉

```javascript
var arr = [1, 2];
arr.push('A', 'B'); // 返回Array新的长度: 4
arr; // [1, 2, 'A', 'B']
arr.pop(); // pop()返回'B'
arr; // [1, 2, 'A']
arr.unshift('A', 'B'); // 返回Array新的长度: 5
arr; // ['A', 'B', 1, 2, 'A']
arr.shift(); // 'A'
arr; // ['B', 1, 2, 'A']
arr = [];
arr.pop(); // 空数组继续pop不会报错，而是返回undefined
arr.shift(); // 空数组继续shift不会报错，而是返回undefined
```

`sort()`, `reverse()`可以对当前Array进行排序，它会直接修改当前Array的元素位置，直接调用时，按照默认把所有元素先转换为String，再根据ASCII码进行排序

```javascript
var arr = ['B', 'C', 'A', 'b'];
arr.sort();
arr; // ['A', 'B', 'C', 'b']
arr.reverse(); 
arr; //['b', C', 'B', 'A']
```

`splice()`方法可以从指定的索引开始删除若干元素，然后再从该位置添加若干元素：

```javascript
var arr = ['Microsoft', 'Apple', 'Yahoo', 'AOL', 'Excite', 'Oracle'];
// 从索引2开始删除3个元素,然后再添加两个元素:
arr.splice(2, 3, 'Google', 'Facebook'); // 返回删除的元素 ['Yahoo', 'AOL', 'Excite']
arr; // ['Microsoft', 'Apple', 'Google', 'Facebook', 'Oracle']
// 只删除,不添加:
arr.splice(2, 2); // ['Google', 'Facebook']
arr; // ['Microsoft', 'Apple', 'Oracle']
// 只添加,不删除:
arr.splice(2, 0, 'Google', 'Facebook'); // 返回[],因为没有删除任何元素
arr; // ['Microsoft', 'Apple', 'Google', 'Facebook', 'Oracle']
```

`concat()`方法把当前的Array和另一个Array连接起来，并返回一个新的Array：

```javascript
var arr = ['A', 'B', 'C'];
arr.concat(1, 2, [3, 4]); // ['A', 'B', 'C', 1, 2, 3, 4]
arr; // ['A', 'B', 'C']
```

`join()`方法把当前Array的每个元素都用指定的字符串连接起来，然后返回连接后的字符串：

```javascript
var arr = ['A', 'B', 'C', 1, 2, 3];
arr.join('-'); // 'A-B-C-1-2-3'
arr.join(''); // 'ABC123'
```

如果数组的某个元素又是一个Array，则可以形成多维数组

```javascript
var arr = [[1, 2, 3], [400, 500, 600], '-'];
arr[1][1]; //500
```

## 对象

JavaScript的对象是一种无序的集合数据类型，它由若干键值对组成。访问属性是通过`.`操作符完成的，但这要求属性名必须是一个有效的变量名。如果属性名包含特殊字符，就必须用''括起来

```javascript
var xiaoming = {
	name: '小明',
	birth: 1990,
	school: 'No.1 Middle School',
	height: 1.70,
	weight: 65,
	score: null
};
xiaohong['middle-school']; // 'No.1 Middle School'
xiaohong['name']; // '小红'
xiaohong.name; // '小红'
xiaoming.age; // undefined
```
要检测xiaoming是否拥有某一属性，可以用`in`操作符。因为`toString`定义在object对象中，所以xiaoming继承了`toString`属性；可以用`hasOwnProperty()`方法判断一个属性是否是xiaoming自身拥有的，而不是继承得到的。

```javascript
var xiaoming = {
	name: '小明'
};
'toString' in xiaoming; // true
xiaoming.hasOwnProperty('name'); // true
xiaoming.hasOwnProperty('toString'); // false
```

## 条件判断

使用`if () { ... } else { ... }`来进行条件判断，`else if`通常连写在一起，以增加可读性。

```javascript
var age = 3;
if (age >= 18) {
	console.log('adult');
} else if (age >= 6) {
	console.log('teenager');
} else {
	console.log('kid');
}
```

## 循环

for循环最常用的地方是利用索引来遍历数组

```javascript
var arr = ['Apple', 'Google', 'Microsoft'];
var i, x;
for (i=0; i<arr.length; i++) {
	x = arr[i];
	console.log(x);
}
```

for循环的3个条件都是可以省略的，但必须使用`break`语句退出循环，否则就是死循环

```javascript
var x = 0;
for (;;) { // 将无限循环下去
	if (x > 100) {
        break; // 通过if判断来退出循环
    }
    x ++;
}
```

`for ... in`循环可以把一个对象的所有属性依次循环出来

```javascript
var o = {
	name: 'Jack',
	age: 20,
	city: 'Beijing'
};
for (var key in o) {	
    console.log(key); // 'name', 'age', 'city'
}
```

`for ... in`循环可以直接循环出Array的索引，但得到索引的是String而不是Number

```javascript
var a = ['A', 'B', 'C', 1, 2, 3];
for (var i in a) {
	console.log(i)
	console.log(a[i]); 
}
```

while循环只有一个判断条件，条件满足，就不断循环，条件不满足时则退出循环


```javascript
var x = 0;
var n = 99;
while (n > 0) {
	x = x + n;
	n = n - 2;
}
x; // 2500
```

`do { ... } while()`循环，它和while循环的唯一区别在于前者是在每次循环完成的时候判断条件，所以至少会执行一次循环

```javascript
var n = 0;
do {
	n = n + 1;
} while (n < 100);
n; // 100
```

## Map和Set

`Map`是一组键值对的结构，具有极快的查找速度，`Map`具有以下方法：

```javascript
var M = new Map([['Michael', 95], ['Bob', 75], ['Tracy', 85]]);
var m = new Map(); // 空Map
m.set('Adam', 67); // 添加新的key-value
m.set('Bob', 59);
m.has('Adam'); // 是否存在key 'Adam': true
m.get('Adam'); // 67
m.delete('Adam'); // 删除key 'Adam'
m.get('Adam'); // undefined
```
`Set`是一组`key`的集合，不能重复，重复元素在`Set`中自动被过滤

```javascript
var s = new Set([1, 2, 3, 3, '3']);
s; // Set {1, 2, 3, "3"}
s.add(4); // Set {1, 2, 3, "3", 4}
s.delete(2); // Set {1, 3, "3", 4}
s.size; //4
s.has(3); // true
```

## iterable

`for ... of`循环来遍历`Array`、`Map`和`Set`

```javascript
var a = ['A', 'B', 'C'];
var s = new Set(['A', 'B', 'C']);
var m = new Map([[1, 'x'], [2, 'y'], [3, 'z']]);
for (var x of a) { // 遍历Array
	console.log(x);
}
for (var x of s) { // 遍历Set
	console.log(x);
}
for (var x of m) { // 遍历Map
	console.log(x[0] + '<=>' + x[1]);
}
```

`iterable`内置的forEach方法，它接收一个函数，每次迭代就自动回调该函数，以下是Array的例子

```javascript
var a = ['A', 'B', 'C'];
a.forEach(function (element, index, array) {
    // element: 指向当前元素的值
    // index: 指向当前索引
    // array: 指向Array对象本身
    console.log("element: " + element + "; index: " + index + "; array: " + array);
});
```

`Set`与`Array`类似，但`Set`没有索引，因此回调函数的前两个参数都是元素本身

```javascript
var s = new Set(['A', 'B', 'C']);
s.forEach(function (element, sameElement, set) {
	console.log("element: " + element + "; sameElement: " + sameElement + "; set: " + set);
});
```

`Map`的回调函数参数依次为`value`、`key`和`map`本身

```javascript
var m = new Map([[1, 'x'], [2, 'y'], [3, 'z']]);
m.forEach(function (value, key, map) {
	console.log("value: " + value + "; key: " + key + "; map: " + map);
});
```

## 函数定义和调用

```javascript
// 一般定义
function abs(x) {
	return x>0 ? x : -x;
}
// 匿名函数定义
var abs = function (x) {
	return x>0 ? x : -x;
};
```

利用`arguments`获取所有传入参数

```javascript
function abs() {
	if (arguments.length === 0) {
		return 0;
	}
	if (typeof x !== 'number') {
		throw 'Not a number';
	}
	var x = arguments[0];
	return x >= 0 ? x : -x;
}
```

使用`rest`来获取任意个参数，需写在最后面，前面加`...`

```javascript
function foo(a, b, ...rest) {
    console.log('a = ' + a);
    console.log('b = ' + b);
    console.log(rest);
}
// sum()函数，接收任意个参数并返回它们的和
function sum(x, ...rest) {
    let tmp = 0;
    if(x) tmp += x;
    for(let i of rest){
        tmp += i;
    }
    return tmp;
}

```

##　变量作用域

`var`定义变量，该变量的作用域为整个函数体。不在任何函数内定义的变量就具有全局作用域，被绑定到全局对象window的一个属性

```javascript
'use strict';
var course = 'Learn JavaScript';
console.log(course); // 'Learn JavaScript'
console.log(window.course); // 'Learn JavaScript'
function foo() {
    console.log('you foo');
}
foo(); // 直接调用foo()
window.foo(); // 通过window.foo()调用
```

ES6引入了新的关键字`let`，用`let`替代`var`可以申明一个块级作用域(for循环等)的变量

```javascript
function foo() {
    var sum = 0;
    for (let i=0; i<100; i++) {
        sum += i;
    }
    return sum;
}
```

ES6标准引入了新的具有块级作用域的关键字`const`来定义常量

```javascript
const PI = 3.14;
PI = 3; // 某些浏览器不报错，但是无效果！
PI; // 3.14
```

## 方法

在一个对象中绑定函数，称为这个对象的方法，在一个方法内部，`this`是一个特殊变量，它始终指向当前对象

```javascript
var xiaoming = {
    name: '小明',
    birth: 1990,
    age: function () {
        var y = new Date().getFullYear();
        return y - this.birth;
    }
};
xiaoming.age(); //2017年则是27
```

`apply()`可以指定函数的`this`的指向

```javascript
function getAge() {
    var y = new Date().getFullYear();
    return y - this.birth;
}
var xiaoming = {
    name: '小明',
    birth: 1990,
    age: getAge
};
xiaoming.age(); // 25
getAge.apply(xiaoming, []); // 25, this指向xiaoming, 参数为空
```

`call()`方法与`apply()`类似

+ apply()把参数打包成Array再传入；

+ call()把参数按顺序传入。

```javascript
Math.max.apply(null, [3, 5, 4]); // 5
Math.max.call(null, 3, 5, 4); // 5
```

利用`apply()`动态改变函数的行为，如通过用我们自己的函数替换掉默认的parseInt()的方法统计代码一共调用了多少次parseInt()

```javascript
var count = 0;
var oldParseInt = parseInt; // 保存原函数
window.parseInt = function () {
    count += 1;
    return oldParseInt.apply(null, arguments); // 调用原函数
};

// 测试:
parseInt('10');
parseInt('20');
for(let x=0;x<10;x++){
	parseInt('30');
}
count; // 12
```

## 高阶函数

map/reduce

```javascript

```

filter

```javascript

```

sort

```javascript

```

## 闭包

```javascript

```

## 箭头函数

```javascript

```

## generator

```javascript

```