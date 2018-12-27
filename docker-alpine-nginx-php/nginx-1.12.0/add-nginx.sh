#!/bin/bash
#########################################################################
# File Name: add-nginx.sh
# Author: www.linuxea.com
# Created Time: 2017年06月29日 星期四 19时23分12秒
#########################################################################
WWPATH="/data/wwwroot"
WWLOGS="/data/logs"
WWDOCK="/data/nginx"
mkdir -p ${WWPATH} ${WWLOGS}
mkdir -p ${WWDOCK}
curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-alpine-nginx-php/master/nginx-1.12.0/docker-compose-nginx.yaml -o ${WWDOCK}/docker-compose-nginx.yaml
docker-compose -f ${WWDOCK}/docker-compose-nginx.yaml up --build -d
