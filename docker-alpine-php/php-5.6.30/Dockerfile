FROM alpine:3.6
MAINTAINER mark www.linuxea.com
ENV PHP_VSN=5.6.30
ENV ICONV_VSN=1.15
ENV LNP=www
ENV PHPINI=/usr/local/php
RUN set -x && \
	PHPAPK="coreutils sqlite-dev gnupg openssl dpkg-dev dpkg libc-dev pcre-dev pkgconf ca-certificates curl xz curl-dev libtool libedit-dev libxml2-dev openssl-dev libaio-dev libjpeg-turbo-dev libpng-dev libmcrypt-dev icu-dev freetype-dev gettext-dev libxslt-dev zlib-dev imap-dev autoconf g++ gcc m4 pkgconf gettext xz libmemcached-dev cyrus-sasl-dev libsasl linux-headers grep tar re2c file libxpm-dev libwebp-dev make" \
	&& apk --update --no-cache add --virtual .build-deFPM ${PHPAPK} \
	&& curl -Lk http://ftp.gnu.org/pub/gnu/libiconv/libiconv-${ICONV_VSN}.tar.gz -o /usr/local/libiconv-${ICONV_VSN}.tar.gz \
	&& rm /usr/bin/iconv && cd /usr/local/ \
	&& tar xf libiconv-${ICONV_VSN}.tar.gz && ln -s libiconv-${ICONV_VSN} libiconv && cd libiconv-${ICONV_VSN} \
	&& ./configure --prefix=/usr/local && make && make install \
  	&& curl -Lks4 http://am1.php.net/distributions/php-${PHP_VSN}.tar.gz -o /php-${PHP_VSN}.tar.gz && cd / \
	&& addgroup -g 400 -S ${LNP} && adduser -u 400 -S -H -s /sbin/nologin -g 'PHP' -G ${LNP} ${LNP} \
	&& tar xf php-${PHP_VSN}.tar.gz && cd php-${PHP_VSN} && export LD_PRELOAD=/usr/local/lib/preloadable_libiconv.so &&\
		./configure --prefix=/usr/local/php \
--with-config-file-path=/usr/local/php/etc \
--with-config-file-scan-dir=/usr/local/php/etc/php.d \
--enable-opcache \
--enable-fpm \
--with-fpm-user=${LNP} \
--with-fpm-group=${LNP} \
--enable-opcache \
--disable-fileinfo \
--with-mysql=mysqlnd \
--with-mysqli=mysqlnd \
--with-pdo-mysql=mysqlnd \
--with-iconv=/usr/local \
--with-freetype-dir \
--with-jpeg-dir \
--with-png-dir \
--with-zlib \
--with-zlib-dir \
--with-libxml-dir=/usr \
--enable-xml \
--disable-rpath \
--enable-bcmath \
--enable-shmop \
--enable-exif \
--enable-sysvsem \
--enable-inline-optimization \
--with-curl \
--enable-mbregex \
--enable-mbstring \
--with-mcrypt \
--with-gd \
--enable-gd-native-ttf \
--enable-gd-jis-conv \
--with-openssl \
--with-mhash \
--enable-pcntl \
--enable-sockets \
--with-xmlrpc \
--enable-ftp \
--enable-intl \
--with-xsl \
--with-gettext \
--enable-zip \
--enable-soap \
--disable-ipv6 \
--disable-debug \
--with-layout=GNU \
--with-pic \
--enable-cli \
--with-xpm-dir \
--enable-shared \
--with-imap && make && make install \
#COPY php.ini
&& [ -f ${PHPINI}/etc/ ] || mkdir ${PHPINI}/etc/ -p \
&& egrep -v "^($|;)" /php-${PHP_VSN}/php.ini-production > ${PHPINI}/etc/php.ini \
&& [ -f ${PHPINI}/etc/php.ini ] || /bin/cp -r /php-${PHP_VSN}/php.ini-production ${PHPINI}/etc/ \
&& sed -i "s/memory_limit = 128M/;memory_limit = 128M/g" ${PHPINI}/etc/php.ini \
&& echo "extension_dir = /usr/local/php/lib/php/20131226" >> ${PHPINI}/etc/php.ini \
&& sed -i "s/date.timezone = .*$/date.timezone = Asia\/Shanghai/g" ${PHPINI}/etc/php.ini \
&& sed -i "s/expose_php = On/expose_php = off/g" ${PHPINI}/etc/php.ini \
&& apk add --no-cache libmemcached-dev \
#&& mv /usr/lib/php5/modules/memcache.so /usr/local/php/lib/php/20131226/memcache.so \
#install memcached,redis,swoole,xdebug
&& /usr/local/php/bin/pecl install https://pecl.php.net/get/memcached-2.2.0.tgz\
&& /usr/local/php/bin/pecl install https://pecl.php.net/get/redis-2.2.8.tgz \
&& /usr/local/php/bin/pecl install https://pecl.php.net/get/swoole-1.8.9.tgz \
&& /usr/local/php/bin/pecl install https://pecl.php.net/get/xdebug-2.5.0.tgz \
#&& echo "extension=iconv.so" > /usr/local/php/etc/php.d/iconv.ini \
#&& echo -e "extension=swoole.so\nswoole.use_namespace=On" > /usr/local/etc/php/php.d/swoole.ini \
#&& echo "extension=redis.so" > /usr/local/etc/php/php.d/phpredis.ini \
#&& echo "zend_extension=xdebug.so" > /usr/local/etc/php/php.d/xdebug.ini \
&& apk add --no-cache --virtual .gettext gettext \
&& mv /usr/bin/envsubst  /tmp/ \
&& runDev="$( \
	scanelf --needed --nobanner /usr/local/php/sbin/php-fpm /tmp/envsubst \
		| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
		|sort -u \
		| xargs -r  apk info --installed \
		|sort -u \
)" \
&& curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-alpine-php/master/php-5.6.30/start.sh -o /start.sh \
&& apk add --no-cache --virtual .php-runDev ${runDev} \
&& apk del .build-deFPM && mv /tmp/envsubst /usr/local/bin/ \
&& rm -rf /var/cache/apk/* /tmp/* /var/lib/apt/lists/* /var/tmp/* /usr/share/doc/* /php-${PHP_VSN}* /usr/local/libiconv-${ICONV_VSN}* \
&& mkdir /data/wwwroot /data/logs -p \
&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo "Asia/Shanghai" > /etc/timezone \
&& chmod +x /start.sh
ENTRYPOINT ["/start.sh"]
