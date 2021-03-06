#!/bin/bash
WORK_PATH='/usr/projects/vue-font'
cd $WORK_PATH
echo "先清除老代码"
git reset --hard origin/master
git clean -f
echo "拉取最新代码"
git pull origin master
echo "编译"
npm run build
echo "开始执行构建"
docker build -t vue-font:1.0 .
echo "停止旧容器并删除旧容器"
docker stop vue-font-container
docker rm vue-font-container
echo "启动新容器"
docker container run -p 80:80 --name vue-font-container -d vue-font:1.0