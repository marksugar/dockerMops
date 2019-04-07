docker-compose自用


| Version         |   compose    | type                   | User ID | port      |date      |
| ----------------|------------- | ---------------------- | ------- | --------- |--------- |
| SoftEtherVPN:4.27-9668-beta  |       2      | docker-SoftEtherVPN    | None    | 1194      |2018      |
| redis:5.0             |       2      | docker-redis           | None    | 6379/26379|2019      |
| nginx:1.15.10         |       2      | docker-nginx           | None    | 40080/80  |2019      |
| alpine:3.9      |       2      | docker-alpine-gosu     | None    | None      |2019      |
| nginx1.14.2          |       2      | docker-nginx-createrepo| None    | None      |2019      |

# 目录

- [docker-SoftEtherVPN](#docker-SoftEtherVPN)
- [docker-redis](#docker-redis)
- [docker-nginx](#docker-nginx)
- [docker-alpine-gosu](#alpine)
- [docker-nginx-createrepo](# docker-nginx-createrepo)

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
## docker-nginx-createrepo
这是一个我用来做内网共享文件的mirrors，我更新了后可以使用ftp上传更方便，点[此处](https://github.com/marksugar/dockerMops/tree/master/docker-createrepo/vsftp)前往查看
- 部署
```
curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-createrepo/vsftp/deploy|bash
```
你至少需要挂载目录，如果你不想修改默认的变量参数，就会使用默认参数
```
    network_mode: "host"
    volumes:
      - /data/mirrors1:/data
      - /etc/localtime:/etc/localtime:ro
    environment:
      - USERNAME=marksugar
      - FTPPASSWD=123
      - FTPDATA=/data/wwwroot
      - SERVER_NAME=localhost
      - NGINX_PORT=80
      - WELCOME="welome to linuxea.com"
```
用作eval来进行替换，这是一个好方法。在这个ftp与docker-createrepo组合中使用
```
eval "echo \"$(cat /opt/.supervisord.conf)\"" > /etc/supervisord.conf
```
添加锁定目录用户: marksugar
## alpine
基于gosu和libfaketime

[gosu](https://github.com/tianon/gosu)用于普通用户启动应用

[libfaketime](https://github.com/wolfcw/libfaketime.git) 修改容器时间

```
docker pull marksugar/alpine:3.9-time-gosu
```
