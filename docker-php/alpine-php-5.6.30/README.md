*  system uses alpine: 3.6, php version 5.6.30, libiconv version 1.5, where the compiler parameters are as follows:
```
/configure --prefix=/usr/local/php \
--with-config-file-path=/usr/local/php/etc \
--with-config-file-scan-dir=/usr/local/php/etc/php.d \
--enable-opcache \
--enable-fpm \
--with-fpm-user=nginx \
--with-fpm-group=nginx \
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
--with-imap
```
* In addition, also loaded memcached-2.2.0, redis-2.2.8, swoole-1.8.9, xdebug-2.5.0, but xdebug did not provide configuration files
These can be closed or opened by compose, as follows:
```
Environment:
         - CHDIR = / data / wwwroot
         - LISTEN = 9000
         - LISTEN_BACKLOG = -1
         - LISTEN_OWNER = www
         - LISTEN_GROUP = www
         - LISTEN_MODE = 0777
         - USER = www
         - GROUP = www
         - PM = dynamic
         - PM_MAX_CHILDREN = 14
         - PM_START_SERVERS = 6
         - PM_MIN_SPARE_SERVERS = 4
         - PM_MAX_SPARE_SERVERS = 12
         - PM_MAX_REQUESTS = 2048
         - PM_PROCESS_IDLE_TIMEOUT = 10s
         - REQUEST_TERMINATE_TIMEOUT = 120
         - REQUEST_SLOWLOG_TIMEOUT = 0
         - ENABLED_REDIS = redis.so
         - ENABLED_MEMCACHED = memcached.so
         - ENABLED_XDEBUG = xdebug.so
         - ENABLED_SWOOLE = swoole.so
         - MEM_LIMIT = 256M
```
