FROM marksugar/alpine
MAINTAINER wwww.linuxea.com
RUN addgroup -g 499 -S nginx \
&& adduser -HDu 499 -s /sbin/nologin -g 'web server' -G nginx nginx \
&& cd /usr/local && mkdir /data/nginx/logs -p\
&& curl -sO http://nginx.org/download/nginx-1.10.1.tar.gz \
&& tar xf nginx-1.10.1.tar.gz \
&& rm -rf nginx-1.10.1.tar.gz \
&& apk --update --no-cache add geoip geoip-dev pcre libxslt gd openssl-dev \
pcre-dev zlib-dev build-base linux-headers libxslt-dev gd-dev openssl-dev \
libstdc++ libgcc patch logrotate supervisor inotify-tools && cd /usr/local/nginx-1.10.1 && ./configure \
--prefix=/usr/local/nginx \
--conf-path=/etc/nginx/nginx.conf \
--user=nginx \
--group=nginx \
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
&&  mkdir -p /var/tmp/nginx/{client,fastcgi,proxy,uwsgi} \
&& echo "daemon off;" >> /etc/nginx/nginx.conf \
&& apk del wget \
&& rm -rf /usr/local/nginx-1.10.1 \
&& rm -rf /var/cache/apk/* /etc/nginx/nginx.conf
#&& curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/nmp/master/nginx.conf -o /etc/nginx/nginx.conf
ENV PATH /usr/local/nginx/sbin:$PATH
EXPOSE 80
ENTRYPOINT /usr/local/nginx/sbin/nginx
