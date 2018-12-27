FROM alpine:3.8
MAINTAINER wwww.linuxea.com
ENV version=1.12.0
ENV USER=www
RUN addgroup -g 400 -S ${USER} \
&& adduser -HDu 400 -s /sbin/nologin -g 'web server' -G ${USER} ${USER} \
&& cd /usr/local && mkdir /data/nginx/logs -p\
&& apk add --no-cache curl \
&& apk add --no-cache --virtual .build-deps \
		gcc \
		libc-dev \
		make \
		openssl-dev \
		pcre-dev \
		zlib-dev \
		linux-headers \
		wget \
		gnupg \
		libxslt-dev \
		gd-dev \
&& curl -sO http://nginx.org/download/nginx-${version}.tar.gz \
&& tar xf nginx-${version}.tar.gz \
&& cd /usr/local/nginx-${version} && ./configure \
--prefix=/usr/local/nginx \
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
--http-client-body-temp-path=/var/tmp/nginx/client \
--http-proxy-temp-path=/var/tmp/nginx/proxy \
--http-fastcgi-temp-path=/var/tmp/nginx/fastcgi \
--http-uwsgi-temp-path=/var/tmp/nginx/uwsgi \
&& make && make install \
&& mkdir -p /var/tmp/nginx/{client,fastcgi,proxy,uwsgi} /etc/nginx/vhost /tmp/ng \
&& rm -rf /var/cache/apk/* /usr/local/nginx-${version}.tar.gz /etc/nginx/nginx.conf \
&& mv /etc/nginx/* /tmp/ng \
&& apk add --no-cache --virtual .gettext gettext \
&& mv /usr/bin/envsubst  /tmp/ \
&& runDev="$( \
	scanelf --needed --nobanner /usr/local/nginx/sbin/nginx /tmp/envsubst \
		| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
		|sort -u \
		| xargs -r  apk info --installed \
		|sort -u \
)" \
&& apk add --no-cache --virtual .ngx-runDev ${runDev} \
&& apk del .gettext .build-deps \
&& mv /tmp/envsubst /usr/local/bin/ \
&& curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-alpine-nginx-php/master/nginx-1.12.0/start.sh -o /start.sh \
&& chmod +x /start.sh
ENTRYPOINT ["/start.sh"]
