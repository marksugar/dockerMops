# docker-jumpserver
## install docker docker-compose
`curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-jumpserver-0.3.2/master/docker-create-jumpserver.sh|bash`

### as follows
Mariadb for https://github.com/LinuxEA-Mark/docker-mariaDB
```
[root@LinuxEA mariadb]# cat Dockerfile
FROM centos
MAINTAINER wwww.linuxea.com and mark make
RUN yum install epel* -y \
        && yum install libaio axel -y \
        #&& axel -n 10  http://kodeterbuka.beritagar.id/mariadb//mariadb-10.1.17/bintar-linux-x86_64/mariadb-10.1.17-linux-x86_64.tar.gz \
        && axel -n 10 http://mirrors.ds.com/tar%E5%8C%85/mariadb-10.1.17-linux-x86_64.tar.gz \
        && yum remove epel* axel -y && yum clean all \
        && tar xf mariadb-10.1.17-linux-x86_64.tar.gz -C /usr/local \
        && rm -rf  mariadb-10.1.17-linux-x86_64.tar.gz \
        && groupadd -r -g 306 mysql \
        && useradd -r -g 306 -u 306 mysql \
        && mkdir -p /mydata/data \
        && chown -R mysql.mysql  /mydata \
        && chown -R root.mysql /usr/local/mariadb-10.1.17-linux-x86_64 \
        && ln -s /usr/local/mariadb-10.1.17-linux-x86_64 /usr/local/mysql && cd /usr/local/mysql 
COPY initialization.sh initialization.sql /
RUN chmod +x /initialization.sh \
        && chown -R mysql.mysql /mydata/data
ENV PATH /usr/local/mysql/bin:$PATH
EXPOSE 3306
ENTRYPOINT ["/initialization.sh"]
```

```[root@LinuxEA mariadb]# docker build -t mariadb10.1.17 .```


```
[root@LinuxEA mariadb]# cat initialization.sh
#!/bin/bash

# if the /mydata/data directory doesn't contain anything, then initialise it
directory="/mydata/data"
if [ "$(ls -A $directory)" ]; then
    /usr/local/mysql/bin/mysqld_safe
else
    /usr/local/mysql/scripts/mysql_install_db --user=mysql --datadir=/mydata/data --basedir=/usr/local/mysql
    /usr/local/mysql/bin/mysqld_safe
    /usr/local/mysql/bin/mysql < /initialization.sql
fi
```

 ```
[root@LinuxEA mariadb]# cat initialization.sql 
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db LIKE 'test%';
DROP DATABASE test;
UPDATE mysql.user SET password = password('abc123') WHERE user = 'root';
CREATE DATABASE jumpserver charset='utf8';
GRANT ALL PRIVILEGES ON jumpserver.* To 'jumpserver'@'%' IDENTIFIED BY 'password';
flush privileges;
[root@LinuxEA mariadb]# 
```

```
[root@LinuxEA mariadb]# docker run --privileged=true --network=host --name db -v /mydata/data:/mydata/data:rw -v /mariadb/my.cnf:/etc/my.cnf -v /mydata/log:/mydata/log:rw -d -p 3306:3306 mariadb10.1.17
[root@LinuxEA mariadb]# docker start db
[root@LinuxEA mariadb]# mysql -uroot -p -h127.0.0.1
Enter password: 
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 3
Server version: 10.1.17-MariaDB MariaDB Server

Copyright (c) 2000, 2015, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| jumpserver         |
| mysql              |
| performance_schema |
+--------------------+
4 rows in set (0.00 sec)

MariaDB [(none)]> exit
```
