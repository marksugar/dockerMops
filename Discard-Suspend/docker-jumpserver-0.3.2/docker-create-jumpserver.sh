#!/bin/bash
#########################################################################
# File Name: docker-create-jumpserver.sh
# Author: mark for www.linuxea.com
# Email: usertzc@gmail.com
# Version:
# Created Time: 2016年12月
#########################################################################
jmdir=/data/jumpserver
mkdir $jmdir
curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-jumpserver-0.3.2/master/jumpserver.conf -o ${jmdir}/jumpserver.conf          
curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-jumpserver-0.3.2/master/docker-compose.yaml -o ${jmdir}/docker-compose.yaml
cd $jmdir && /usr/local/bin/docker-compose up -d
iptables -I INPUT 5 -p tcp  -m state --state NEW -m tcp -m multiport --dports 8888 -m comment --comment "jumpserver" -j ACCEPT
