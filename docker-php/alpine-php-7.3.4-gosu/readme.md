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