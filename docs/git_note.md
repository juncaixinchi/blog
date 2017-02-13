Git note
===

完整文档见[Git-scm](https://git-scm.com/book/zh/v2)

##	Git 配置

1. 获取升级

		$ git clone git://git.kernel.org/pub/scm/git/git.git

2. 添加用户信息
	
		$ git config --global user.name "lixinwei"
		$ git config --global user.email lixinwei2017@foxmail.com

3. 获取帮助

		$ git help <verb>
		$ git <verb> --help
		$ man git-<verb>

## Git 基础

1. 在现有目录中初始化仓库
	
		$ git init

	该命令将创建一个名为 .git 的子目录，这个子目录含有你初始化的 Git 仓库中所有的必须文件，这些文件是 Git 仓库的骨干。 但是，在这个时候，我们仅仅是做了一个初始化的操作，你的项目里的文件还没有被跟踪。

		$ git add *
		$ git commit -m 'initial project version'

	在一个已经存在文件的文件夹（而不是空文件夹）中初始化 Git 仓库来进行版本控制的话，应该开始跟踪这些文件并提交。 

2. 克隆现有的仓库（repository）
	
		$ git clone https://github.com/juncaixinchi/blog-generater.git

	克隆blog-generater至当前目录

3. 记录每次更新到仓库
	
		$ git add README

	使用命令 git add 开始跟踪跟踪 README 文件

		$ git status

		$ git status -s

	检查当前文件状态，加-s为简略信息

4. 忽略文件

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

5. 提交更新
	
	commit命令会提交更新，-m参数可添加提交备注

		$ git commit -m "update"

	给 git commit 加上 -a 选项，Git 就会自动把所有已经跟踪过的文件暂存起来一并提交，从而跳过 git add 步骤

		$ git commit -a -m 'update without git add'

6. 移除文件

	使用git rm 命令将文件从已跟踪文件清单中移除，并连带从工作目录中删除指定的文件， 如果删除之前修改过并且已经放到暂存区域的话，则必须要用强制删除选项 -f（译注：即 force 的首字母）。 这是一种安全特性，用于防止误删还没有添加到快照的数据，这样的数据不能被 Git 恢复。

		git rm file_to_remove.md

7. 移动文件

		$ git mv file_from file_to

8. 查看提交历史
	
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

9. 撤消操作
		
	尝试重新提交,第二次提交将代替第一次提交的结果
	
		$ git commit -m 'initial commit'
		$ git add forgotten_file
		$ git commit --amend

	取消暂存的文件file_to_cancle.txt(git add 的相反操作)

		$ git reset HEAD file_to_cancle.txt

	