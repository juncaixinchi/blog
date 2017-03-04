---
title: JSX-Syntax
date: 2017-03-04 19:26:35
tags:
	- React
	- JSX
  - JavaScript
---

# JSX 语法

JSX是React的核心组成部分，它使用XML标记的方式去直接声明界面，界面组件之间可以互相嵌套。可以理解为在JS中编写与XML类似的语言,一种定义带属性树结构（DOM结构）的语法，它的目的不是要在浏览器或者引擎中实现，它的目的是通过各种编译器将这些标记编译成标准的JS语言。

<!-- more -->

## Hello World

首先是官网的例子helloworld，其中`<h1>Hello, world!</h1>`就是使用到了JSX语法。HTML 语言直接写在 JavaScript 语言之中，不加任何引号，这就是 JSX 的语法，它允许 HTML 与 JavaScript 的混写。

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>Hello React!</title>
  <script src="vendor-js/react.js"></script>
  <script src="vendor-js/react-dom.js"></script>
  <script src="vendor-js/babel-core/browser.min.js"></script>
</head>
<body>
  <div id="example"></div>
  <script type="text/babel">
    ReactDOM.render(
      <h1>Hello, world!</h1>,
      document.getElementById('example')
    );
  </script>
</body>
</html>
```

在上述JSX语法中要注意的地方：

+ `<script>` 标签的 type 属性为 `text/babel`，这是React 独有的 JSX 语法，跟 JavaScript 不兼容。凡是在页面中直接使用 JSX 的地方，都要加上 `type="text/babel"`。
+ 一共用了三个库： react.js 、react-dom.js 和 browser.min.js ，它们必须首先加载。其中，react.js 是 React 的核心库，react-dom.js 是提供与 DOM 相关的功能， browser.min.js的作用是将 JSX 语法转为 JavaScript 语法。
+ ReactDOM.render 是 React 的最基本方法，将模板转为HTML语言，并插入指定的 DOM 节点。
+ 将 JSX 语法转为 JavaScript 语法，这一步很消耗时间。现在前端项目，都会使用前端工程化，不会直接在html页面中直接写js代码，写好的js代码都会使用工具进行编译压缩等。这样的话，JSX也会通过编译直接转化成js语法，让浏览器直接使用。

## JSX的特点

+ 类XML语法容易接受，结构清晰
+ 增强JS语义
+ 抽象程度高，屏蔽DOM操作，跨平台
+ 代码模块化

## JSX基本语法规则

JSX本身就和XML语法类似，可以定义属性以及子元素。唯一特殊的是可以用大括号来加入JavaScript表达式，即：

**遇到 HTML 标签（以 < 开头），就用 HTML 规则解析；遇到代码块（以 { 开头），就用 JavaScript 规则解析。**

```JSX
var arr = [
 <h1>Hello world!</h1>,
 <h2>React is awesome</h2>,
];
ReactDOM.render(
 <div>{arr}</div>,
 document.getElementById('example')
);
```

## JavaScript表达式

### 基础语法

用一对大括号 { } 包起来的JavaScript表达式可以作为标签的子结点（children），也可以是属性值

```JSX
// 以下语句等价
<MyComponent>foo</MyComponent>
<MyComponent>{'foo'}</MyComponent>

