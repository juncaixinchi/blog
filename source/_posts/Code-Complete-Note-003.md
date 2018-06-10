---
title: Code Complete Note 003
date: 2018-06-10 19:15:37
tags:
    - Code Complete
---

# 代码大全读书笔记003-条件语句

条件语句是代码中非常基础的语法，以下是写成好的代码所需要遵循的指导原则

<!-- more -->

+ 先处理正常代码路径，再处理不常见的情况，通常正常情况放在if之后而不是else

+ 确保对于等量的分支是正确的，避免off-by-one偏差

+ if语句后跟随一个有意义的语句

+ if子句与else子句的排序应该是清晰而易于理解的

+ if-else语句的最后一个else或case语句的default可以用来捕捉错误