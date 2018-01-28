---
title: CharCode in JS
date: 2018-01-28 19:13:25
tags: 
    - JS
---


```js
'好'.charCodeAt(0).toString(16) // '597d'
String.fromCharCode(0x597d) // 好

/* produce random chinese words */
Array.from({ length: Math.random() * 10 }).map(() => String.fromCharCode(0x597D - Math.random() * 100))
```