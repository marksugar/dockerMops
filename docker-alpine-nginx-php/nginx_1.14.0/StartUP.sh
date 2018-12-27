#!/bin/sh
#########################################################################
# File Name: startup.sh
# Author: www.linuxea.com
# Created Time: 2018年08月12日 星期日 10时37分37秒
#########################################################################
 if [ `env|grep NGINXCONF=off|wc -l` -ne 0 ];then 
	echo -e "\033[43mYou are using a custom configuration I\033[0m"
	supervisord  -n -c /etc/supervisord.conf
 else 
	mkdir /data/wwwroot /data/logs -p
	cp -r /tmp/ng/* /etc/nginx/ 
	cd /etc/nginx/environment/ && envsubst < .ps.env > ps.cf 
	envsubst < .phpport.env > phpport.cf 
	supervisord  -n -c /etc/supervisord.conf	
fi
