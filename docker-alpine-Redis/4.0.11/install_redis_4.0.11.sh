#!/bin/bash
#########################################################################
# File Name: install_redis_4.0.11.sh
# Author: www.linuxea.com
# Created Time: 2018年08月11日 星期六 21时46分20秒
#########################################################################
curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-alpine-Redis/master/4.0.11/docker-compose-redis-4-0-11.yml -o $PWD/docker-compose-redis-4-0-11.yml
docker-compose -f $PWD/docker-compose-redis-4-0-11.yml up -d
