#!/bin/sh
#########################################################################
# File Name: start.sh
# Created Time: 2017年08月02日 星期三 15时48分50秒
#########################################################################

dirconf="/etc/nginx"
dirmv="/tmp/ng"
mkdir /etc/nginx/vhost -p
echo -e "listen 81;\nserver_name www.linuxea.com;" > ${dirconf}/vhost/ps.conf
echo -e "fastcgi_pass 127.0.0.1:9000;" > ${dirconf}/vhost/phpport.conf
#echo -e "listen \${NGINX_PORT};\nserver_name \${SERVER_NAME};" > ${dirmv}/nginx.env
#echo -e "fastcgi_pass \${PHP_FPM_SERVER};" > ${dirmv}/phpport.env
curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-alpine-nginx-php/master/nginx-1.12.0/nginx.conf -o ${dirconf}/nginx.conf
#if [ "$(ls -A $dirconf)" ]; then
#	envsubst < ${dirconf}/nginx.env > /etc/nginx/vhost/ps.conf && \
#	envsubst < ${dirconf}/phpport.env > /etc/nginx/vhost/phpport.conf &&
	 /usr/local/nginx/sbin/nginx
#else
#	mv /tmp/ng/* ${dirconf} &&
#	envsubst < ${dirconf}/nginx.env > /etc/nginx/vhost/ps.conf && \
#	envsubst < ${dirconf}/phpport.env > /etc/nginx/vhost/phpport.conf && \	
#	/usr/local/nginx/sbin/nginx
#fi