// JavaScript 表达式作为属性值
React.render(
    <div className={2 > 1 ? 'class-a' : 'class-b'}>content</div>,
    document.body
);
```

### 条件判断的写法

因为 JSX 只是函数调用和对象创建的语法糖，在 { } 中不能 if-else 语句，不过可以采用三元操作表达式

```JSX
var HelloMessage = React.createClass({ 
  render: function() { 
    return <div>Hello {this.props.name ？ this.props.name : "World"}</div>; 
  }
});
ReactDOM.render(<HelloMessage name="xiaowang" />, document.body);
```

可以使用比较运算符“ && ” 和 “ || ”来替代“ if ”

  + “&&” ：如果左边的值为真，才返回右边的表达式，不过要注意&&之前的需要是一个boolean值

  ```JSX
  <div>
    {showHeader && <Header />}
    <Content />
  </div>
  ```

  + “||” ：如果左边的值为真，则直接返回左边的值，否则返回右边的值

  ```JSX
  var HelloMessage = React.createClass({ 
    render: function() { 
      return <div>Hello {this.props.name || "World"}</div>; 
    }
  });
  ```

## Children in JSX

在JSX表达式中包括开标签和闭标签，这俩个标签之间的内容被定义为一个特殊的prop，即props.children

### String Literals as Children

开标签和闭标签的内容或者props.children的值可以是一个string，这与HTML的语法相同

```JSX
<MyComponent>Hello world!</MyComponent>
<div>This is valid HTML &amp; JSX at the same time.</div>
```

### JSX elements as the Children

Children也可以是一个JSX element，以下是一个“纯组件”的例子

```JSX
<MyContainer>
  <MyFirstComponent />
  <MySecondComponent />
</MyContainer>
```

### JavaScript Expressions as Children

children也可以是JavaScript表达式，需要用{}包起来，以下是渲染一个任意行数的HTML list的例子

```JSX
function Item(props) {
  return <li>{props.message}</li>;
}

function TodoList() {
  const todos = ['finish doc', 'submit pr', 'nag dan to review'];
  return (
    <ul>
      {todos.map((message) => <Item key={message} message={message} />)}
    </ul>
  );
}
```

### Functions as Children

一般情况下，在JSX中的插入的JavaScript表达式会最终表现为string、React element或者这些内容形成的list。但是props.children实际上可以传递任何数据，不需要一定是React可以render的内容。例如，可以自定义一个组件，其children是一个函数，最终函数的callback作为props.children

```JSX
// Calls the children callback numTimes to produce a repeated component
function Repeat(props) {
  let items = [];
  for (let i = 0; i < props.numTimes; i++) {
    items.push(props.children(i));
  }
  return <div>{items}</div>;
}

