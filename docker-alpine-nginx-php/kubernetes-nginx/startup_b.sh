#!/bin/sh
echo "linuxea-`hostname`.com ▍ $(ip a | awk '/inet/ {print $2}'|sha256sum|cut -c 4-16 ) ▍version number 2.0" >  /data/wwwroot/linuxea.html
echo linuxea-`hostname`.com-$(ip a | awk '/inet/ {print $2}') > /data/wwwroot/index.html 
chown -R www.www /data/wwwroot
supervisord  -n -c /etc/supervisord.conf
