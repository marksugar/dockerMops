docker-compose自用


| Version         |   compose    | type                   | User ID | port      |date      |
| ----------------|------------- | ---------------------- | ------- | --------- |--------- |
| SoftEtherVPN:4.27-9668-beta  |       2      | docker-SoftEtherVPN    | None    | 1194      |2018      |
| redis:5.0             |       2      | docker-redis           | None    | 6379/26379|2019      |
| nginx:1.15.10         |       2      | docker-nginx           | None    | 40080/80  |2019      |
| alpine:3.9/3.8      |       2      | docker-alpine-gosu     | None    | None      |2019      |
| nginx1.14.2/vsftpd   |       2      | docker-nginx-createrepo| None    | 80/21 |2019      |
| mariadb:10.2.15   |       2      | docker-mariadb| None    | 3306 |2019      |
| svn:1.10 | 2 | docker-svn | None | 3690 |2019
| php-fpm:5.6.40/7.x| 2 |docker-php-fpm|www |9000|2019
# 目录

- [docker-SoftEtherVPN](#docker-SoftEtherVPN)
- [docker-redis](#docker-redis)
- [docker-nginx](#docker-nginx)
- [docker-alpine-gosu](#alpine)
- [docker-nginx-createrepo](#docker-nginx-createrepo)
- [docker-mariadb](#docker-mariadb)
- [docker-nmp](#docker-lnmp)
- [docker-svn](#docker-svn)
- [docker-php-fpm](#docker-php-fpm)

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
## docker-php-fpm
我们需要下载一个配置文件而后通过docker-compose启动
- install 5.6.40
```
curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-php/alpine-php-5.6.40/install_5.6.40.sh |bash
```   
docker-compose大致如下：
```
version: '2'
services:
  php-fpm:
    image: marksugar/php-fpm:5.6.40
    container_name: php-fpm
    restart: always
    network_mode: "host"
    volumes:
    - /usr/local/php/etc/php-fpm.conf:/usr/local/php/etc/php-fpm.conf
    - /usr/local/php/etc/php.ini:/usr/local/php/lib/php.ini
    - /data/logs/php-fpm:/logs
    - /data/wwwroot:/data/wwwroot
```	
- install 7.3.4
```
curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-php/alpine-php-7.3.4/install-php-734.sh|bash
```
docker-compose大致如下：
```
version: '2'
services:
  php-fpm:
    image: marksugar/php-fpm:7.3.4
    container_name: php-fpm
    restart: always
    network_mode: "host"
    volumes:
    - /usr/local/php/etc/php-fpm.conf:/usr/local/php/etc/php-fpm.conf
    - /usr/local/php/etc/php.ini:/usr/local/php/lib/php.ini
    - /data/logs/php-fpm:/logs
    - /data/wwwroot:/data/wwwroot
```	
- install php-fpm:7.3.4-gosu

docker pull  marksugar/php-fpm:7.3.4-gosu

假如你要使用不同的用户和Id来启动php-fpm
你需要传递两个不同的变量
```
-e USER_ID=400
-e USER_NAME=www
```
而后挂载php-fpm文件，在文件中也需要修改成传递的用户，这些用户在传递后会被创建
```
-v ~/php-fpm/7.3/php-fpm.conf:/usr/local/php/etc/php-fpm.conf 
```
另外日志需要放在用户的家目录
```
pid = /home/www/php-fpm.pid
error_log = /home/www/php-fpm.log
slowlog = /home/www/slow.log
```
以及用户
```
listen.owner = www
listen.group = www
user = www
group = www
```

- start

```
[root@linuxea.com ~/php-fpm/7.3]# docker run -e USER_ID=400 \
			-e USER_NAME=www \
			-v ~/php-fpm/7.3/php-fpm.conf:/usr/local/php/etc/php-fpm.conf \
			marksugar/php-fpm:7.3.4-gosu
			
Starting with UID : 4001 And user www
addgroup: group 'www' in use
adduser: user 'www' in use
```
```
[root@linuxea.com ~/php-fpm/7.3]# docker exec -it suspicious_agnesi bash
bash-4.4# ps aux
PID   USER     TIME  COMMAND
    1 www       0:00 php-fpm: master process (/usr/local/php/etc/php-fpm.conf)
   14 www       0:00 php-fpm: pool www
   15 www       0:00 php-fpm: pool www
   16 www       0:00 php-fpm: pool www
   17 www       0:00 php-fpm: pool www
   18 www       0:00 php-fpm: pool www
   19 www       0:00 php-fpm: pool www
   20 www       0:00 php-fpm: pool www
   21 www       0:00 php-fpm: pool www
   22 www       0:00 php-fpm: pool www
   23 www       0:00 php-fpm: pool www
   24 www       0:00 php-fpm: pool www
   25 www       0:00 php-fpm: pool www
   26 www       0:00 php-fpm: pool www
   27 www       0:00 php-fpm: pool www
   28 www       0:00 php-fpm: pool www
   29 www       0:00 php-fpm: pool www
   30 www       0:00 php-fpm: pool www
   31 www       0:00 php-fpm: pool www
   32 www       0:00 php-fpm: pool www
   33 www       0:00 php-fpm: pool www
   34 www       0:00 php-fpm: pool www
   35 www       0:00 php-fpm: pool www
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
传递-e USER_ID=ID USER_NAME=USER修改id和程序用户，这取决于[entrypoint.sh](https://github.com/marksugar/dockerMops/blob/master/docker-alpine/3.9/baseimage-libfaketime-gosu/entrypoint.sh)脚本
```
USER_ID=${USER_ID:-1101}
USER_NAME=${USER_NAME:-www}
```
- 仍然有一个3.8版本的alpine专门为php使用**marksugar/alpine:3.8-time-gosu**
## docker-mariadb
- install 
```
curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-mariaDB/alpine-maridb/create-alpine-mariadb.sh |bash
```
它包含了以下信息：
```
      environment:
      - MYSQL_DATABASE=jumpserver
      - MYSQL_USER=jumpserver
      - MYSQL_PASSWORD=ispasswd
```
在第一次启动时，会调用[start.sh](https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-mariaDB/alpine-maridb/start.sh)进行配置，详细信息需要参考这个文件
```
[root@Linuxea-com /data/docker]# mysql -uroot -pabc123 -h127.0.0.1
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 4
Server version: 10.1.19-MariaDB MariaDB Server

Copyright (c) 2000, 2016, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> 
```
## docker-lnmp

参考[lnmp页面](https://github.com/marksugar/dockerMops/tree/master/docker-lnmp)

如果你要使用Php7.3.4，如下

And install php 7.3.4
```
curl -Lk  https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-php/alpine-php-7.3.4-gosu/php-fpm.conf -o $PHPATH/php-fpm.conf
curl -Lk  https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-php/alpine-php-5.6.40/php.ini -o $PHPATH/php.ini
```
```
curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-nginx/nginx-1.15.10.tar.gz|tar xz -C /etc/
```
docker-compose
```
version: '2'
services:
  php-fpm:
    image: marksugar/php-fpm:7.3.4-gosu
    container_name: php-fpm
    restart: always
    network_mode: "host"
    environment:
    - USER_ID=400
    - USER_NAME=www
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
## docker-svn
Joined the supervisor daemon Version 1.10

添加了守护程序supervisor1.0

Please make sure your host is using the redhat series.

并且确保你的系统是redhat系列

If yes, try

如果是你可以试试安装
```
curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-subversion/Optimized/svn-1.10-install.sh|bash
```
