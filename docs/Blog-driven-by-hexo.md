

### 在项目的根目录添加子模块
因为添加主题next，在上传GitHub Pages的时候遇到了以下问题：

	Page build failed: Missing submodule

发现是submodule没有配置好，删除原来的 themes/next/ 文件使用以下代码重新配置

	git submodule add git@github.com:juncaixinchi/hexo-theme-next.git themes/next