function ListOfTenThings() {
  return (
    <Repeat numTimes={10}>
      {(index) => <div key={index}>This is item {index} in the list</div>}
    </Repeat>
  );
}
```
所以说Children传给组件的可以是任意内容，只要组件能够在render前，将children转化为React能够理解的内容即可。

## 注释

render函数内的注释需要写在花括号中，实例如下：

```JSX
ReactDOM.render(
    <div>
    <h1>菜鸟教程</h1>
    {/*注释...*/}
     </div>,
    document.getElementById('example')
);
```

## JSX 陷阱

+ style属性
{% raw %}
  在React中写行内样式时，要使用`style={{}}`的方式，属性值不能是字符串而必须为对象，需要注意的是属性名同样需要驼峰命名法。即`margin-top`要写成`marginTop`。
{% endraw %}
  > 骆驼式命名法就是当变量名或函式名是由一个或多个单词连结在一起，而构成的唯一识别字时，第一个单词以小写字母开始；第二个单词的首字母大写或每一个单词的首字母都采用大写字母，例如：myFirstName、myLastName 等，这样的变量名看上去就像骆驼峰一样此起彼伏，故得名。

  ```JSX
  React.render(
      <div style={{color:'red'}}>
          xxxxx
      </div>,
      document.body
  );
  ```

+ HTML转义

  React默认会进行HTML的转义，避免XSS攻击

  ```JSX
  var content='<strong>content</strong>';
  React.render(
      <div>{content}</div>,
      document.body
  );
  //结果页面直接输出内容了"<strong>content</strong>"
  ```

+ 自定义HTML属性

  如果往原生 HTML 元素里传入 HTML 规范里不存在的属性，React 不会显示它们。如果需要使用自定义属性，要加 `data-` 前缀。 

  ```JSX
  <div data-custom-attribute="foo" />
  ```

+ 组件类只能包含一个顶层标签

  ```JSX
  //var myDivElement =<h1>你好</h1><h1>hello</h1>;
  //上述写法是会报错的，要写成只有一个顶层标签：
  var myDivElement =<div><h1>你好</h1><h1>hello</h1></div>;
  ```
+ Boolean 属性

  省略一个属性的值会导致JSX把它当做 true。要传值 false必须使用属性表达式。这常出现于使用HTML表单元素，含有属性如disabled, required, checked 和 readOnly。

  ```JSX
  // 在JSX中，对于禁用按钮这二者是相同的。
  <input type="button" disabled />;
  <input type="button" disabled={true} />;

  // 在JSX中，对于不禁用按钮这二者是相同的。
  <input type="button" />;
  <input type="button" disabled={false} />;
  ```

## React组件

### 基础用法

使用JSX来将代码封装成React组件，然后像插入普通 HTML 标签一样，在其他地方插入这个组件。使用React.createClass用于生成一个组件。

```JSX
var MyComponent=React.createClass({
  render: function() {
   return <h1>Hello world!</h1>;
 }
});
ReactDOM.render(
 <MyComponent />,
 document.getElementById('example')
);
```

上面代码中，变量 MyComponent就是一个组件类。模板插入 <MyComponent /> 时，会自动生成 MyComponent 的一个实例（下文的"组件"都指组件类的实例）。

** 所有组件类都必须有自己的 render 方法，用于输出组件。 **

### HTML 标签 vs. React 组件

React 可以渲染 HTML 标签 (strings) 或 React 组件 (classes)。

  + 渲染HTML标签，声明变量采用首字母小写

  ```JSX
  //要渲染 HTML 标签，只需在 JSX 里使用小写字母开头的标签名。
  var myDivElement = <div className="foo" />;
  React.render(myDivElement, document.getElementById('example'));
  ```

  + 渲染React组件，声明变量采用首字母大写

  ```JSX
  //要渲染 React 组件，只需创建一个大写字母开头的本地变量。
  var MyComponent = React.createClass({/*...*/});
  var myElement = <MyComponent  />;
  React.render(myElement, document.getElementById('example'));
  ```

### 动态组件

```JSX
var MyComponent=React.createClass({
  getInitialState: function() {
       return {clickNum: 0};
  },
  handleClick:function(){
    var num=this.state.clickNum;
    num++;
    this.setState({clickNum:num});
  },
  render: function() {
   return (
      <div>
        <h1 onClick={this.handleClick}>Hello {this.props.name}!</h1>
        <h2 style={{color:'red'}}>点击{this.props.name}次数：{this.state.clickNum}</h2>
      </div>
    );
 }
});
ReactDOM.render(
  <div>
     <MyComponent name="张三" />
     <hr/>
     <MyComponent name="李四" />
  </div>,
 document.getElementById('example')
);
```

上面代码中定义的MyComponent组件包含属性，状态和事件，是一个简单的比较完整的组件。

+ 使用props通过父组件进行传递值
+ 使用state定义组件自己的状态
+ 组件支持的大部分的DOM操作事件

### 属性props的注意要点

+ class 属性需要写成 className ，for 属性需要写成 htmlFor ，这是因为 class 和 for 是 JavaScript 的保留字。
+this.props.children 不要children作为把对象的属性名。因为this.props.children获取的该标签下的所有子标签。this.props.children 的值有三种可能：如果当前组件没有子节点，它就是 undefined ;如果有一个子节点，数据类型是 object ；如果有多个子节点，数据类型就是 array 。所以，处理 this.props.children 的时候要小心。官方建议使用React.Children.map来遍历子节点，而不用担心数据类型。

### 状态state的注意要点

+ 组件免不了要与用户互动，React 将组件看成是一个状态机，一开始有一个初始状态，然后用户互动，导致状态变化，从而触发重新渲染 UI。
+ getInitialState 方法用于定义初始状态，也就是一个对象，这个对象可以通过 this.state 属性读取。当用户点击组件，导致状态变化，this.setState 方法就修改状态值，每次修改以后，自动调用 this.render 方法，再次渲染组件。

由于 this.props 和 this.state 的简单的区分方法：

**this.props 表示那些一旦定义，就不再改变的特性，而 this.state 是会随着用户互动而产生变化的特性。**