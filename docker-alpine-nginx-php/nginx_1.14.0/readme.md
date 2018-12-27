Added in image respectively

[nginx-module-vts](https://github.com/vozlt/nginx-module-vts) and
[nginx-module-sts](https://github.com/vozlt/nginx-module-sts) and 
[nginx-module-stream-sts](https://github.com/vozlt/nginx-module-stream-sts) and 

[ngx_devel_kit_v0.3.1rc1](https://github.com/simplresty/ngx_devel_kit/archive/v0.3.1rc1.tar.gz) and 
[lua-nginx-module-v0.10.13](https://github.com/openresty/lua-nginx-module/archive/v0.10.13.tar.gz) and 
[LuaJIT-2.0.5](http://luajit.org/download/LuaJIT-2.0.5.tar.gz) as well as 
[nginx-1.14.0](http://nginx.org/download/nginx-1.14.0.tar.gz)

You can click on [Dockerfile](https://github.com/LinuxEA-Mark/docker-alpine-nginx-php/blob/master/nginx_1.14.0/Dockerfile) to view the details.

Quick installation：
```
curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-alpine-nginx-php/master/nginx_1.14.0/docker-compose-nginx_vts.yml -o $PWD/docker-compose-nginx_vts.yml && docker-compose -f $PWD/docker-compose-nginx_vts.yml  up -d
```

————————————Tips————————————

Key variables:
```
  - NGINXCONF=off
```
If - NGINXCONF=off means that the configuration file will not be copied to /etc/nginx. All the environment will fail, which is useful in many cases.

Then, his correct usage is that the first time you use - NGINXCONF=on, and then set to off, you can directly modify the file under the host /etc/nginx/.

Otherwise, the /etc/nginx file will be overwritten from the container each time.
————————————————————————————

There are three variables used, which are:
```
listen 80;
server_name localhost;
```
env:
```
listen ${NGINX_PORT};
server_name ${SERVER_NAME};
```

`fastcgi_pass 127.0.0.1:9001;` correspond `fastcgi_pass ${PHP_FPM_SERVER};`

Three variables will appear in the docker-commpose.yml file:
```
    environment:
      - NGINX_PORT=80
      - SERVER_NAME=www.linuxea.net
      - PHP_FPM_SERVER=127.0.0.1:9000
```

In order to make him run better, supervisord and inotifywait are used.

Supervisor started as a daemon

Inotifywait can capture directory information and make some effective operations

```
[program:nginx_1.14.0]
command=/bin/sh -c "exec /usr/local/nginx/sbin/nginx -g 'daemon off;'"
autostart=true
autorestart=false
startretries=0
stdout_events_enabled=true
stderr_events_enabled=true

[program:nginx_1.14.0_conf]
command=sh -c 'while inotifywait -q -r -e create,delete,modify,move,attrib --exclude "/\." /etc/nginx; do nginx -t && nginx -s reload; done'
autostart=true
autorestart=false
startretries=0
stdout_events_enabled=true
stderr_events_enabled=true
```
Finally, you should read the vts module to modify the nginx configuration file. The nginx configuration file will be mapped to the host /etc/nginx.
I hope useful to you

