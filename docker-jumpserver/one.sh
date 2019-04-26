#!/bin/bash
#########################################################################
# File Name: one.sh
# Author: www.linuxea.com
# Created Time: 2019年04月25日 星期四 15时25分34秒
#########################################################################

mkdir /data/ -p
curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-jumpserver/docker-compose.yml -o /data/docker-compose.yml
curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-jumpserver/check_SECRET-TOKEN.sh |bash
docker-compose -f /data/docker-compose.yml up -d
