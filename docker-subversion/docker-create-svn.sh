#!/bin/bash
#########################################################################
# File Name: svn.sh
# Author: LookBack
# Email: admin#dwhd.org
# Version:
# Created Time: 2016年12月26日 星期一 17时14分24秒
#########################################################################
PATH1=/data/docker/subversion
mkdir -p $PATH1
curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-subversion1.9.4/master/docker-compose.yaml -o /data/docker/docker-compose.yaml
/usr/local/bin/docker-compose -f /data/docker/docker-compose.yaml up -d
