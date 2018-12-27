#!/bin/bash
#########################################################################
# File Name: 1.sh
# Author: www.linuxea.com
# Email: usertzc@gmail.com
# Version:  
# Created Time: 2016年12月19日 星期一 15时17分30秒
#########################################################################\
    [ -f /data/docker/tomcat/webapps/host-manager ] || mv /opt/app/* /data/docker/tomcat/webapps/
    [ -f /data/docker/tomcat/conf/server.xml ] ||  mv /opt/config/* /data/docker/tomcat/conf/
if [ `ls /data/docker/tomcat/|grep *.jar` ];then
    tail -f /etc/issue
    cd /data/docker/ && nohup java -jar *.jar --logging.file=./logback.xml > /dev/null 2>&1 &
else
    /data/docker/tomcat/bin/startup.sh start
    tail -f /etc/issue
fi
