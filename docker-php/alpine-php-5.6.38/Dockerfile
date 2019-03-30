FROM alpine:3.8
MAINTAINER mark
ENV PHPVERSION 5.6.38
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php
RUN apk update \
	&& apk add --no-cache --virtual .build-deps \
		argon2-dev \
		coreutils \
		curl-dev \
		libressl-dev \
		libsodium-dev \
		libxml2-dev \
		libedit-dev \
		sqlite-dev \
		libxpm-dev \
		libaio-dev \
		libjpeg-turbo-dev \
		libpng-dev \
		libmcrypt-dev \
		icu-dev \
		autoconf \
		dpkg-dev \
		dpkg \
		file \
		g++ \
		gcc \
		libc-dev \
		freetype-dev \
		gettext-dev \
		libxslt-dev \
		zlib-dev \
		imap-dev \
		make \
		m4 \
		pkgconf \
		re2c \
		xz \
		tar \
		curl \
		libmemcached-dev \
		cyrus-sasl-dev \
		libsasl \
		linux-headers \
		git \
#RUN curl -Lk http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.14.tar.gz -o /libiconv-1.14.tar.gz \
#	&& rm /usr/bin/iconv && cd / && tar xf libiconv-1.14.tar.gz && cd libiconv-1.14 \
#	&& curl -Lk https://github.com/mxe/mxe/raw/7e231efd245996b886b501dad780761205ecf376/src/libiconv-1-fixes.patch > /libiconv-1-fixes.patch \
#	&& patch -p1 < /libiconv-1-fixes.patch && ./configure --prefix=/usr/local && make && make install \
	&& apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing gnu-libiconv \
    && curl -Lk http://am1.php.net/distributions/php-${PHPVERSION}.tar.gz -o /php-${PHPVERSION}.tar.gz && cd / \
	&& addgroup -g 400 -S www && adduser -u 400 -S -H -s /sbin/nologin -g 'PHP' -G www www \
	&& tar xf php-${PHPVERSION}.tar.gz && cd php-${PHPVERSION} && ./configure --prefix=/usr/local/php \
        --with-config-file-path=/usr/local/php/etc \
        --with-config-file-scan-dir=/usr/local/php/etc/php.d \
        --enable-fpm \
        --with-fpm-user=www \
        --with-fpm-group=www \
        --enable-opcache \
        --disable-fileinfo \
        --with-mysql=mysqlnd \
        --with-mysqli=mysqlnd \
        --with-pdo-mysql=mysqlnd \
        --with-iconv \
        --with-iconv-dir=/usr/local \
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
#&& apk update && apk add --no-cache libmemcached-dev  libmemcached-dev \
#&& && mv /usr/lib/php5/modules/memcache.so /usr/local/php/lib/php/20131226/memcache.so \
#cd /tmp \
#   && git clone https://github.com/php-memcached-dev/php-memcached.git \
#   && cd php-memcached \
##  && git checkout php5 \
#   && phpize \
#   && ./configure --disable-memcached-sasl \
#   && make \
#   && make test \
#   && make install \
#  && cd /tmp \
#   && git clone https://github.com/phpredis/phpredis.git \
#   && cd phpredis \
##   && git checkout php5 \
#   && phpize \
#   && ./configure \
#   && make \
#   && make test \
#   && make install \
&& /usr/local/php/bin/pecl install https://pecl.php.net/get/memcache-3.0.8.tgz \
&& /usr/local/php/bin/pecl install https://pecl.php.net/get/redis-2.2.8.tgz \
&& /usr/local/php/bin/pecl install https://pecl.php.net/get/swoole-1.8.9.tgz \
&& /usr/local/php/bin/pecl install https://pecl.php.net/get/xdebug-2.5.0.tgz \
#&& apk add --no-cache --virtual .php-rundeps c-client freetype icu-libs libcrypto1.0 libcurl libgcc libintl libjpeg-turbo libmcrypt libpng libssl1.0 libstdc++ libx11 libxml2 libxpm libxslt musl zlib \
&& runDev="$( \
	scanelf --needed --nobanner /usr/local/php/sbin/php-fpm /tmp/envsubst \
		| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
		|sort -u \
		| xargs -r  apk info --installed \
		|sort -u \
)" \
&& apk add --no-cache --virtual .php-runDev ${runDev} \
&& apk del .build-deps && cd / && rm -rf /var/cache/apk/* /tmp/* /libiconv-1-fixes.patch /php-${PHPVERSION}* /libiconv-1.14.tar.gz
ENTRYPOINT /usr/local/php/sbin/php-fpm --nodaemonize
