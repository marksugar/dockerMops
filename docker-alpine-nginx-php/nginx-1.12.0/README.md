 <table><tr><td bgcolor=#DC143C> Note: </td></tr></table> The configuration file is not loaded dynamically (not nginx auto reload)

## Simple compilation:
- --prefix=/usr/local/nginx \
- --conf-path=/etc/nginx/nginx.conf \
- --user=${USER} \
- --group=${USER} \
- --error-log-path=/var/log/nginx/error.log \
- --http-log-path=/var/log/nginx/access.log \
- --pid-path=/var/run/nginx/nginx.pid \
- --lock-path=/var/lock/nginx.lock \
- --with-http_ssl_module \
- --with-http_stub_status_module \
- --with-http_gzip_static_module \
- --with-http_flv_module \
- --with-http_mp4_module \
- --http-client-body-temp-path=/var/tmp/nginx/client \
- --http-proxy-temp-path=/var/tmp/nginx/proxy \
- --http-fastcgi-temp-path=/var/tmp/nginx/fastcgi \
- --http-uwsgi-temp-path=/var/tmp/nginx/uwsgi \
## Can be dynamically modified part of the configuration file:
- NGINX_PORT=80
- SERVER_NAME=www.linuxea.com
- PHP_FPM_SERVER=127.0.0.1:9000

## install nginx 1.12.0
curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-alpine-nginx-php/master/nginx-1.12.0/add-nginx.sh|bash

## www
create /data/wwwroot and wwwlogs /data/logs .nginx config Mapping local
