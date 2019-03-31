* install LNP

-  [php-5.6.38]download php.conf
```
mkdir /usr/local/php/etc/
curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-php/alpine-php-5.6.38/php-fpm.conf -o /usr/local/php/etc/php-fpm.conf
curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-php/alpine-php-5.6.38/php.ini -o /usr/local/php/etc/php-fpm.ini
```
- [nginx-1.15.10]download nginx.conf
```
curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-nginx/nginx-1.15.10.tar.gz|tar xz -C /etc/
```
- [nginx+php+mariadb]docker-compose
```
version: '2'
services:
  php-fpm:
    image: marksugar/php-fpm:5.6.38
    container_name: php-fpm
    restart: always
    network_mode: "host"
    logging:
      driver: "json-file"
      options:
        max-size: "1G"    
    volumes:
    - /usr/local/php/etc/php-fpm.conf:/usr/local/php/etc/php-fpm.conf
    - /usr/local/php/etc/php.ini:/usr/local/php/lib/php.ini
    - /data/logs/php-fpm:/logs
    - /data/wwwroot:/data/wwwroot
  nginx:
    image: marksugar/nginx:1.15.10
    container_name: nginx
    privileged: true
    restart: always
    network_mode: "host"
    logging:
      driver: "json-file"
      options:
        max-size: "1G"
    volumes_from:
      - php-fpm
    volumes:
    - /etc/nginx/:/etc/nginx/
    - /data/wwwroot:/data/wwwroot
    - /data/logs/:/data/logs/
    ports:
    - "40080:40080"
    - "80:80"
  mariadb:
    image: marksugar/mariadb:10.2.15  
    container_name: mariadb
    privileged: true
    restart: always
    network_mode: "host"
    volumes:
      - /etc/localtime:/etc/localtime:ro      
      - /data/mariadb:/data/mariadb:rw
    environment:
      - MYSQL_DATABASE=jumpserver
      - MYSQL_USER=jumpserver
      - MYSQL_PASSWORD=ispasswd
    ports:
      - "3306"	
```

curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-alpine-nginx-php/master/LNP/create_lnp.sh |bash
