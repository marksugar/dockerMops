#!/bin/bash
#########################################################################
# File Name: nginx-php.sh
# Author: mark for www.linuxea.com
# Email: usertzc@gmail.com
# Version:
# Created Time: 2016年12月17日 星期六 16时57分48秒
#########################################################################

tpp=$(echo /data/docker/{php-fpm,nginx,mysql})
lgz=$(echo /data/logs/{nginx,php,mysql})
indexx=/data/wwwroot
mkdir $tpp $lgz $indexx -p
curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-nginx-php-fpm/master/php-fpm/php-fpm.conf -o /data/docker/php-fpm/php-fpm.conf
curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-nginx-php-fpm/master/php-fpm/php.ini -o /data/docker/php-fpm/php.ini
#nginx conf
curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-nginx-php-fpm/master/nginx.conf -o /data/docker/nginx/nginx.conf
curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-nginx-php-fpm/master/docker-commpose.yaml -o /data/docker/docker-commpose.yaml
/usr/local/bin/docker-compose -f /data/docker/docker-commpose.yaml up -d
