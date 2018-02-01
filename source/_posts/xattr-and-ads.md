---
title: xattr and ads
date: 2017-08-05 19:25:04
tags:
    - xattr
    - ads
---

扩展文件属性（extended attributes）
===

### Extended Attributes

`Extended Attributes`即扩展文件属性， 是文件系统的一个功能。它允许用户将计算机文件与未被文件系统所解释的元数据关联起来。其典型应用包括存储文档作者、普通文本文件的字符编码或者校验码。

+ Linux or macOS

在Linux操作系统中，如果libattr功能在内核设置中被打开，ext2、ext3、ext4、JFS、ReiserFS以及XFS文件系统都支持扩展属性（英文简写为xattr）

Mac OS X 10.4 及以上版本在 HFS+ 文件系统上也支持xattr

JS中可以使用[fs-xattr](https://www.npmjs.com/package/fs-xattr) 读取和写入xattr

修改xattr不会修改文件的mtime，故可以将需要存储的数据及time stamp一起存入xattr，读取时通过比较mtime，可以检验数据的时效性。

+ Windows

windows不支持xattr，但是可以使用NTFS的`Alternate Data Streams`来代替，对应的JS库是 [fs-ads](https://www.npmjs.com/package/fs-ads)

但是需要注意的是，修改ads会改变文件的mtime，所以在保证数据的时效性方面比较麻烦。

采用 `atime + size`的方法大部分情况可以保证准确性，但并不完备。