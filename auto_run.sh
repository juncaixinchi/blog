#! /bin/bash
hexo clean
hexo g
cp source/404.html public/404.html
echo "File Copied !"
hexo d
