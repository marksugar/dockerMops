#!/bin/sh
PATH=/usr/local/php/etc
mkdir $PATH -p
curl -Lk  https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-php/alpine-php-5.6.40/php-fpm.conf -o $PATH/php-fpm.conf
curl -Lk  https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-php/alpine-php-5.6.40/php.ini -o $PATH/php.ini
curl -Lk  https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-php/alpine-php-7.3.4/docker-compose.yml -o $PWD/docker-compose.yml
docker-compose $PWD/docker-compose.yml up -d