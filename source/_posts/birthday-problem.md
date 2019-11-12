---
title: birthday problem
date: 2019-9-4 19:10:05
tags:
    - Algorithm
---

# birthday problem

生日问题是指在随机选择的一群人当中有两人的生日相同的概率。如果一个房间里有23个或23个以上的人，那么至少有两个人的生日相同的概率要大于50%；对于60或者更多的人，这种概率要大于99%。

该问题的计算公式就是 `从365个元素中取出n个元素的排列` 除以 `365的n次方`

通用计算方式如下，即计算拥有`all`个数量属性取值的个体`count` 个时，出现属性值相同的概率，这里考虑到值会比较大，所以使用BigInt
```js
const calc = (count, all) => {
  let c = count
  let result = 1n
  while (c > 0n) {
    c -= 1n
    result *= (all - c)
  }

  return `${Number(1000n - result * 1000n / (all ** count)) / 10}%`
}

calc(23n, 365n) // "50.8%"
calc(60n, 365n) // "99.5%"
```