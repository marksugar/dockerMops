#!/bin/bash
PHPATH=/usr/local/php/etc/
PHPLOG=/data/logs/php-fpm/
[ -d ${PHPATH} ]|| mkdir ${PHPATH} -p
[ -d ${PHPLOG} ]|| mkdir ${PHPLOG} -p
curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-alpine-php/master/php-5.6.38/php-fpm.conf -o /usr/local/php/etc/php-fpm.conf
curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-alpine-php/master/php-5.6.38/php.ini -o /usr/local/php/etc/php.ini
curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-alpine-php/master/php-5.6.38/docker-compose.yaml -o $PWD/docker-compose.yaml
docker-compose -f $PWD/docker-compose.yaml up -d
