# sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories alibaba 
FROM alpine:3.14.3
# make: uname: Operation not permitted
# make: /bin/sh: Operation not permitted
# make: *** [Makefile:109: default] Error 127
# alpine:3.14.3 需要 3.13 或者 docker 20.10以上
MAINTAINER wwww.linuxea.com
# docker build --build-arg version="1.22.1" -t marksugar/nginx:1.22.1-vts .
# registry.cn-zhangjiakou.aliyuncs.com/marksugar/nginx:1.22.1-vts
COPY nginx-module-vts /usr/src/nginx-module-vts
# --add-module=/usr/src/nginx-module-vts
ARG version="1.12.0"
ENV version=${version}
ENV USER=www
RUN addgroup -g 400 -S ${USER} \
&& adduser -HDu 400 -s /sbin/nologin -g 'web server' -G ${USER} ${USER} \
&& sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
&& apk add --no-cache curl \
&& CONFIGURE="\
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
	--with-file-aio \
	--with-stream \
	--with-http_mp4_module \
	--http-client-body-temp-path=/var/tmp/nginx/client \
	--http-proxy-temp-path=/var/tmp/nginx/proxy \
	--http-fastcgi-temp-path=/var/tmp/nginx/fastcgi \
	--http-uwsgi-temp-path=/var/tmp/nginx/uwsgi \
	--add-module=/usr/src/nginx-module-vts \
" \
&& apk add --no-cache --virtual .build-deps \
		gcc \
		libc-dev \
		make \
		openssl-dev \
		pcre-dev \
		perl-dev \
		zlib-dev \
		linux-headers \
		wget \
		gnupg \
		libxslt-dev \
		gd-dev \
		geoip \
		geoip-dev\
		gnupg \
&& curl -Lk http://nginx.org/download/nginx-${version}.tar.gz |tar xz -C /usr/local/ \
&& cd /usr/local/nginx-${version}  \
&& ./configure $CONFIGURE --with-debug \
&& make -j$(getconf _NPROCESSORS_ONLN) \
&& make install \
&& ln -s /usr/local/nginx/sbin/nginx /bin/nginx \
&& mkdir -p /var/tmp/nginx/{client,fastcgi,proxy,uwsgi} /etc/nginx/vhost /data/logs \
&& rm -rf /var/cache/apk/* /usr/local/nginx-${version}.tar.gz /etc/nginx/nginx.conf \
# && curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-nginx/supervisord/supervisord.conf -o /etc/supervisord.conf \
# && curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-nginx/nginx.conf -o /etc/nginx/nginx.conf \
&& runDev="$( \
	scanelf --needed --nobanner /usr/local/nginx/sbin/nginx \
		| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
		|sort -u \
		| xargs -r  apk info --installed \
		|sort -u \
)" \
&& apk add --no-cache --virtual .ngx-runDev ${runDev} inotify-tools supervisor \
&& apk del  .build-deps
copy supervisord.conf /etc/supervisord.conf
copy nginx.conf /etc/nginx/nginx.conf
ENTRYPOINT ["supervisord","-n","-c","/etc/supervisord.conf"]