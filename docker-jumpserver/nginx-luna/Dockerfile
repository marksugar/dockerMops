FROM alpine:3.9
MAINTAINER wwww.linuxea.com

ENV LANG=zh_CN.UTF-8 \
    LANGUAGE=zh_CN.UTF-8

ARG LUNAV="1.4.9"
ENV LUNAV=${LUNAV}

ARG version="1.12.0"
ENV version=${version}
ENV USER=www

COPY locale.md /locale.md
COPY entrypoint.sh /bin/entrypoint.sh
COPY jumpserver.conf /etc/nginx/vhost/jumpserver.conf

RUN apk --no-cache add ca-certificates wget && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-2.25-r0.apk && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-bin-2.25-r0.apk && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-i18n-2.25-r0.apk && \
    apk add glibc-bin-2.25-r0.apk glibc-i18n-2.25-r0.apk glibc-2.25-r0.apk && \
    cat /locale.md | xargs -i /usr/glibc-compat/bin/localedef -i {} -f UTF-8 {}.UTF-8 \
&& addgroup -g 400 -S ${USER} \
&& adduser -HDu 400 -s /sbin/nologin -g 'web server' -G ${USER} ${USER} \
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
		geoip \
		geoip-dev\
		gnupg \
&& curl -Lk http://nginx.org/download/nginx-${version}.tar.gz |tar xz -C /usr/local/ \
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
--with-file-aio \
--with-stream \
--with-http_mp4_module \
--http-client-body-temp-path=/var/tmp/nginx/client \
--http-proxy-temp-path=/var/tmp/nginx/proxy \
--http-fastcgi-temp-path=/var/tmp/nginx/fastcgi \
--http-uwsgi-temp-path=/var/tmp/nginx/uwsgi \
&& make && make install \
&& ln -s /usr/local/nginx/sbin/nginx /bin/nginx \
&& mkdir -p /var/tmp/nginx/{client,fastcgi,proxy,uwsgi} /etc/nginx/vhost /data/logs \
&& rm -rf /var/cache/apk/* /usr/local/nginx-${version}.tar.gz /etc/nginx/nginx.conf \
&& curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-nginx/supervisord/supervisord.conf -o /etc/supervisord.conf \
&& curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-nginx/nginx.conf -o /etc/nginx/nginx.conf \
&& curl -Lk https://github.com/jumpserver/luna/releases/download/${LUNAV}/luna.tar.gz|tar xz -C /opt \
&& chown -R root:root /opt/luna \
&& chmod +x /bin/entrypoint.sh \
&& runDev="$( \
	scanelf --needed --nobanner /usr/local/nginx/sbin/nginx \
		| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
		|sort -u \
		| xargs -r  apk info --installed \
		|sort -u \
)" \
&& apk add --no-cache --virtual .ngx-runDev ${runDev} inotify-tools supervisor \
&& apk del  .build-deps
WORKDIR /opt/luna
#ENTRYPOINT ["supervisord","-n","-c","/etc/supervisord.conf"]
CMD ["entrypoint.sh"]
