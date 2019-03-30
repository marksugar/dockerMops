## supervisord build

docker build --build-arg version="1.15.10" -t marksugar/nginx:1.15.10 .

## depoly
docker run  -d marksugar/nginx:1.15.10

## nginx conf

$ curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-nginx/nginx-1.15.10.tar.gz|tar xz -C /etc/

$ ls /etc/nginx/
fastcgi.conf            koi-utf             nginx.conf           uwsgi_params
fastcgi.conf.default    koi-win             nginx.conf.default   uwsgi_params.default
fastcgi_params          mime.types          scgi_params          vhost
fastcgi_params.default  mime.types.default  scgi_params.default  win-utf

- mount

π“‘ÿ≈‰÷√Œƒº˛µΩ/etc/nginx

- docker-compose 
```
version: '2'
services:
  nginx:
    image: marksugar/nginx:1.15.10
    container_name: nginx
    restart: always
    network_mode: "host"
#    volumes_from:
#    - php-fpm
    volumes: 
    - /etc/nginx/:/etc/nginx/
    - /data/wwwroot:/data/wwwroot
    - /data/logs/:/data/logs/ 
    ports:
    - "40080:40080"
	- "80:80"
```	