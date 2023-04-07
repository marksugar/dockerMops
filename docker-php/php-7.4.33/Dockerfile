FROM php:7.4.33-fpm-alpine
MAINTAINER mark
ENV TZ "Asia/Shanghai"
ENV TERM xterm
# 默认关闭opcode
ENV OPCODE 0
ARG PHP_EXTENSION="gd pdo_mysql opcache bcmath mysqli sockets"
# sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories alibaba
COPY ./conf/ $PHP_INI_DIR/conf.d/
COPY composer.phar /usr/local/bin/composer
# 覆盖原本的配置文件，映射也可以覆盖
COPY php.conf /usr/local/etc/php-fpm.d/php.conf
RUN addgroup -g 400 -S www \
    && adduser -u 400 -S -H -s /sbin/nologin -g 'PHP' -G www www \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update  \
    && apk add --no-cache \
        # libfreetype6-dev \
        # libfreetype6-dev \
        freetype \
        freetype-dev \
        libstdc++ \
        libzip \
        libzip-dev \
        libjpeg-turbo \
        # libjpeg62-turbo-dev \
        libjpeg-turbo-dev \
        libpq-dev \
        postgresql-dev \
        vim \
        libpng \
        libpng-dev \
        libwebp-dev \
        # $PHPIZE_DEPS 原来镜像内置变量安装包
        $PHPIZE_DEPS \
        unzip \
        curl \
    && pecl install redis-5.3.4 \
    && pecl install zip \
    && pecl install swoole-4.7.1 \
    && pecl install xdebug-3.1.5 \
    && docker-php-ext-enable redis zip swoole\
    && docker-php-ext-configure gd \
    #  7.4 不使用png,并且不需要dir
    # https://github.com/docker-library/php/issues/912#issuecomment-559918036
    # https://github.com/docker-library/php/issues/931
        --with-freetype=/usr/include/ \
        --with-jpeg=/usr/include/ \
        # --with-png=/usr/include/ \
        --with-webp=/usr/include/ \
    && docker-php-ext-install -j "$(nproc)" ${PHP_EXTENSION} \
    # && docker-php-ext-install -j$(nproc) gd \
    # && docker-php-ext-install -j$(nproc) pdo_mysql \
    # && docker-php-ext-install -j$(nproc) opcache \
    # && docker-php-ext-install -j$(nproc) bcmath \
    # && docker-php-ext-install -j$(nproc) mysqli \
    && chmod +x /usr/local/bin/composer \
    && apk del $PHPIZE_DEPS \
    && rm -rf /var/cache/apk/* /tmp/*  \
    && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    && mv /usr/local/etc/php-fpm.d/www.conf  /usr/local/etc/php-fpm.d/www.conf-bak
# config php error handler
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
} > "$PHP_INI_DIR/php.ini"
	# } > /usr/local/etc/php/conf.d/error-logging.ini    
EXPOSE 9000
ENTRYPOINT ["php-fpm"]