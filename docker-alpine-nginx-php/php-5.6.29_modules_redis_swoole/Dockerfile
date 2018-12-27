FROM centos
MAINTAINER wwww.linuxea.com for mark
ENV PHPNA php-5.6.29

RUN yum install epel-release -y \
    && yum install -y gcc gcc-c++ automake autoconf libtool make curl\
       libxml2-devel \
       openssl \
       openssl-devel \
       bzip2 \
       bzip2-devel \
       libpng \
       libpng-devel \
       freetype \
       freetype-devel \
       libcurl-devel \
       libcurl libjpeg \
       libjpeg-devel \
       libpng \
       libpng-devel \
       freetype \
       freetype-devel \
       libmcrypt-devel \
       libmcrypt \
       libtool-ltdl-devel \
       libxslt-devel \
       mhash \
       mhash-devel \
       php-bcmath \
    && mkdir /usr/local/freetype -p && cd /usr/local \
    && curl -Lks https://ncu.dl.sourceforge.net/project/freetype/freetype2/2.6.5/freetype-2.6.5.tar.gz -o /usr/local/freetype-2.6.5.tar.gz \
    && tar xf freetype-2.6.5.tar.gz && rm -rf freetype-2.6.5.tar.gz && cd freetype-2.6.5 && ./configure --prefix=/usr/local/freetype && make && make install \
    && mkdir /usr/local/gettext -p && cd /usr/local \
    && curl -Lks http://ftp.gnu.org/pub/gnu/gettext/gettext-0.19.tar.gz -o /usr/local/gettext-0.19.tar.gz \
    && tar xf gettext-0.19.tar.gz && rm -rf gettext-0.19.tar.gz && cd gettext-0.19 && ./configure --prefix=/usr/local/gettext && make && make install && cd /usr/local \
    && curl -sO http://ftp.ntu.edu.tw/php/distributions/$PHPNA.tar.gz && tar xf $PHPNA.tar.gz -C /usr/local/ && cd /usr/local/$PHPNA \
#   && mv /usr/local/$PHPNA /usr/local/php && rm -rf $PHPNA.tar.gz && cd  /usr/local/$PHPNA \
    && groupadd -g 499 -r nginx \
    && useradd -u 499 -g nginx -r nginx -s /sbin/nologin \
    && ./configure --prefix=/usr/local/php \
       --disable-pdo \
       --disable-debug \
       --disable-rpath \
       --enable-inline-optimization \
       --enable-sockets \
       --enable-sysvsem \
       --enable-sysvshm \
       --enable-pcntl \
       --enable-mbregex \
       --enable-xml \
       --enable-zip \
       --enable-fpm \
       --enable-bcmath \
       --enable-mbstring \
       --with-pcre-regex \
       --with-mysql \
       --with-mysqli \
       --with-gd \
       --with-jpeg-dir \
       --with-bz2 \
       --with-zlib \
       --with-mhash \
       --with-curl \
       --with-mcrypt \
       --with-jpeg-dir \
       --with-png-dir \
       --with-freetype-dir=/usr/local/freetype \
       --with-gettext=/usr/local/gettext \
    && make && make install \
#	&& /usr/local/php/bin/pear install PEAR-1.10.1 \
    && curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-nginx-php-fpm/master/php-5.6.29_modules_redis_swoole/swoole-1.7.19.tgz -o /swoole-1.7.19.taz \
    && /usr/local/php/bin/pecl install /swoole-1.7.19.taz \
#    && /usr/local/php/bin/pecl install https://pecl.php.net/get/swoole-1.7.19.tgz \
    && /usr/local/php/bin/pecl install redis \
    && yum remove make gcc gcc-c++ -y\
    && yum clean all \
    && cp /usr/local/$PHPNA/php.ini-production /usr/local/php/lib/php.ini \
    && sed -i 's/;date.timezone =/date.timezone = Asia\/Shanghai/' /usr/local/php/lib/php.ini && mkdir /logs \
    && rm -rf /usr/local/php-5.6.29 /usr/local/gettext-0.19 /usr/local/freetype-2.6.5 /swoole-1.7.19.taz
#   && curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/nmp/master/php-fpm.conf -o /usr/local/php/etc/php-fpm.conf
#ENV PATH /usr/local/php/sbin:$PATH
#EXPOSE 9000
ENTRYPOINT /usr/local/php/sbin/php-fpm --nodaemonize
