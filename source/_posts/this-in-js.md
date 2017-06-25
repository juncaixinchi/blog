---
title: this in js
date: 2017-06-07 19:10:45
tags:
  - js
---

## 浅谈js里的this

this是Javascript中的一个关键字，它代表函数运行时，自动生成的一个内部对象，指向调用函数的那个对象

### 两个例子

首先来看几个例子，改编自阮一峰老师的[博客](http://www.ruanyifeng.com/blog/2009/08/learning_javascript_closures.html)

```js
var name = "The Window";

var object1 = {
	name : "My Object1",
	getNameFunc : function(){
		return this.name
	}
};

var object2 = {
	name : "My Object2",
	getNameFunc : () => this.name
};

var object3 = {
	name : "My Object3",
	getNameFunc : function(){
		return function(){
			return this.name;
		};
	}
};

var object4 = {
	name : "My Object4",
	getNameFunc : function(){
		var that = this;
		return function(){
			return that.name;
		};
	}
};


console.log(object1.getNameFunc()); // My Object1
console.log(object2.getNameFunc()); // The Window
console.log(object3.getNameFunc()()); // The Window
console.log(object4.getNameFunc()()); // My Object4
```

* 对比object1和object2，this在function函数中指向object1，在箭头函数中就指向object2的父对象，即全局对象global/window

* 如果嵌套函数的话，如object3，第二层的函数又会重新指向全局对象global/window

* 如object4，可以使用 `that = this` 的方法，获得this的指向


### class constructor中的 this

* 使用了extends的派生类中，使用this前需先使用super

* constructor 里以this定义的函数是稳定绑定该class的, 如this.func

```js
class Polygon {
  constructor(height, width) {
    this.name = 'Polygon';
    this.height = height;
    this.width = width;
    this.func = () => console.log(this.name)
  }
  sayName() {
    console.log('Hi, I am a ', this.name + '.');
  }
}

class Square extends Polygon {
  constructor(length) {
    this.height; // ReferenceError, super needs to be called first!
    
    // Here, it calls the parent class' constructor with lengths
    // provided for the Polygon's width and height
    super(length, length);
    
    // Note: In derived classes, super() must be called before you
    // can use 'this'. Leaving this out will cause a reference error.
    this.name = 'Square';
  }

  get area() {
    return this.height * this.width;
  }

  set area(value) {
    this.height = this.width = Math.sqrt(value);
  } 
}
```
