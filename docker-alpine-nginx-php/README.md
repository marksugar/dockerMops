这个已经暂停维护，nginx移步到[docker-nginx](https://github.com/marksugar/dockerMops/tree/master/docker-nginx)

Some php use centos image, [nginx_1.14.0](https://github.com/LinuxEA-Mark/docker-alpine-nginx-php/tree/master/nginx_1.14.0) installed vts module

[nginx 1.12.0 install](https://github.com/LinuxEA-Mark/docker-alpine-nginx-php/tree/master/nginx-1.12.0)

[Docker link Mariadb install](https://github.com/LinuxEA-Mark/docker-mariaDB)

[php5.6.29 alpine install ](https://github.com/LinuxEA-Mark/docker-alpine-nginx-php/tree/master/alpine-php5.6.29)

[nginx_1.14.0 install ](https://github.com/LinuxEA-Mark/docker-alpine-nginx-php/tree/master/nginx_1.14.0)

[docker-nginx_createrepo](https://github.com/LinuxEA-Mark/docker-createrepo)

These can be used for testing and reference.

[LNP](https://github.com/LinuxEA-Mark/docker-alpine-nginx-php/tree/master/LNP)

[php-5.6.29_modules_redis_swoole](https://github.com/LinuxEA-Mark/docker-alpine-nginx-php/tree/master/php-5.6.29_modules_redis_swoole)
* mysql link verification
```
<?php 
$link=mysql_connect("mysql1","linuxea","linuxea"); 
if(!$link) echo "<center><h1>FAILD!\nlinks www.linuxea.com error username and passwd<h1></center>"; 
else echo "<center><br/><h1>OK!<br/>www.linuxea.com links normal<h1></center>"; 
?> 
```
* install nginx and php

curl -lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-nginx-php-fpm/master/nginx-php.sh |bash
