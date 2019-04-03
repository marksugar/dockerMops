docker-compose自用


| Version         |   compose    | type                | User ID | port      |date      |
| ----------------|------------- | ------------------- | ------- | --------- |--------- |
| 4.27-9668-beta  |       2      | docker-SoftEtherVPN | None    | 1194      |2018      |
|                 |       2      | docker-             | None    | 1194      |2018      |


# 目录

- [docker-SoftEtherVPN](#docker-SoftEtherVPN)
- [docker-redis](#docker-redis)
- [docker-nginx](#docker-nginx)
- [docker-alpine-gosu](#alpine)
## docker-SoftEtherVPN

https://github.com/marksugar/dockerMops/tree/master/docker-SoftEtherVPN

## docker-redis

https://github.com/marksugar/dockerMops/tree/master/docker-alpine-Redis/5.0

- redis5 install
```
curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-alpine-Redis/5.0/loadinstall.sh|bash
```
## docker-nginx

你需要一个nginx配置文件，而后挂载到容器内即可
```
curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-nginx/nginx-1.15.10.tar.gz|tar xz -C /etc/
curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-nginx/supervisord/docker-compose.yml -o $PWD/docker-compose.yml
docker-compose -f $PWD/docker-compose.yml up -d
```
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
## alpine
基于gosu和libfaketime
[gosu](https://github.com/tianon/gosu)用于普通用户启动应用
[libfaketime](https://github.com/wolfcw/libfaketime.git) 修改容器时间
```
docker pull marksugar/alpine:3.9-time-gosu
```
