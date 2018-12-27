#!/bin/sh
#########################################################################
# Created Time: 2017年06月22日 星期四 17时08分02秒
# www.linuxea.com 
########################################################################
dirconf="/etc/nginx"
dirmv="/tmp/ng"
echo -e "listen 81;\nserver_name www.linuxea.com;" > ${dirmv}/vhost/ps.conf
echo -e "fastcgi_pass 127.0.0.1:9001;" > ${dirmv}/vhost/phpport.conf
echo -e "listen \${NGINX_PORT};\nserver_name \${SERVER_NAME};" > ${dirmv}/nginx.env
echo -e "fastcgi_pass \${PHP_FPM_SERVER};" > ${dirmv}/phpport.env
curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-alpine-nginx-php/master/nginx-1.12.0/nginx.conf -o ${dirmv}/nginx.conf
if [ "$(ls -A $dirconf)" ]; then
	envsubst < ${dirconf}/nginx.env > /etc/nginx/vhost/ps.conf && \
	envsubst < ${dirconf}/phpport.env > /etc/nginx/vhost/phpport.conf && chown -R www.www  /data/ && /usr/local/nginx/sbin/nginx
else
	mv /tmp/ng/* ${dirconf} &&\
	envsubst < ${dirconf}/nginx.env > /etc/nginx/vhost/ps.conf && \
	envsubst < ${dirconf}/phpport.env > /etc/nginx/vhost/phpport.conf && \
	chown -R www.www  /data/ && /usr/local/nginx/sbin/nginx
fi
