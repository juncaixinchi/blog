---
title: Unicode and JS
date: 2018-01-28 19:13:25
tags: 
    - JavaScript
---

之前处理中文字符与emoji时遇到了一些坑，查阅了资料整理了一下要点。

<!-- more -->

### Unicode

Unicode是目前绝大多数程序使用的字符编码，定义也很简单，用一个码点(code point)映射一个字符。码点值的范围是从U+0000到U+10FFFF，可以表示超过110万个符号。Unicode源于一个很简单的想法：将全世界所有的字符包含在一个集合里，计算机只要支持这一个字符集，就能显示所有的字符，再也不会有乱码了。

目前，Unicode的最新版本是7.0版，一共收入了109449个符号，其中的中日韩文字为74500个。可以近似认为，全世界现有的符号当中，三分之二以上来自东亚文字。比如，中文"好"的码点是十六进制的597D。

Unicode最前面的65536个字符位，称为基本平面（BMP-—Basic Multilingual Plane），它的码点范围是从U+0000到U+FFFF。最常见的字符都放在这个平面，这是Unicode最先定义和公布的一个平面。 
剩下的字符都放在补充平面（Supplementary Plane），码点范围从U+010000一直到U+10FFFF，共16个。

### JS的编码

UTF（Unicode transformation format）Unicode转换格式，是服务于Unicode的，用于将一个Unicode码点转换为特定的字节序列。常见的UTF有

```
UTF-8 可变字节序列，用1到4个字节表示一个码点 
UTF-16 可变字节序列，用2或4个字节表示一个码点 
UTF-32 固定字节序列，用4个字节表示一个码点
```

UTF-8对ASCⅡ编码是兼容的，都是一个字节，超过U+07FF的部分则用了复杂的转换方式来映射Unicode。

然而js用的编码却是已经过时了的UCS-2

```
1990 UCS-2 诞生 
1995.5 JavaScript 诞生 
1996.7 UTF-16 诞生
```

也就是说，Brendan Eich在写JS的时候，UTF-16还没问世，所以只能用UCS-2的方式来处理字符，也因此留下了隐患。

### 潜在的问题

#### length属性

emoji等16位的字符的长度会被认为是2，slice等函数也会因此出现问题

```js
'😀'.length // 2

// 正确方法
Array.from('😀').length

'😀😀'.slice(0,1) // "�"

'😀😀'.slice(0,2) // "😀"
```

使用正则匹配，将字符串转化为数组，可解决该问题

```js
const slice = (str, start, end) => {
  const arr = str.match(/[\uD800-\uDBFF][\uDC00-\uDFFF]|[^\uD800-\uDFFF]/g) || []
  return arr.slice(start, end).join('')
}

slice('😀😀',0,1) // 😀
```

ES6可以自动识别4字节的码点，遍历字符串的方法
```js
for (let s of string ) {
  // ...
}
```
#### 码点与字符互转

String.fromCharCode可以将一个码点转换为字符,charCodeAt则反之。

但是用在emoji上就会出问题，要使用es6的fromCodePoint和codePointAt才行


```js
'好'.charCodeAt(0).toString(16) // '597d'
String.fromCharCode(0x597d) // 好


/* error */
'😀'.charCodeAt(0).toString(16) //d83d
'😀'.codePointAt(0).toString(16) // 1f600

/* correct */
String.fromCharCode(0x1f600) // ''
String.fromCodePoint(0x1f600) // '😀'
```

#### 正则匹配

正则匹配符.只能匹配单个“字符”，但js将代理对当成两个单独的“字符”处理，所以匹配不到任何辅助平面字符。
ES6通过增加一个u标志来解决这个问题

```js
/foo.bar/u.test('foo😀bar')
```

### 汉字编码

Unicode中的汉字是CJK统一汉字，可以通过以下正则判断字符是否包含汉字

```js
const isCJK = /[\u4E00-\u9FFF\u3400-\u4dbf\uf900-\ufaff\u3040-\u309f\uac00-\ud7af]+/g
'somestring'.test(isCJK) // false
'somestring啊'.test(isCJK) // true
```

产生随机的汉字

```js
/* produce random chinese words */
Array.from({ length: Math.random() * 10 + 1 }).map(() => String.fromCharCode(0x597D - Math.random() * 100))
```