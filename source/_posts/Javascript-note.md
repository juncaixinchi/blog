---
title: Javascript-note
date: 2017-02-22 21:57:57
tags: 
    - javascript
    - ES6
---

# 学习javascript的笔记

主要学习了[JavaScript教程](http://www.liaoxuefeng.com/wiki/001434446689867b27157e896e74d51a89c25cc8b43bdb3000)

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


```javascript

```



```javascript

```



```javascript

```


```javascript

```



```javascript

```


```javascript

```



```javascript

```


```javascript

```



```javascript

```


```javascript

```



```javascript

```