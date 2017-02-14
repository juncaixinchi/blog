---
title: Git_note
date: 2017-02-14 19:36:07
tags: 
	- Git
	- Github
---
Git note
===

学习Git的笔记，完整文档见[Git-scm](https://git-scm.com/book/zh/v2)

<!-- more -->

##	Git 配置

### 获取升级

	$ git clone git://git.kernel.org/pub/scm/git/git.git

### 添加用户信息，并查看配置文件，添加[别名](#_14)

	$ git config --global user.name "lixinwei"
	$ git config --global user.email lixinwei2017@foxmail.com
	$ less ~/.gitconfig

### 获取帮助

	$ git help <verb>
	$ git <verb> --help
	$ man git-<verb>

## Git 基础

### 在现有目录中初始化仓库

	$ git init

该命令将创建一个名为 .git 的子目录，这个子目录含有你初始化的 Git 仓库中所有的必须文件，这些文件是 Git 仓库的骨干。 但是，在这个时候，我们仅仅是做了一个初始化的操作，你的项目里的文件还没有被跟踪。

	$ git add *
	$ git commit -m 'initial project version'

在一个已经存在文件的文件夹（而不是空文件夹）中初始化 Git 仓库来进行版本控制的话，应该开始跟踪这些文件并提交。 

### 克隆现有的仓库

	$ git clone https://github.com/juncaixinchi/blog-generater.git

克隆blog-generater至当前目录

### 记录每次更新到仓库

	$ git add README

使用命令 git add 开始跟踪跟踪 README 文件

	$ git status

	$ git status -s

检查当前文件状态，加-s为简略信息

### 忽略文件

创建一个名为 .gitignore 的文件，列出要忽略的文件模式，文件 .gitignore 的格式规范如下：

+ 所有空行或者以 ＃ 开头的行都会被 Git 忽略。
+ 要忽略指定模式以外的文件或目录，可以在模式前加上惊叹号（!）取反。

		# no .a files
		*.a

+ 匹配模式可以以（/）开头防止递归。

		# only ignore the TODO file in the current directory, not subdir/TODO
		/TODO

+ 匹配模式可以以（/）结尾指定目录。

		# ignore all files in the build/ directory
		build/

+ 可以使用标准的 glob 模式匹配。

		# ignore doc/notes.txt, but not doc/server/arch.txt
		doc/*.txt

		# ignore all .pdf files in the doc/ directory
		doc/**/*.pdf

### 提交更新

commit命令会提交更新，-m参数可添加提交备注，或者随机生成备注 O__O

	$ git commit -m "update"
	$ git commit -m "`curl -s http://whatthecommit.com/index.txt`"

给 git commit 加上 -a 选项，Git 就会自动把所有已经跟踪过的文件暂存起来一并提交，从而跳过 add 步骤

	$ git commit -a -m 'update without git add'

不过正式的提交还是应该避免-m 添加备注，而是详细的添加

### 移除文件或移动文件

使用 rm 命令将文件从已跟踪文件清单中移除，并连带从工作目录中删除指定的文件，如果删除之前修改过并且已经放到暂存区域的话，则必须要用强制删除选项 -f

	$ git rm file_to_remove.md
	$ git mv file_from file_to

### 查看提交历史

查看所有log

	$ git log

显示最近两次提交的差异

	$ git log -p -2

显示每次提交的简略的统计信息

	$ git log --stat

以pretty的方式显示提交历史

	$ git log --pretty=oneline

添加了一些ASCII字符串来形象地展示你的分支、合并历史：

	$ git log --pretty=format:"%h %s" --graph

只显示作者L在2周内提交的近5条记录

	$ git log --author L --since=2.weeks -5

### 撤消操作
	
尝试重新提交,第二次提交将代替第一次提交的结果

	$ git commit -m 'initial commit'
	$ git add forgotten_file
	$ git commit --amend

取消暂存的文件file_to_cancle.txt(git add 的相反操作)

	$ git reset HEAD file_to_cancle.txt

撤消对文件的修改，恢复文件file_to_restore.txt到上次提交时候的状态

	$ git checkout -- file_to_restore.txt

### 远程仓库的使用

查看远程仓库

	$ git remote -v
	$ git remote show

添加远程仓库，默认为 origin

	$ git remote add <shortname> <url>
	$ git remote add pd https://github.com/juncaixinchi/blog-generater.git

从远程仓库中抓取，默认从origin抓取，也可自定义
	
	$ git fetch
	$ git fetch https://github.com/juncaixinchi/blog-generater.git
	$ git fetch origin master:tmp

git fetch不会自动merge，需再merge

	$ git fetch origin master:tmp
	$ git diff tmp
	$ git merge tmp

直接从远程获取最新版本并merge到本地

	$ git pull origin master

使用 git push (remote) (branch)推送到远程仓库，默认推送到origin/master, 也可自定义远程仓库及分支（如serverfix）
	
	$ git push
	$ git push https://github.com/juncaixinchi/blog-generater.git
	$ git push origin serverfix
	$ git push origin serverfix:awesomebranch

设置其他的跟踪分支 - 其他远程仓库上的跟踪分支，或者不跟踪 master 分支

	$ git checkout --track origin/serverfix

远程仓库的移除和重命名

	$ git remote rm paul
	$ git remote rename pb paul

删除远程分支serverfix

	$ git push origin --delete serverfix

### 打标签

列出已有标签

	$ git tag

创建一个附注标签，指定提交的校验和（或部分校验和）则可后期打标签

	$ git tag -a v1.4 -m 'my version 1.4'
	$ git tag -a v0.0 -m "origin version" c76e548

共享标签

	$ git push origin v1.5

### 设置别名

通过 config 为命令设置别名，外部程序的命令则要加!，使用cmu直接add 及 commit 

	$ git config --global alias.co checkout
	$ git config --global alias.br branch
	$ git config --global alias.st status
	$ git config --global alias.last 'log -1 HEAD'
	$ git config --global alias.hexo '!hexo g -delpoy'
	$ git config --global alias.cmu 'commit -a -m "update"'
	$ git config --global alias.logbr 'log --oneline --decorate --graph --all -20'

## Git 分支

### 分支的新建和合并

创建分支testing，分支切换为testing，然后commit内容将在test分支进行

	$ git branch testing
	$ git checkout testing

或者在过去某个版本，如593015f,建立分支testing

	$ git log --oneline --decorate --graph --all
	$ git checkout 593015f
	$ git checkout -b testing

使用 log 命令查看各个分支当前所指的对象。 提供这一功能的参数是 --decorate。

	$ git log --oneline --decorate
	$ git log --oneline --decorate --graph --all

使用 merge 来合并分支

	$ git merger testing

如果 master 和 testing 分支都各有提交新版本，则无法自动合并，会出现如下错误，需要手动编辑冲突的文件，然后再 commit，

	Auto Merge Failed; Fix Conflicts and Then Commit the Result

例如冲突的文件内容为：

	<<<<<<< HEAD:index.html
	<div id="footer">contact : email.support@github.com</div>
	=======
	<div id="footer">
	 please contact us at support@github.com
	</div>
	>>>>>>> testing:index.html

这表示 HEAD 所指示的版本（也就是你的 master 分支所在的位置）在这个区段的上半部分（======= 的上半部分），而 testing 分支所指示的版本在 ======= 的下半部分。 为了解决冲突，必须选择使用由 ======= 分割的两部分中的一个，或者也可以自行合并这些内容。 例如，通过把这段内容换成下面的样子来解决冲突：

	<div id="footer">
	please contact us at email.support@github.com
	</div>

另外也可以使用图形化工具来解决冲突

	$ git mergetool

合并完成后删除分支testing

	$ git branch -d testing

### 分支的管理

显示分支列表

	$ git branch

查看每一个分支的最后一次提交

	$ git branch -v

查看已经合并或尚未合并到当前分支的分支

	$ git branch --merged
	$ git branch --no-merged

删除和强制删除分支

	$ git branch -d testing
	$ git branch -D testing

### 分支整合之变基

使用 rebase 命令将提交到某一分支 testing 上的所有修改都移至另一分支 master 上，然后回到 master 分支，进行一次快进合并。

	$ git checkout testing
	$ git rebase master
	
	$ git checkout master
	$ git merge testing

直接将特性分支（testing）变基到目标分支（即 master）上

	$ git rebase master testing

对两个分支进行变基时，将 client 中的修改合并到主分支并发布，但暂时并不合并 server 中的修改
	
	$ git rebase --onto master server client

变基的风险：`不要对在仓库外有副本的分支执行变基`

## Git协议

### 本地协议

本地协议，其中的远程版本库就是硬盘内的另一个目录，一般使用硬链接（hard link）或直接复制所需要的文件，
	
	$ git clone /opt/git/project.git

增加一个本地版本库到现有的 Git 项目

	$ git remote add local_proj /opt/git/project.git

### HTTP 协议

Clone with HTTPS, Use Git or checkout with SVN using the web URL. 

	$ git clone https://example.com/gitproject.git
	$ git clone https://github.com/juncaixinchi/blog-generater.git

### SSH 协议

Clone with SSH, Use an SSH key and passphrase from account.
	
	$ git clone user@server:project.git
	$ git clone git@github.com:juncaixinchi/blog-generater.git
Git note
===

完整文档见[Git-scm](https://git-scm.com/book/zh/v2)

##	Git 配置

### 获取升级

	$ git clone git://git.kernel.org/pub/scm/git/git.git

### 添加用户信息，并查看配置文件，添加[别名](#_14)

	$ git config --global user.name "lixinwei"
	$ git config --global user.email lixinwei2017@foxmail.com
	$ less ~/.gitconfig

### 获取帮助

	$ git help <verb>
	$ git <verb> --help
	$ man git-<verb>

## Git 基础

### 在现有目录中初始化仓库

	$ git init

该命令将创建一个名为 .git 的子目录，这个子目录含有你初始化的 Git 仓库中所有的必须文件，这些文件是 Git 仓库的骨干。 但是，在这个时候，我们仅仅是做了一个初始化的操作，你的项目里的文件还没有被跟踪。

	$ git add *
	$ git commit -m 'initial project version'

在一个已经存在文件的文件夹（而不是空文件夹）中初始化 Git 仓库来进行版本控制的话，应该开始跟踪这些文件并提交。 

### 克隆现有的仓库

	$ git clone https://github.com/juncaixinchi/blog-generater.git

克隆blog-generater至当前目录

### 记录每次更新到仓库

	$ git add README

使用命令 git add 开始跟踪跟踪 README 文件

	$ git status

	$ git status -s

检查当前文件状态，加-s为简略信息

### 忽略文件

创建一个名为 .gitignore 的文件，列出要忽略的文件模式，文件 .gitignore 的格式规范如下：

+ 所有空行或者以 ＃ 开头的行都会被 Git 忽略。
+ 要忽略指定模式以外的文件或目录，可以在模式前加上惊叹号（!）取反。

		# no .a files
		*.a

+ 匹配模式可以以（/）开头防止递归。

		# only ignore the TODO file in the current directory, not subdir/TODO
		/TODO

+ 匹配模式可以以（/）结尾指定目录。

		# ignore all files in the build/ directory
		build/

+ 可以使用标准的 glob 模式匹配。

		# ignore doc/notes.txt, but not doc/server/arch.txt
		doc/*.txt

		# ignore all .pdf files in the doc/ directory
		doc/**/*.pdf

### 提交更新

commit命令会提交更新，-m参数可添加提交备注，或者随机生成备注 O__O

	$ git commit -m "update"
	$ git commit -m "`curl -s http://whatthecommit.com/index.txt`"

给 git commit 加上 -a 选项，Git 就会自动把所有已经跟踪过的文件暂存起来一并提交，从而跳过 add 步骤

	$ git commit -a -m 'update without git add'

不过正式的提交还是应该避免-m 添加备注，而是详细的添加

### 移除文件或移动文件

使用 rm 命令将文件从已跟踪文件清单中移除，并连带从工作目录中删除指定的文件，如果删除之前修改过并且已经放到暂存区域的话，则必须要用强制删除选项 -f

	$ git rm file_to_remove.md
	$ git mv file_from file_to

### 查看提交历史

查看所有log

	$ git log

显示最近两次提交的差异

	$ git log -p -2

显示每次提交的简略的统计信息

	$ git log --stat

以pretty的方式显示提交历史

	$ git log --pretty=oneline

添加了一些ASCII字符串来形象地展示你的分支、合并历史：

	$ git log --pretty=format:"%h %s" --graph

只显示作者L在2周内提交的近5条记录

	$ git log --author L --since=2.weeks -5

### 撤消操作
	
尝试重新提交,第二次提交将代替第一次提交的结果

	$ git commit -m 'initial commit'
	$ git add forgotten_file
	$ git commit --amend

取消暂存的文件file_to_cancle.txt(git add 的相反操作)

	$ git reset HEAD file_to_cancle.txt

撤消对文件的修改，恢复文件file_to_restore.txt到上次提交时候的状态

	$ git checkout -- file_to_restore.txt

### 远程仓库的使用

查看远程仓库

	$ git remote -v
	$ git remote show

添加远程仓库，默认为 origin

	$ git remote add <shortname> <url>
	$ git remote add pd https://github.com/juncaixinchi/blog-generater.git

从远程仓库中抓取，默认从origin抓取，也可自定义
	
	$ git fetch
	$ git fetch https://github.com/juncaixinchi/blog-generater.git
	$ git fetch origin master:tmp

git fetch不会自动merge，需再merge

	$ git fetch origin master:tmp
	$ git diff tmp
	$ git merge tmp

直接从远程获取最新版本并merge到本地

	$ git pull origin master

使用 git push (remote) (branch)推送到远程仓库，默认推送到origin/master, 也可自定义远程仓库及分支（如serverfix）
	
	$ git push
	$ git push https://github.com/juncaixinchi/blog-generater.git
	$ git push origin serverfix
	$ git push origin serverfix:awesomebranch

设置其他的跟踪分支 - 其他远程仓库上的跟踪分支，或者不跟踪 master 分支

	$ git checkout --track origin/serverfix

远程仓库的移除和重命名

	$ git remote rm paul
	$ git remote rename pb paul

删除远程分支serverfix

	$ git push origin --delete serverfix

### 打标签

列出已有标签

	$ git tag

创建一个附注标签，指定提交的校验和（或部分校验和）则可后期打标签

	$ git tag -a v1.4 -m 'my version 1.4'
	$ git tag -a v0.0 -m "origin version" c76e548

共享标签

	$ git push origin v1.5

### 设置别名

通过 config 为命令设置别名，外部程序的命令则要加!，使用cmu直接add 及 commit 

	$ git config --global alias.co checkout
	$ git config --global alias.br branch
	$ git config --global alias.st status
	$ git config --global alias.last 'log -1 HEAD'
	$ git config --global alias.hexo '!hexo g -delpoy'
	$ git config --global alias.cmu 'commit -a -m "update"'
	$ git config --global alias.logbr 'log --oneline --decorate --graph --all -20'

## Git 分支

### 分支的新建和合并

创建分支testing，分支切换为testing，然后commit内容将在test分支进行

	$ git branch testing
	$ git checkout testing

或者在过去某个版本，如593015f,建立分支testing

	$ git log --oneline --decorate --graph --all
	$ git checkout 593015f
	$ git checkout -b testing

使用 log 命令查看各个分支当前所指的对象。 提供这一功能的参数是 --decorate。

	$ git log --oneline --decorate
	$ git log --oneline --decorate --graph --all

使用 merge 来合并分支

	$ git merger testing

如果 master 和 testing 分支都各有提交新版本，则无法自动合并，会出现如下错误，需要手动编辑冲突的文件，然后再 commit，

	Auto Merge Failed; Fix Conflicts and Then Commit the Result

例如冲突的文件内容为：

	<<<<<<< HEAD:index.html
	<div id="footer">contact : email.support@github.com</div>
	=======
	<div id="footer">
	 please contact us at support@github.com
	</div>
	>>>>>>> testing:index.html

这表示 HEAD 所指示的版本（也就是你的 master 分支所在的位置）在这个区段的上半部分（======= 的上半部分），而 testing 分支所指示的版本在 ======= 的下半部分。 为了解决冲突，必须选择使用由 ======= 分割的两部分中的一个，或者也可以自行合并这些内容。 例如，通过把这段内容换成下面的样子来解决冲突：

	<div id="footer">
	please contact us at email.support@github.com
	</div>

另外也可以使用图形化工具来解决冲突

	$ git mergetool

合并完成后删除分支testing

	$ git branch -d testing

### 分支的管理

显示分支列表

	$ git branch

查看每一个分支的最后一次提交

	$ git branch -v

查看已经合并或尚未合并到当前分支的分支

	$ git branch --merged
	$ git branch --no-merged

删除和强制删除分支

	$ git branch -d testing
	$ git branch -D testing

### 分支整合之变基

使用 rebase 命令将提交到某一分支 testing 上的所有修改都移至另一分支 master 上，然后回到 master 分支，进行一次快进合并。

	$ git checkout testing
	$ git rebase master
	
	$ git checkout master
	$ git merge testing

直接将特性分支（testing）变基到目标分支（即 master）上

	$ git rebase master testing

对两个分支进行变基时，将 client 中的修改合并到主分支并发布，但暂时并不合并 server 中的修改
	
	$ git rebase --onto master server client

变基的风险：`不要对在仓库外有副本的分支执行变基`

## Git协议

### 本地协议

本地协议，其中的远程版本库就是硬盘内的另一个目录，一般使用硬链接（hard link）或直接复制所需要的文件，
	
	$ git clone /opt/git/project.git

增加一个本地版本库到现有的 Git 项目

	$ git remote add local_proj /opt/git/project.git

### HTTP 协议

Clone with HTTPS, Use Git or checkout with SVN using the web URL. 

	$ git clone https://example.com/gitproject.git
	$ git clone https://github.com/juncaixinchi/blog-generater.git

### SSH 协议

Clone with SSH, Use an SSH key and passphrase from account.
	
	$ git clone user@server:project.git
	$ git clone git@github.com:juncaixinchi/blog-generater.git
