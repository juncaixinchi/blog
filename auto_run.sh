#! /bin/bash
hexo clean
hexo g
cp source/404.html public/404.html
cp source/404/page.js public/404/page.js
echo "File Copied !"
hexo d
