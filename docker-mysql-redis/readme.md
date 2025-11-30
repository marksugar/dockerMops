- install docker and docker-compose
curl -Lk https://github.com/marksugar/Maops/blob/master/docker-and-compose.sh | bash -s 2.40.3

- see init system linux AlmaLinux 9.4: ker.sh
- 
curl -Lk https://github.com/marksugar/dockerMops/blob/master/docker-mysql-redis/ker.sh | bash

- see docker-mysql-redis: 

mkdir -p /data/mysql/{data,file}  /data/redis/db
curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/refs/heads/master/docker-mysql-redis/docker-compose.yaml >> /data/docker-compose.yaml
curl  https://raw.githubusercontent.com/marksugar/dockerMops/refs/heads/master/docker-mysql-redis/my.cnf >> /data/mysql/my.cnf
curl  https://raw.githubusercontent.com/marksugar/dockerMops/refs/heads/master/docker-mysql-redis/redis.conf >> /data/redis/redis.conf
