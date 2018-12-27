## install 

curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-haproxy1.6.5/master/create_docker_haproxy.sh |bash

## build && run
* [root@LinuxEA haproxy]#  docker build -t haproxy1.6.5 .
* [root@LinuxEA haproxy]#  docker run --name haproxy1 --network=host -v /root/haproxy/haproxy.cfg:/etc/haproxy/haproxy.cfg -it -p 80:80 -p 1080:1080 haproxy1.6.5

## 日志开启

```
[root@LinuxEA haproxy]# vim /etc/rsyslog.conf 
$ModLoad imudp
$UDPServerRun 514
local3.*                                              /var/log/haproxy.log
*.info;mail.none;authpriv.none;cron.none;local3.none    /var/log/messages
[root@LinuxEA haproxy]# vim /etc/sysconfig/rsyslog 
SYSLOGD_OPTIONS="-r -m  0 -c 2"
[root@LinuxEA haproxy]# systemctl restart rsyslog.service
```
haproxy使用的是rsyslog记录日志，如果对外的ha可能存在丢失日志，不建议开启日志

## 健康检查

健康检查4层和七层

```
backend backend-webgroup.com

        option forwardfor header X-REALL-IP
        option httpchk HEAD / HTTP/1.0 #HEAD POST GET
        balance roundrobin #source
        server web-node1 10.10.239.194:80 check inter 2000 rise 30 fall 15
        server web-node2 10.10.239.185:80 check inter 2000 rise 30 fall 15
```
`option forwardfor header X-REALL-IP`和`option httpchk HEAD / HTTP/1.0`是7层的监控检测，当注释掉后就是基于ip的健康检查，变成4层健康检查

option httpchk HEAD / HTTP/1.0 :

其中option httpchk是固定关键字，head是状态，可以为post，get， / 为根，通常是具体的url链接，能够证明网站是存活的页面。http/1.0协议，在七层健康检查中的stats页面中是可以看到状态码的

## 七层负载

acl url_static path_beg /static /images /img /css

比如说我在前端添加
```
frontend frontend-web.com
        bind *:80
        mode http
        option httplog
        log global
        
        acl url_static path_beg /static
        default_backend app
        
        default_backend backend-webgroup.com
```

只要是url是static的都会转发到后端app主机上
```
backend app
#       option forwardfor header X-REALL-IP
#       option httpchk HEAD / HTTP/1.0
        balance roundrobin #source
        server web-node1 appIP:80 check inter 2000 rise 30 fall 15
        server web-node2 appIP:80 check inter 2000 rise 30 fall 15
```

正则:

所有以css|js|jpg|png|jpeg|gif格式的文件都发往后端app_head

```
frontend frontend-web.com
        bind *:80
        mode http
        option httplog
        log global
        
        acl url_static url_reg /*.(css|js|jpg|png|jpeg|gif)
        default_backend app_head
        
        default_backend backend-webgroup.com
```

如果要切换4层，只需要修改frontend中的mode tcp即可，注释其他http选项即可，我们也可以使用`tcpdump 'port 80' -i eth0 -n -S`

## 后端真实ip

在haproxy中需要使用http

`option forwardfor header X-REALL-IP` #获取后端ip

在nginx中
```
server {

        listen          80;
        server_name localhost;
        location / {
            root  /data/nginx/wwwroot;
            index index.php index.html index.htm;
            set_real_ip_from 10.10.242.23;
            real_ip_header X-Real-IP;
        }
```
```
     log_format  access  '$remote_addr - $remote_user [$time_local] "$request" '
      '$status $body_bytes_sent "$http_referer" '
      '"$http_user_agent" $http_x_forwarded_for';
```

重载后，在后端nginx中即可查看：
```
10.10.242.23 - - [19/Nov/2016:16:53:08 +0000] "GET / HTTP/1.1" 200 61397 "-" "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.87 Safari/537.36"
10.10.239.240 - - [19/Nov/2016:16:53:15 +0000] "GET /?p=300 HTTP/1.1" 200 18498 "http://10.10.242.23/" "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.87 Safari/537.36"
```

tomcat日志：

常见：pattern="%h %{X-REAL-IP}i %1 %u %t %quot; %s %b"

- **常见的** -`%h %l %u %t "%r" %s %b`
- **结合** - `%h %l %u %t "%r" %s %b "%{Referer}i" "%{User-Agent}i"`

