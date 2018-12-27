lj=/data/docker/php-fpm
mkdir $lj /data/logs/php-fpm -p
curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-nginx-php-fpm/master/php-5.6.29_modules_redis_swoole/docker-compose.yaml -o $lj/docker-compose-php.yaml
curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-nginx-php-fpm/master/php-5.6.29_modules_redis_swoole/php-fpm.conf -o $lj/php-fpm.conf
curl -lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-nginx-php-fpm/master/php-5.6.29_modules_redis_swoole/php.ini -o $lj/php.ini
/usr/local/bin/docker-compose -f /data/docker/php-fpm/docker-compose-php.yaml up -d
