#!/bin/bash

set -e  # exit on error
dockerUser=1742716458
dockerToken=0
businessName=langchain
# 本地运行的是最新的，可能包括未提交的
# if [ -n "$(git status --porcelain)" ]; then
#   echo "文件被修改，请先清空变化";
#   exit 1;
# else
#   echo "no changes";
# fi


dtimeStamp=`git show -s --format=%at`
if [[ `uname` == 'Darwin' ]]; then
  echo "Mac OS"
  d=`date -r${dtimeStamp} "+%Y-%m-%d"`
fi

if [[ `uname` == 'Linux' ]]; then
  d=`date -d @${dtimeStamp} "+%Y-%m-%d"`
  echo "Linux"
fi
branch=`git rev-parse --abbrev-ref HEAD`
hash=`git rev-parse --short HEAD`
imgName=${dockerUser}/${businessName}:${branch}_${d}_${hash}
echo "镜像名为: $imgName"

set +e
docker pull $imgName
if [ $? -ne 0 ]; then
  #docker login -u $dockerUser -p $dockerToken
  # 生成镜像
  docker build -t $imgName .
  # 上传docker hub 仓库
  docker push $imgName
fi
set -e

# 清理旧的容器服务
set +e # 下面这行失败是可以接受的
#docker rm -f ${businessName}
docker service rm ${businessName}
docker config rm ${businessName}_config
docker network create -d overlay mynet
set -e

# 运行容器
echo "如果你想手动查找问题，可以试试以下命令来运行容器"
echo "docker run -it --rm --name ${businessName} -v env:/home/env -p 8088:3000  $imgName /bin/sh "
docker config create ${businessName}_config ~/.dev.yaml

source_dir=`pwd`
#--mount type=bind,source=/home/linux1/,target=/home \
docker service create --name ${businessName} \
            --replicas 1 \
            --config source=${businessName}_config,target=/home/.dev.yaml \
            --network mynet \
            --mount type=bind,source=${source_dir},target=/home \
            -p 8888:8888 \
            $imgName
