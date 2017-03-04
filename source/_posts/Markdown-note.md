---
title: Markdown note
date: 2017-02-12 16:41:46
tags: 
    - Markdown
    - Cheat-sheet
---

Markdown语法摘要
===

### 基本格式

标记+空格+内容

<!-- more -->

### 标题

    # 一级标题 #
    
    ## 二级标题
    
    ### 三级标题

以此类推，共6级标题，后面的\#可加可不加

或者

    一级标题  
    ===
    
    二级标题  
    ---

### 列表

    + 无序列表
    
    - 无序列表
    
    * 无序列表
    
    1. 有序列表
    
    2. 有序列表
### 引用

    > 引用

MarkdownPad2快捷键为ctrl+q

### 图片与链接

链接：

    []()
    [github](https://github.com)

图片：

    ![]()
    ![icon](https://juncaixinchi.github.io/juncaixinchi.xyz/favicon.ico)

实例效果：

[github](https://github.com) ![icon](https://juncaixinchi.github.io/juncaixinchi.xyz/favicon.ico)

或者

    This is [an example][id] reference-style link.
        
    [id]: http://example.com/  "Optional Title Here"

实例:

This is [an example][id] reference-style link.
[id]: http://example.com/  "Optional Title Here"

### 文本样式
    
    *斜体文本*
    _斜体文本_
    
    **粗体文本**
    __粗体文本__

注意必须前后包围，且不连空格

样式： *斜体文本*  __粗体文本__

### 代码框

使用 ` 符号

    ` code `

Tab和空格
    
    Tab或4个空格+code

使用```包裹的方式，可加具体语言类型

    ```javascript
    code
    ```

### 分割线

    ***
    * * *
    ---
    ___

三个及以上 * 或 - 或 _ ，其间可有空格。

样式：

***

### 需要转义的字符

    \   反斜线
    `   反引号
    *   星号
    _   底线
    {}  花括号
    []  方括号
    ()  括弧
    #   井字号
    +   加号
    -   减号
    .   英文句点
    !   惊叹号