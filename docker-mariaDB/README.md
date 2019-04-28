- build

https://downloads.mariadb.com/MariaDB
```
docker build  --build-arg versionurl="https://downloads.mariadb.com/MariaDB/mariadb-galera-5.5.63/bintar-linux-glibc_214-x86_64/mariadb-galera-5.5.63-linux-glibc_214-x86_64.tar.gz" -t marksugar/mariadb:5.5.63  .

```
# Docker-MariaDB

基础镜像: debian:9.8

```
docker pull marksugar/mariadb:10.0.38
docker pull marksugar/mariadb:5.5.63
```
环境变量
 ```
     environment:
       - USER_ID=306
       - USER_NAME=mysql
       - MYSQL_DATABASE=jumpserver
       - MYSQL_USER=jumpserver
       - MYSQL_PASSWORD=ispasswd
```
- docker-compose
```
version: '3'
services:
  mariadb:
    image: marksugar/mariadb:10.0.38
    container_name: mariadb
    restart: always
    network_mode: "host"
    environment:
    - USER_ID=306
    - USER_NAME=mysql
    volumes:
    - /data/mariadb:/data/mariadb
    logging:
      driver: "json-file"
      options:
        max-size: "1G"
```
## alpine

它包含了以下信息：

```
    environment:
      - MYSQL_DATABASE=jumpserver
      - MYSQL_USER=jumpserver
      - MYSQL_PASSWORD=ispasswd
 ```
在第一次启动时，会调用[start.sh](https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-mariaDB/10.2.15/start.sh)进行配置，详细信息需要参考这个文件


* install 10.2.15
```
curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-mariaDB/10.2.15/create-alpine-mariadb.sh |bash
```
* install 10.2.22
```
mkdir /data/ -p
curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-mariaDB/10.2.22/docker-compose.yml -o /data/docker-compose.yml
docker-compose -f /data/docker-compose.yml up  -d
```

```
[root@Linuxea-com /data/docker]# mysql -uroot -pabc123 -h127.0.0.1
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 4
Server version: 10.1.19-MariaDB MariaDB Server

Copyright (c) 2000, 2016, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> 
```
