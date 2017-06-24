---
title: Vim-Setting
date: 2017-03-18 20:57:18
tags: 
	- Vim
	- Linux
---

Vim 是高效的文本编辑器，以下是我整理的日常中经常用到的命令与插件

<!-- more -->

## 基本编辑命令

打开文件file

```
vi file
```

进入编辑模式

```
i
```

退出编辑模式，进入命令模式

```
<Esc>
```

保存并退出

```
:wp
```

强制（不保存）退去

```
:q!
```

### 文件命令


将vim窗口分成双栏并打开新文件

```
:vs newfile
```

在多栏窗口中切换

```
ctrl + w + w
```

### 移动命令

移动到第一行

```
gg
```

移动到最后一行

```
G
```

移动到第7行

```
7gg
```

### 插入命令

在当前位置生前插入

```
i
```

在当前行首插入

```
I
```
在当前行尾插入

```
A
```

在当前行之后插入一行

```
o
```

### 复制、粘贴、删除

拷贝当前行或者之后的7行

```
yy
y7y
```

粘贴

```
p
```

删除当前行或者之后的7行

```
dd
d7d
```

### 查找命令

查找text，按n健查找下一个，按N健查找前一个

```
/text
```

查找光标处的单词

```
*
```

设置高亮查找到的内容

```
:set hlsearch
```

全局替换aaa为bbb

```
:%s/aaa/bbb/g
```

用//注释第3-5行

```
:3,5 s/^/\/\/ /g
```

### 撤销和重做

撤销（Undo）

```
u
```

重做（Redo），即撤销的撤销

```
Ctrl + r
```

### VIM 代码折叠

用缩进表示折叠

```
set foldmethod=indent
```

全部折叠

```
:set foldlevelstart=0
```

取消折叠

```
:set foldlevelstart=99
```

使用空格作为折叠快捷键

```
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
```

自动加载view，使得上一次折叠的内容可以保存

```
au BufWinLeave * silent mkview
au BufWinEnter * silent loadview
```

## 安装插件

+ 首先要安装Vundle

```bash
mkdir ~/.vim/bundle

mkdir ~/.vim/bundle/Vundle.vim

cd ~/.vim/bundle/Vundle.vim

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

+ 在.vimrc中配置Vundle，加入以下内容

```
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
" use the command below to install the plugins from the command line
" vim +PluginInstall +qall

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'Valloric/YouCompleteMe'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on
```

+ 在配置文件的Plugin部分添加插件，如插件`vim-jsx`的github链接为 https://github.com/mxw/vim-jsx，于是可以写作

```
Plugin 'mxw/vim-jsx'
```

然后运行以下代码安装插件

```
vim +PluginInstall +qall
```

## 配置文件`.vimrc`

```
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
" use the command below to install the plugins from the command line
" vim +PluginInstall +qall

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'Valloric/YouCompleteMe'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on

" vim-jsx
let g:jsx_ext_required = 0

" syntastic
" see more by ':help syntastic'
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_check_on_w = 0


" fold
set foldmethod=indent
set foldlevelstart=99
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>


" auto mkview & loadview
au BufWinLeave * silent mkview
au BufWinEnter * silent loadview

" indent set tab = 2 blank space
set ts=2
set sw=2
set expandtab
set smartindent
set number

```