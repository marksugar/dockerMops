lj=/data/docker/php-fpm
mkdir $lj -p
curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-nginx-php-fpm/master/alpine-php5.6.29/docker-compose-php.yaml -o $lj/docker-compose-php.yaml
curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-nginx-php-fpm/master/alpine-php5.6.29/php-fpm.conf -o $lj/php-fpm.conf
curl -lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-nginx-php-fpm/master/alpine-php5.6.29/php.ini -o $lj/php.ini
/usr/local/bin/docker-compose -f /data/docker/php-fpm/docker-compose.yaml up -d
