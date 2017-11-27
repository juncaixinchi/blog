---
title: Array method in JavaScript
date: 2017-11-26 21:42:38
tags: 
    - JavaScript
---

# Array method 学习笔记

系统地学习一下JS中Array的方法，并做个简单的笔记

<!-- more -->

### Array.from()

从`array-like` or `iterable object`创建一个新的数组，等价于`...`运算符

+ Syntax

```js
Array.from(arrayLike[, mapFn[, thisArg]])
```

+ from Array

```js
Array.from([1, 2, 3]) // [1, 2, 3]
```


+ from string

```js
Array.from('string') // [ 's', 't', 'r', 'i', 'n', 'g' ]
[...'string']
```

+ fromm a `Map`

```js
const m = new Map([[1, 'bar'], [2, 'foo']])
Array.from(m)
[...m]
```

+ from an Array-like object (arguments)

```js
function f() {
  return Array.from(arguments)
}

f(1,2,3) // [1, 2, 3]
```

+ 使用箭头函数，相当于`map`方法

```js
/* Using an arrow function as the map function to manipulate the elements */
Array.from([1, 2, 3], x => x * x) // [2, 4, 6]
```

+ 生成数列，注意 `v` 的值为`undefined`

```js
Array.from({length: 5}, (v, i) => i + 1) // [1, 2, 3, 4, 5]
```

### Array.isArray()

判断一个变量是否是一个数组

+ Syntax

```js
Array.isArray(obj)
```

+ 例子

```js
Array.isArray([]) // true
Array.isArray(Array.prototype) // true

Array.isArray(null) // false
Array.isArray(undefined) // false
```

### Array.of()

与Array()类似，但是处理单个整数变量的结果不同

```js
Array.of(7);       // [7] 
Array.of(1, 2, 3); // [1, 2, 3]

Array(7);          // [ , , , , , , ]
Array(1, 2, 3);    // [1, 2, 3]
```

### Array.prototype.concat()

合并两个或更多数组，形成一个新的数组

+ Syntax

```js
const new_array = old_array.concat(value1[, value2[, ...[, valueN]]])
```

+ 例子

```js
const alpha = ['a', 'b', 'c']
const alphaNumeric = alpha.concat(1, [2, 3]) // ['a', 'b', 'c', 1, 2, 3]

const num = [1, [2, 3]]
const alphaNumeric2 = alpha.concat(num) // ['a', 'b', 'c', 1, [2, 3]] 
```

### Array.prototype.copyWithin()

在当前数组内部，将指定位置的成员复制到其他位置（会覆盖原有成员），然后返回当前数组。使用这个方法，会修改当前数组。

+ Syntax

```js
arr.copyWithin(target, start, end)
```

`target`: 序列将被复制到的目标位置
`start`: 被复制序列的起点，默认为`0`
`end`: 被复制序列的终点，默认为`arr.length`

+ 例子

```js
['alpha', 'bravo', 'charlie', 'delta'].copyWithin(2, 0) // ["alpha", "bravo", "alpha", "bravo"]

[1, 2, 3, 4, 5].copyWithin(-2, -3, -1) // [1, 2, 3, 3, 4]
```