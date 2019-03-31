#!/bin/bash
mkdir /data/{wwwroot,logs,mariadb} /usr/local/php/etc/ -p
curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-nginx/nginx-1.15.10.tar.gz|tar xz -C /etc/
curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-php/alpine-php-5.6.38/php-fpm.conf -o /usr/local/php/etc/php-fpm.conf
curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-php/alpine-php-5.6.38/php.ini -o /usr/local/php/etc/php-fpm.ini
curl -Lks4 https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-lnmp/docker-compose-LNP.yaml -o /data/docker-compose-LNP.yaml
docker-compose -f /data/docker-compose-LNP.yaml up  -d
