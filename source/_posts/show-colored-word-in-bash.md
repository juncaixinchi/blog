---
title: show colored word in bash
date: 2019-2-12 19:39:59
tags:
---

# echo color in bash console

```bash
echo -e "\033[01;32m 绿色字体 √ \033[0m"
```

```js
console.log('\033[01;32m', '绿色字体 √')
```

# color matrix
```js
for (let i = 0; i < 64; i++) {
  for (let j = 32; j < 48; j++) {
    const ii = i.toString().padStart(2, '0')
    const jj = j.toString().padStart(2, '0')
    const str = '\033' + `[${ii};${jj}m` + `[${ii};${jj}m` + '\033[0m '
    process.stdout.write(str)
  }
  process.stdout.write('\n')
}
```