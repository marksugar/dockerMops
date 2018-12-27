FROM alpine:3.8
MAINTAINER wwww.linuxea.com
ENV version=1.14.0
ENV USER=www
ENV VTSMODU=/usr/local
ENV NCONFG=/etc/nginx
ENV VTSBAK=/mnt
RUN addgroup -g 400 -S ${USER} \
&& adduser -HDu 400 -s /sbin/nologin -g 'web server' -G ${USER} ${USER} \
&& cd /usr/local && mkdir /data/nginx/logs -p\
&& apk add --no-cache curl \
&& apk update \
&& apk add --no-cache --virtual .build-deps \
		gcc \
		git \
		libc-dev \
		make \
		zlib-dev \
		openssl-dev \
&& apk add --no-cache --virtual .build-deps2 \
		pcre-dev \
		linux-headers \
		geoip \
		geoip-dev\
		wget \
		gnupg \
		libxslt-dev \
		gd-dev \
### download nginx and configure or make and add module
&& curl -Lk http://nginx.org/download/nginx-${version}.tar.gz |tar xz -C ${VTSBAK} \
&& cd ${VTSBAK}/nginx-${version} && ./configure \
--prefix=${VTSMODU}/nginx \
--conf-path=/etc/nginx/nginx.conf \
--user=${USER} \
--group=${USER} \
--error-log-path=/var/log/nginx/error.log \
--http-log-path=/var/log/nginx/access.log \
--pid-path=/var/run/nginx/nginx.pid \
--lock-path=/var/lock/nginx.lock \
--with-http_ssl_module \
--with-http_stub_status_module \
--with-http_gzip_static_module \
--with-http_flv_module \
--with-http_mp4_module \
--with-http_geoip_module \
--http-client-body-temp-path=/var/tmp/nginx/client \
--http-proxy-temp-path=/var/tmp/nginx/proxy \
--http-fastcgi-temp-path=/var/tmp/nginx/fastcgi \
--http-uwsgi-temp-path=/var/tmp/nginx/uwsgi \
--with-stream \
&& make -j2 && make install \
&& ln -s /usr/local/nginx/sbin/nginx /sbin/nginx \
&& mkdir -p /var/tmp/nginx/{client,fastcgi,proxy,uwsgi} ${NCONFG}/vhost /data/logs/ \
### add $runDev so and del apk pkg 
&& runDev="$( \
	scanelf --needed --nobanner /usr/local/nginx/sbin/nginx /tmp/envsubst \
		| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
		|sort -u \
		| xargs -r  apk info --installed \
		|sort -u \
)" \
&& runDevv="${runDev} inotify-tools supervisor" \
&& apk add --no-cache --virtual .ngx-runDev ${runDevv} \
&& apk del .build-deps .build-deps2 \
&& curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-alpine-nginx-php/master//nginx_1.14.0/supervisord.conf -o /etc/supervisord.conf \
&& echo -e "#!/bin/sh \nsupervisord  -n -c /etc/supervisord.conf" > /startup.sh \
&& cd / && rm -rf ${VTSBAK}   /var/cache/apk/* \
&& chmod +x /startup.sh
ENTRYPOINT ["/startup.sh"]
