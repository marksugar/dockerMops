# see https://github.com/docker-library/php/blob/master/8.3/bookworm/fpm/Dockerfile
FROM php:8.3.12-fpm-bookworm
MAINTAINER mark
ENV TZ "Asia/Shanghai"

ENV TERM xterm

# 默认关闭opcode
ENV OPCODE 0

ENV DEBIAN_FRONTEND=noninteractive
# ENV TERM=xterm-color
COPY php.conf /usr/local/etc/php-fpm.d/php.conf
ARG DEV_MODE
ENV DEV_MODE=$DEV_MODE
ARG PHP_EXTENSION="gd pdo_mysql opcache bcmath mysqli sockets"
RUN \
    set -ex && \
    #groupadd -g 400 www  && useradd  -u 400 -g www  -m -s /usr/sbin/nologin www && \
    sed -i  's/www-data:x:33:33/www-data:x:400:400/g' /etc/passwd && \
    curl -sfL https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer && \
    chmod +x /usr/bin/composer && \
    apt-get update  && \
    apt-get install -y \
        libcurl4-openssl-dev       \
        libbrotli-dev              \
        libfreetype-dev  \
        libjpeg62-turbo-dev \
        libpng-dev \
        libpq-dev                  \
        libssl-dev                 \
        supervisor                 \
        unzip                      \
        zlib1g-dev                 \
        --no-install-recommends  \
# PHP extension pdo_mysql is included since 4.8.12+ and 5.0.1+.
    && docker-php-ext-install pdo_mysql  \
    && pecl channel-update pecl.php.net  \
    && pecl install --configureoptions 'enable-redis-igbinary="no" enable-redis-lzf="no" enable-redis-zstd="no"' redis-6.0.2  \
# PHP extension Redis is included since 4.8.12+ and 5.0.1+.
    && docker-php-ext-enable redis  \
    && docker-php-ext-install sockets \
    && docker-php-source extract  \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    # && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install -j "$(nproc)" ${PHP_EXTENSION} \
    && mkdir /usr/src/php/ext/swoole  \
    # https://github.com/swoole/docker-swoole/blob/master/dockerfiles/5.1.0/php8.3/alpine/Dockerfile
    && curl -sfL https://github.com/swoole/swoole-src/archive/v5.1.0.tar.gz -o swoole.tar.gz  \
    && tar xfz swoole.tar.gz --strip-components=1 -C /usr/src/php/ext/swoole  \
    && docker-php-ext-configure swoole \
        --enable-mysqlnd      \
        --enable-swoole-pgsql \
        --enable-openssl      \
        --enable-sockets --enable-swoole-curl  \
    && rm -rf /var/lib/apt/lists/* /usr/bin/qemu-*-static
RUN { \
    echo 'error_reporting = E_ERROR | E_WARNING | E_PARSE | E_CORE_ERROR | E_CORE_WARNING | E_COMPILE_ERROR | E_COMPILE_WARNING | E_RECOVERABLE_ERROR'; \
    echo 'display_errors = Off'; \
    echo 'display_startup_errors = Off'; \
    echo 'log_errors = On'; \
    echo 'error_log = /dev/stderr'; \
    echo 'log_errors_max_len = 1024'; \
    echo 'ignore_repeated_errors = On'; \
    echo 'ignore_repeated_source = Off'; \
    echo 'html_errors = Off'; \
# } > "$PHP_INI_DIR/php.ini"
} > /usr/local/etc/php/conf.d/error-logging.ini   
EXPOSE 9000
CMD ["php-fpm"]