#!/bin/bash
#########################################################################
# File Name: install_redis.sh
# Author: www.linuxea.com and mark
# Email: usertzc#163.com
# Version:
# Created Time: 2017年09月08日 星期五 17时05分37秒
#########################################################################
mkdir /data/rds /data/logs /data/redis -p
if [ -f  /data/rds/docker-compose.yaml ]; then
	docker-compose -f /data/rds/docker-compose.yaml up -d
else
   cd /data/rds && curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-alpine-Redis/master/Sentinel/docker-compose.yaml -o /data/rds/docker-compose.yaml \
   && docker-compose -f /data/rds/docker-compose.yaml up -d
fi
