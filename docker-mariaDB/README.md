# Docker-MariaDB

Recently, I made a mirror of maxscale, if you will use it, you can try [maxscale reference](https://github.com/LinuxEA-Mark/maxscale/tree/master/conf)

这是一个mariadb的安装镜像，在安装前，你需要指定从网络还是本地安装，你需要修改，它使用centos作为基础镜像制作，因此体积较大，我并不建议你在生产环境使用它，你可以作为参考

* install

curl -LKs4 https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-mariaDB/docker-mysql-create.sh|bash 

## but, I re-produced a alpine as a basis, and now you can try 2017-07-21

我重新制作了一个以alpine作为基础的，现在你可以试试，2017年7月21日

它包含了以下信息：

It contains this information
```
      environment:
      - MYSQL_DATABASE=jumpserver
      - MYSQL_USER=jumpserver
      - MYSQL_PASSWORD=ispasswd
 ```
在第一次启动时，会调用[start.sh](https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-mariaDB/alpine-maridb/start.sh)进行配置，详细信息需要参考这个文件

In the first start, it will call start.sh configuration, the details need to refer to this document

* install alpine-mariadb

curl -Lk curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-mariaDB/alpine-maridb/create-alpine-mariadb.sh |bash |bash

* The latest update 2016/12/16
* ontent:
Modify the data directory and change /mydata/data/ to  /data/docker/mysql

* The latest update 2016/12/17
* ontent: Mariadb Version changed to 10.1.19 Binary Edition

```
[root@Linuxea-com /data/docker]# mysql -uroot -pabc123 -h127.0.0.1
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 4
Server version: 10.1.19-MariaDB MariaDB Server

Copyright (c) 2000, 2016, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> 
```
