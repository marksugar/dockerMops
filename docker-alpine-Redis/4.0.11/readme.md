Precautions for use:

In the [image](https://hub.docker.com/r/marksugar/redis/tags/) MAXMEMORY has done [automatic allocation of 90% of the host memory](https://github.com/marksugar/dockerMops/blob/master/docker-alpine-Redis/4.0.11/startup.sh)

In the environment of [docker-compose](https://github.com/marksugar/dockerMops/blob/master/docker-alpine-Redis/4.0.11/docker-compose-redis-4-0-11.yml)

When running for the first time, you need to set REDIS_CONF to on, which will automatically map the configuration file to the host, which is critical.

Of course, you can set it to off, which means you can modify [/etc/redis/redis.conf](https://github.com/marksugar/dockerMops/blob/master/docker-alpine-Redis/4.0.11/redis.conf) arbitrarily.

Please make sure your [/etc/redis/redis.conf](https://github.com/marksugar/dockerMops/blob/master/docker-alpine-Redis/4.0.11/redis.conf) exists. If not, please download it on this page.


[docker-compose info](https://github.com/marksugar/dockerMops/blob/master/docker-alpine-Redis/4.0.11/docker-compose-redis-4-0-11.yml):
```
    Environment:
     - REDIS_CONF=on
     - REQUIREPASSWD=OTdmOWI4ZTM4NTY1M2M4OTZh
     - MASTERAUTHPAD=OTdmOWI4ZTM4NTY1M2M4OTZh
     - MAXCLIENTS_NUM=600
     - MAXMEMORY_SIZE=4096
```

In compose you can see the details of the build, depending on the [Dockerfile](https://github.com/marksugar/dockerMops/blob/master/docker-alpine-Redis/4.0.11/Dockerfile). Of course, you can use image or you can customize it yourself with [Dockerfile](https://github.com/marksugar/dockerMops/blob/master/docker-alpine-Redis/4.0.11/Dockerfile).

centos install :

curl -Lk https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-alpine-Redis/4.0.11/install_redis_4.0.11.sh|bash
