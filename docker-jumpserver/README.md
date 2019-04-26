## jumpserver-deploy

这是[jumpserver](https://github.com/jumpserver/jumpserver)基于docker的第三方提供的部署方式，部署镜像参考[jumpserver官网文档](http://docs.jumpserver.org/zh/docs/setup_by_ubuntu.html)打包而成，与官方部署方式一样，与[jumpserver](https://github.com/jumpserver/jumpserver)官网的docker方式略带不一样。

分离为4个主要镜像分别为：

- [marksugar/jump:nginx-luna-1.4.9-1.15.12-zh](https://hub.docker.com/r/marksugar/jump/tags)
- [marksugar/jump:guacamole-0.9.14-zh](https://hub.docker.com/r/marksugar/jump/tags)
- [marksugar/jump:coco-1.4.9-zh](https://hub.docker.com/r/marksugar/jump/tags)，
- [marksugar/jump:jms-1.4.9-zh](https://hub.docker.com/r/marksugar/jump/tags),附带[mariadb](https://github.com/marksugar/dockerMops/tree/master/docker-mariaDB/10.2.22)与[redis](https://github.com/marksugar/dockerMops/tree/master/docker-alpine-Redis/5.0)

这些镜像都是由[docker-compsoe](https://docs.docker.com/compose/install/)编排

在正式开始之前，你需要安装最新的docker和docker-compose编排工具。安装或者升级参考官方的[docker-ce](https://docs.docker.com/install/linux/docker-ce/centos/)*和*[docker-compose](https://docs.docker.com/compose/install/)


# 快速开始
- 当前版本1.4.9

curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-jumpserver/one.sh|bash

# 逐步开始
> docker-compose.yml download
```
mkdir /data/ -p
curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-jumpserver/docker-compose.yml -o /data/docker-compose.yml
```
> 生成随机SECRET_KEY 和 生成随机BOOTSTRAP_TOKEN

curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-jumpserver/check_SECRET-TOKEN.sh |bash 

内容如下：
```
COMPOSEFILE='/data/docker-compose.yml'
SECRET_KEY=`cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 50`
BOOTSTRAP_TOKEN=`cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 16`
sed -i "s/BOOTSTRAP_TOKEN=.*/BOOTSTRAP_TOKEN=${BOOTSTRAP_TOKEN}/g" $COMPOSEFILE
sed -i "s/SECRET_KEY=.*/SECRET_KEY=${SECRET_KEY}/g" $COMPOSEFILE

TOKENV=`awk -F= '/BOOTSTRAP_TOKEN/{print $2}' $COMPOSEFILE`
SECRETV=`awk -F= '/SECRET_KEY/{print $2}' $COMPOSEFILE`
if [ "$BOOTSTRAP_TOKEN" == "${TOKENV}" ];then echo "[i] BOOTSTRAP_TOKEN Consistent configuration.";else echo "Please check the BOOTSTRAP_TOKEN value";fi
if [ "$SECRET_KEY" == "${SECRETV}" ];then echo "[i] SECRET_KEY Consistent configuration.";else echo "Please check the SECRET_KEY value";fi
```

> docker-compose up

docker-compose -f /data/docker-compose.yml up -d 



- [docker加速](https://www.docker-cn.com/registry-mirror)