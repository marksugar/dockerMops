不同的在于并非以往创建用户
```
#groupadd -g 400 www  && useradd  -u 400 -g www  -m -s /usr/sbin/nologin www && \
```
而是修改uid来应对和nginx的权限
```
sed -i  's/www-data:x:33:33/www-data:x:400:400/g' /etc/passwd && \
```

see
```
root@dbe342e833bc:/var/www/html# php -m| egrep "mysql|redis"
mysqli
mysqlnd
pdo_mysql
redis


root@dbe342e833bc:/var/www/html# php -r 'phpinfo();' | grep pdo
Configure Command =>  './configure'  '--build=x86_64-linux-gnu' '--with-config-file-path=/usr/local/etc/php' '--with-config-file-scan-dir=/usr/local/etc/php/conf.d' '--enable-option-checking=fatal' '--with-mhash' '--with-pic' '--enable-mbstring' '--enable-mysqlnd' '--with-password-argon2' '--with-sodium=shared' '--with-pdo-sqlite=/usr' '--with-sqlite3=/usr' '--with-curl' '--with-iconv' '--with-openssl' '--with-readline' '--with-zlib' '--disable-phpdbg' '--with-pear' '--with-libdir=lib/x86_64-linux-gnu' '--disable-cgi' '--enable-fpm' '--with-fpm-user=www-data' '--with-fpm-group=www-data' 'build_alias=x86_64-linux-gnu'
/usr/local/etc/php/conf.d/docker-php-ext-pdo_mysql.ini,
API Extensions => mysqli,pdo_mysql
pdo_mysql
pdo_mysql.default_socket => no value => no value
pdo_sqlite

```

依赖： https://github.com/docker-library/php/blob/master/8.3/bookworm/fpm/Dockerfile

插件：https://github.com/swoole/docker-swoole/blob/master/dockerfiles/5.1.0/php8.3/alpine/Dockerfile