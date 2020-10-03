开始安装smokeping2.7.3
```
mkdir /data/
curl -Lks https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-smokeping/smokeping.tar.gz | tar xz -C /data/
```

nginx:

```
curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-nginx/nginx-1.15.10.tar.gz|tar xz -C /etc/
```

download vhost

```
curl -Lks https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-smokeping/smokeping.conf -o /etc/nginx/vhost/smokeping.conf 
```

* `htpasswd -bc /etc/nginx/passwd marksugar marksugar`
  *  yum install httpd-tools -y

docker-compose

```
curl -Lks https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-smokeping/docker-compose.yml -o /data/smokeping/docker-compose.yml
docker-compose -f /data/smokeping/docker-compose.yml up -d
```

FYI:

```
version: '2'
services:
  nginx:
    image: marksugar/nginx:1.18.0
    container_name: nginx
    restart: always
    network_mode: "host"
    volumes_from:
    - smokeping
    volumes:
    - /etc/nginx/:/etc/nginx/
    - /data/wwwroot:/data/wwwroot
    - /data/logs/:/data/logs/
    ports:
    - "40080:40080"
    - "8090:8090"
    depends_on:
      - smokeping
  smokeping:
    image: marksugar/smokeping:2.7.3
    container_name: smokeping
    network_mode: "host"
    restart: always
    volumes:
    - /data/smokeping:/usr/local/smokeping
    ports:
    - "9007:9007"
```

![1](https://github.com/marksugar/dockerMops/raw/master/docker-smokeping/img/daseboard.PNG)

