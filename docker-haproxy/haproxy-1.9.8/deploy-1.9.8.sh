#!/bin/bash
#########################################################################
# File Name: deploy-1.9.8.sh
# Author: www.linuxea.com
# Created Time: 2019年06月03日 星期一 17时09分10秒
#########################################################################

mkdir /etc/haproxy -p
curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-haproxy/haproxy-1.9.8/docker-compose.yml -o $PWD/docker-compose.yml
curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-haproxy/haproxy-1.9.8/haproxy.cfg -o /etc/haproxy/haproxy.cfg
docker-compose -f $PWD/docker-compose.yml up -d