也支持cookie,传入头部，session其他
- `%{xxx}i` 传入头
- `%{xxx}o` 传出响应头
- `%{xxx}c` 对于特定的cookie
- `%{xxx}r` xxx是在ServletRequest中的一个属性
- `%{xxx}s` xxx是在HttpSession中的一个属性
   还有其他
- **％A** -远程IP地址
- **％A** -本地IP地址
- **％B** -发送的字节数，不包含HTTP头，或“ - ”如果没有字节发送
- **％B** -发送的字节数，不包含HTTP头
- **％H** -远程主机名
- **％H** -请求协议
- **％L** -从identd的远程逻辑用户名（总是返回' - '）
- **％M** -请求方法
- **％P** -本地端口
- **％Q** -查询字符串（前面加上了，如果它存在，否则一个空字符串“？”
- **％R** -请求的第一行
- **％S** -响应的HTTP状态代码
- **％S** -用户会话ID
- **％T** -日期和时间，公共日志格式格式
- **％U** -远程用户被验证
- **％U** -请求的URL路径
- **％V** -本地服务器名称
- **％D** -所需的时间来处理请求，米利斯
- **％T** -所需要的时间处理该请求，在几秒钟内
- **％I** -当前请求的线程名称（可与踪迹后比较）

具体我们参考：http://www.docjar.org/docs/api/org/apache/catalina/valves/AccessLogValve.html

## 平滑在线修改

我们在配置文件的global中添加如下

    stats socket /tmp/haproxy.sock mod 600 level admin 
    stats timeout 2m

[root@LinuxEA haproxy]# yum install socat -y

使用帮助：`echo "help" |socat stdio /tmp/haproxy.sock`

查看info信息：`echo "show info" |socat stdio /tmp/haproxy.sock`

查看内部池：`echo "show pools" |socat stdio /tmp/haproxy.sock`

查看状态信息：`echo "show stat" |socat stdio /tmp/haproxy.sock`

最大文件数：set maxconn

server 状态和权值：set server

disable：关闭

enable：启动

 我们关闭一个后端的server

`[root@LinuxEA /]# echo "disable server backend-webgroup.com/web-node2 " |socat stdio /tmp/haproxy.sock `

关闭后颜色会变成棕色。打开enable即可
## 缓解time_wait

### 缩短time_wait时间

[root@LinuxEA haproxy]# cat /proc/sys/net/ipv4/tcp_fin_timeout
60
[root@LinuxEA haproxy]# echo 30 > /proc/sys/net/ipv4/tcp_fin_timeout
[root@LinuxEA haproxy]# cat /proc/sys/net/ipv4/tcp_fin_timeout
30
[root@LinuxEA haproxy]# 

永久生效，修改sysctl.conf

### 快速回收和重用

快速回收和重用设置为1，tcp_tw_recycle 在nat的方式中可能存在一些问题

[root@LinuxEA haproxy]# cat /proc/sys/net/ipv4/tcp_tw_reuse 
0
[root@LinuxEA haproxy]# cat /proc/sys/net/ipv4/tcp_tw_recycle 
0
[root@LinuxEA haproxy]# echo 1 > /proc/sys/net/ipv4/tcp_tw_recycle 
[root@LinuxEA haproxy]# echo 1 > /proc/sys/net/ipv4/tcp_tw_reuse 

### 修改端口范围

修改本地端口范围：1024 65000

[root@LinuxEA haproxy]# cat /proc/sys/net/ipv4/ip_local_port_range 
32768   61000

### 添加多ip

如果有多个ip就意味着有更多个tcp端口（多个ip的随机端口/source）

```
[root@LinuxEA ~]# ip addr add 10.10.242.24 dev eno16777736
[root@LinuxEA ~]# ip addr show eno16777736
2: eno16777736: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000

    link/ether 00:0c:29:68:59:1f brd ff:ff:ff:ff:ff:ff
    inet 10.10.242.23/16 brd 10.10.255.255 scope global dynamic eno16777736
       valid_lft 4866sec preferred_lft 4866sec
    inet 10.10.242.24/32 scope global eno16777736
       valid_lft forever preferred_lft forever
```

在haproxy中配置回援,10.10.242.24这里是dip，如果超过66535则可以如下配置`server web-node1 10.10.239.194:80 check source 10.10.242.24:1025-65000  inter 2000 rise 30 fall 15`

`[root@LinuxEA ~]# watch 'ss -na|grep 10.10.242.24'`
你会发现10.10.242.24会出现
