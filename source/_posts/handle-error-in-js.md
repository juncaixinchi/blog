---
title: handle error in js
date: 2017-07-12 20:11:49
tags:
	- JavaScript
---

```js
try {
  something
} catch (e) {
  window.location.href = `http://stackoverflow.com/search?q=[js]${e.message}`
}
```