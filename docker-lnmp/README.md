* install LNP




要完成部署，你需要在本页面下载php-fpm.conf，php.ini,以及nginx配置文件，nginx配置文件将会被挂载到宿主机之上，采用network=host的网络模式

在脚本中完成了下载配置文件的大部分

* php-fpm:5.6.38
* nginx:1.15.10
* mariadb:10.0.38

- 脚本安装
```
curl -Lks4 https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-lnmp/create_lnp.sh |bash
```

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

如果发现“等待mariadb初始化完成”，请等候片刻即可，正常情况下你会看到phpinfo和mysql successful by LinuxEA!
```
Warning: mysql_connect(): Connection refused in /data/wwwroot/index.php on line 2
Connection refused等待mariadb初始化完成！
```