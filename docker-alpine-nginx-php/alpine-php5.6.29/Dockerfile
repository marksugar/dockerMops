FROM alpine
MAINTAINER mark
RUN apk --update --no-cache upgrade \
	&& apk add --no-cache --virtual .build-deps curl-dev libedit-dev libxml2-dev openssl-dev sqlite-dev libxpm-dev libaio-dev libjpeg-turbo-dev libpng-dev libmcrypt-dev icu-dev freetype-dev gettext-dev libxslt-dev zlib-dev imap-dev gettext-dev autoconf file g++ gcc libc-dev make m4 pkgconf re2c xz tar curl libmemcached-dev cyrus-sasl-dev libsasl linux-headers git freetype-dev \
	&& curl -Lk http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.14.tar.gz -o /libiconv-1.14.tar.gz \
	&& rm /usr/bin/iconv && cd / && tar xf libiconv-1.14.tar.gz && cd libiconv-1.14 \
	&& curl -Lk https://github.com/mxe/mxe/raw/7e231efd245996b886b501dad780761205ecf376/src/libiconv-1-fixes.patch > /libiconv-1-fixes.patch \
	&& patch -p1 < /libiconv-1-fixes.patch && ./configure --prefix=/usr/local && make && make install \
    && curl -Lk http://am1.php.net/distributions/php-5.6.29.tar.gz -o /php-5.6.29.tar.gz && cd / \
	&& addgroup -g 400 -S www && adduser -u 400 -S -H -s /sbin/nologin -g 'PHP' -G www www \
	&& tar xf php-5.6.29.tar.gz && cd php-5.6.29 && ./configure --prefix=/usr/local/php \
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
&& apk update && apk add --no-cache php5-memcache libmemcached-dev \
&& mv /usr/lib/php5/modules/memcache.so /usr/local/php/lib/php/20131226/memcache.so \
&& /usr/local/php/bin/pecl install https://pecl.php.net/get/redis-2.2.8.tgz \
&& /usr/local/php/bin/pecl install https://pecl.php.net/get/swoole-1.8.9.tgz \
&& /usr/local/php/bin/pecl install https://pecl.php.net/get/xdebug-2.5.0.tgz \
&& apk add --no-cache --virtual .php-rundeps c-client freetype icu-libs libcrypto1.0 libcurl libgcc libintl libjpeg-turbo libmcrypt libpng libssl1.0 libstdc++ libx11 libxml2 libxpm libxslt musl zlib \
&& apk del .build-deps && cd / && rm -rf /var/cache/apk/* /tmp/* /libiconv-1-fixes.patch /php-5.6.29.tar.gz /libiconv-1.14.tar.gz
#curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-nginx-php-fpm/master/php5.6.29/php-fpm.conf -o /usr/local/php/etc/php-fpm.conf
#curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-nginx-php-fpm/master/php5.6.29/php.ini -o /usr/local/php/lib/php.ini
ENTRYPOINT /usr/local/php/sbin/php-fpm --nodaemonize
