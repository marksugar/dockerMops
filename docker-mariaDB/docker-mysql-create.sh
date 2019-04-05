#!/bin/bash
#########################################################################
# File Name: docker-mysql-create.sh
# Author: mark for www.linuxea.com
# Email: usertzc@gmail.com
# Version:
# Created Time: 2016年12月
#########################################################################
jpdir=/data/docker/mysql/
mkdir $jpdir/data /data/logs/mysql -p
#curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/Docker-MariaDB/master/initialization.sh -o ${jpdir}initialization.sh
#curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/Docker-MariaDB/master/initialization.sql -o ${jpdir}initialization.sql
curl -Lks4 https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-mariaDB/my.cnf -o ${jpdir}my.cnf
#/usr/bin/docker
curl -Lks4 https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-mariaDB/docker-compose.yaml -o ${jpdir}docker-compose.yaml
#/usr/local/bin/docker-compose -f /jumpserver/docker-compose.yaml up -d
cd $jpdir && /usr/local/bin/docker-compose up -d
