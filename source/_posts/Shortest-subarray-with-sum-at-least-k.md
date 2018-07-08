---
title: Shortest subarray with sum at least k
date: 2018-07-08 22:21:10
tags:
  - Algorithm
---

在LeetCode刷算法题，记录一下一道比较难的题目[和至少为 K 的最短子数组](https://leetcode-cn.com/problems/shortest-subarray-with-sum-at-least-k/description/)

### 问题描述

返回 A 的最短的非空连续子数组的长度，该子数组的和至少为 K 。

如果没有和至少为 K 的非空子数组，返回 -1 。

其中：

+ 1 <= A.length <= 50000
+ -10 ^ 5 <= A[i] <= 10 ^ 5
+ 1 <= K <= 10 ^ 9

最先想到的是依照数值长度进行遍历，但时间复杂度为O(n^2)

```js
/**
 * @param {number[]} A
 * @param {number} K
 * @return {number}
 */
const shortestSubarray = (A, K) => {
  let preSum = 0
  let count = 1
  while (count <= A.length) {
    preSum += A[count - 1]
    let sum = preSum
    if (sum >= K) return count
    for (let i = 1; i + count <= A.length; i ++) {
      sum = sum - A[i - 1] + A[i + count - 1]
      if (sum >= K) return count
    }
    count += 1
  }
  return -1
}

```
之后参考了网上的资料，可以使用Sliding Window的方法，复杂度可以下降到O(N)

```js
/**
 * @param {number[]} A
 * @param {number} K
 * @return {number}
 */
const shortestSubarray = (A, K) => {
  if (!A.length) return -1
  let S = [0]
  for (let i = 0; i < A.length; i++) {
    S[i + 1] = S[i] + A[i]
  }
  const queue = []
  let ans = A.length + 1
  for (let j = 0; j < A.length + 1; j++) { 
    while (queue.length && S[j] <= S[queue[queue.length - 1]]) {
      queue.pop()
    }
    while(queue.length && S[j] >= S[queue[0]] + K) {
      ans = Math.min(ans, j - queue.shift())
    }
    queue.push(j)
  }
  return ans < A.length + 1 ? ans : -1
}
```