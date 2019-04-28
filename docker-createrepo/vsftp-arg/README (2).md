- build

docker build --build-arg version="1.15.12" -t marksugar/nginx_createrepo:v0.3 .

- image

docer pull marksugar/nginx_createrepo:v0.3 

- docker-compsoe

可以往vhost下挂载文件,修改配置文件和升级到1.15.12

```
   include vhost/*.conf;
```

```
version: '3'
services:
  nginx_createrepo:
    image: marksugar/nginx_createrepo:v0.3
    container_name: nginx_createrepo
    restart: always
    privileged: true
    network_mode: "host"
    volumes:
    - /data/mirrors:/data
    - /data/logs:/data/logs
    - /data/mirrors/wwwroot:/data/wwwroot
    - /etc/localtime:/etc/localtime:ro
    - /data/mirrors/footer.html:/tmp/footer.html
    - /data/mirrors/header.html:/tmp/header.html
    - /data/linuxea:/data/linuxea
    - /etc/nginx/vhost:/etc/nginx/vhost
    - /etc/nginx/cert:/etc/nginx/cert
    environment:
    - NGINX_PORT=443
    - SERVER_NAME=ftp.linuxea.com
    - USERNAME=marksugar
    - FTPPASSWD=MTU1NTgzNTA2Ngo
    - FTPDATA=/data/wwwroot
    - NGINX_PORT=80
    - WELCOME="welome to linuxea.com"
    logging:
      driver: "json-file"
      options:
        max-size: "1G"
```

