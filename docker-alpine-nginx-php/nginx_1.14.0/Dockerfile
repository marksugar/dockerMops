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
		pcre-dev \
		linux-headers \
		geoip \
		geoip-dev\
		wget \
		gnupg \
		libxslt-dev \
		gd-dev \
### git clone nginx-module-vts and prometheus
&& git clone git://github.com/vozlt/nginx-module-vts.git "${VTSBAK}/nginx-module-vts" \
&& git clone git://github.com/vozlt/nginx-module-sts.git "${VTSBAK}/nginx-module-sts" \
&& git clone git://github.com/vozlt/nginx-module-stream-sts.git "${VTSBAK}/nginx-module-stream-sts" \
### git clone lua_module
&& curl -Lk https://github.com/simplresty/ngx_devel_kit/archive/v0.3.1rc1.tar.gz |tar xz -C  ${VTSBAK} \
&& curl -Lk https://github.com/openresty/lua-nginx-module/archive/v0.10.13.tar.gz |tar xz -C  ${VTSBAK} \
&& curl -Lk http://luajit.org/download/LuaJIT-2.0.5.tar.gz |tar xz -C  ${VTSBAK} \
&& cd ${VTSBAK}/LuaJIT-2.0.5 \
&& make && make install \
&& export LUAJIT_LIB=${VTSMODU}/lib \
&& export LUAJIT_INC=${VTSMODU}/include/luajit-2.0 \
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
--add-module=${VTSBAK}/lua-nginx-module-0.10.13 \
--add-module=${VTSBAK}/ngx_devel_kit-0.3.1rc1 \
--add-module=${VTSBAK}/nginx-module-vts \
--with-stream \
--add-module=${VTSBAK}/nginx-module-sts \
--add-module=${VTSBAK}/nginx-module-stream-sts \
&& make -j2 && make install \
&& ln -s /usr/local/lib/libluajit-5.1.so.2 /lib/ \
&& ln -s /usr/local/nginx/sbin/nginx /sbin/nginx \
&& mkdir -p /var/tmp/nginx/{client,fastcgi,proxy,uwsgi} ${NCONFG}/vhost ${NCONFG}/environment /tmp/ng/vhost /data/logs/\
&& apk add --no-cache --virtual .gettext gettext \
&& mv /usr/bin/envsubst  /tmp/ \
### add $runDev so and del apk pkg 
&& runDev="$( \
	scanelf --needed --nobanner /usr/local/nginx/sbin/nginx /tmp/envsubst \
		| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
		|sort -u \
		| xargs -r  apk info --installed \
		|sort -u \
)" \
&& runDev="${runDev} inotify-tools libgcc bash supervisor" \
&& apk add --no-cache --virtual .ngx-runDev ${runDev} \
&& apk del .gettext .build-deps \
# clean cache
&& rm -rf /var/cache/apk/* ${NCONFG}/nginx.conf ${VTSBAK}/* \
&& mv /tmp/envsubst /usr/local/bin/ \
# create listen and server_name or php host:port or startup scripts
&& echo -e "listen 80;\nserver_name localhost;" > ${NCONFG}/environment/ps.cf \
&& echo -e "listen \${NGINX_PORT};\nserver_name \${SERVER_NAME};" > ${NCONFG}/environment/.ps.env \
&& echo -e "fastcgi_pass 127.0.0.1:9001;" > ${NCONFG}/environment/phpport.cf \
&& echo -e "fastcgi_pass \${PHP_FPM_SERVER};" > ${NCONFG}/environment/.phpport.env \
&& curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-alpine-nginx-php/master/nginx_1.14.0/nginx.conf -o ${NCONFG}/nginx.conf \
&& curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-alpine-nginx-php/master/nginx_1.14.0/Prometheus_nginx_module_vts.conf -o /tmp/ng/vhost/Prometheus_nginx_module_vts.conf \
&& curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-alpine-nginx-php/master/nginx_1.14.0/template.conf -o /tmp/ng/vhost/template.conf \
&& cp -r /etc/nginx/* /tmp/ng \
# download config 
&& curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-alpine-nginx-php/master/nginx_1.14.0/supervisord.conf -o /etc/supervisord.conf \
#&& echo -e '#!/bin/bash\nmkdir /data/wwwroot /data/logs -p\ncp -r /tmp/ng/* /etc/nginx/ \ncd /etc/nginx/environment/ && envsubst < .ps.env > ps.cf \nenvsubst < .phpport.env > phpport.cf \nsupervisord  -n -c /etc/supervisord.conf' > /startup.sh \
&& curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-alpine-nginx-php/master/nginx_1.14.0/StartUP.sh -o  /startup.sh \
&& chmod +x /startup.sh
ENTRYPOINT ["/startup.sh"]
