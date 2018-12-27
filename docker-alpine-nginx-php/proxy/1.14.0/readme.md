> nginx config file

镜象内有配置文件
但是，你也可以挂在本地目录，将本地配置文件挂载容器内

```
curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-alpine-nginx-php/master/proxy/1.14.0/nginx.tar.gz |tar xz -C /etc
```

> startup

```
curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-alpine-nginx-php/master/proxy/1.14.0/docker-compose.yaml -o $PWD/docker-compose.yaml && docker-compose -f $PWD/docker-compose.yaml up -d 
```
