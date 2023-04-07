# sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories alibaba 
FROM alpine:3.13.3
MAINTAINER mark
ARG version="5.6.38"
# # docker build --build-arg PHPVERSION="7.4.33" -t marksugar/php-fpm:7.4.33 .
ENV PHPVERSION=${version}
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update \
	&& apk add --no-cache --virtual .build-deps \
        libfreetype6-dev \
        freetype-dev \
        libjpeg62-turbo-dev \
        libjpeg-turbo-dev \
        libpq-dev \
        postgresql-dev \
        libpng-dev \
        libzip-dev \
        libwebp-dev \
        unzip \
        
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
        yaml-dev \
        libevent-dev \
	&& apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted gnu-libiconv \
    && curl -Lk http://am1.php.net/distributions/php-${PHPVERSION}.tar.gz -o /php-${PHPVERSION}.tar.gz && cd / \
	&& addgroup -g 400 -S www && adduser -u 400 -S -H -s /sbin/nologin -g 'PHP' -G www www \
	&& tar xf php-${PHPVERSION}.tar.gz && cd php-${PHPVERSION} && ./configure --prefix=/usr/local/php \
        --with-config-file-path=/usr/local/php/etc \
        --with-config-file-scan-dir=/usr/local/php/etc/php.d \
        --enable-fpm \
        --with-fpm-user=www \
        --with-fpm-group=www \
        --enable-opcache \
        --with-webp \
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
&& /usr/local/php/bin/pecl install https://pecl.php.net/get/memcache-3.0.8.tgz \
&& /usr/local/php/bin/pecl install https://pecl.php.net/get/redis-2.2.8.tgz \
&& /usr/local/php/bin/pecl install https://pecl.php.net/get/swoole-1.8.9.tgz \
&& /usr/local/php/bin/pecl install https://pecl.php.net/get/xdebug-2.5.0.tgz \
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