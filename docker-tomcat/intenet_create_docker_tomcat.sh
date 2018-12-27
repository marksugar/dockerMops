#!/bin/bash
#########################################################################
# File Name: intenet_create_docker_tomcat.sh
# Author: mark www.linuxea.com
# Email: usertzc@gmail
# Version:
# Created Time: 2016年12月19日 
#########################################################################
tpp=/data/docker/tomcat
mkdir -p $tpp/{conf,webapps}
curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-tomcat/master/8.5.9/docker-compose.yaml -o $tpp/docker-compose.yaml
/usr/local/bin/docker-compose -f $tpp/docker-compose.yaml up -d
