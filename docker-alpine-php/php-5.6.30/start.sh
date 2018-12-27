#!/bin/sh
#########################################################################
# File Name: mem.sh
# Email: admin@linuxea.com
# Version: www.linuxea.com
# Created Time: 2017年06月24日 星期六 21时46分30秒
#########################################################################
PHPD="/usr/local/php/etc/php.d"
MODU="/usr/local/php/etc/php.d/php_module.ini"
DEBU="/usr/local/php/etc/php.d/xdebug.ini"
MEME="/usr/local/php/etc/pp.conf"
PHPF="/usr/local/php/etc/php-fpm.conf"
## mkdir php.d
[ -d ${PHPD} ] || mkdir ${PHPD} -p
##自动配置内存大小
INIF=/usr/local/php/etc/php.ini
#sed  -i "s@memory_limit = 128M@memory_limit = $(awk '/MemTotal/ {printf("%d\n", $2/4/1024)}' /proc/meminfo)M@g" ${INIF}
#local Environment variable php_modu.env and php_module.ini 
if [ ! -f ${PHPD}/php_module.env ];then
	echo -e "extension=\${ENABLED_REDIS}\nextension=\${ENABLED_MEMCACHED}\nextension=\${ENABLED_XDEBUG}\nextension=\${ENABLED_SWOOLE}\nmemory_limit=\${MEM_LIMIT}" > ${PHPD}/php_module.env
#	echo -e "extension=\${ENABLED_REDIS}\nextension=\${ENABLED_MEMCACHED}\nextension=\${ENABLED_XDEBUG}\nextension=\${ENABLED_SWOOLE}\nmemory_limit=\${MEM_LIMIT}" > ${PHPD}/php_module.env
fi
if [ ! -f ${PHPD}/php-configuration.env ];then
    echo -e "chdir = \${CHDIR}\nlisten = \${LISTEN}\nlisten.backlog = \${LISTEN_BACKLOG}\nlisten.owner = \${LISTEN_OWNER}\nlisten.group = \${LISTEN_GROUP}\nlisten.mode = \${LISTEN_MODE}\nuser = \${USER}\ngroup = \${GROUP}\npm = \${PM}\npm.max_children = \${PM_MAX_CHILDREN}\npm.start_servers = \${PM_START_SERVERS}\npm.min_spare_servers = \${PM_MIN_SPARE_SERVERS}\npm.max_spare_servers = \${PM_MAX_SPARE_SERVERS}\npm.max_requests = \${PM_MAX_REQUESTS}\npm.process_idle_timeout = \${PM_PROCESS_IDLE_TIMEOUT}\nrequest_terminate_timeout = \${REQUEST_TERMINATE_TIMEOUT}\nrequest_slowlog_timeout = \${REQUEST_SLOWLOG_TIMEOUT}" > ${PHPD}/php-configuration.env
fi
if [ ! -f ${MODU} ];then
cat > ${MODU} << EOF
extension=/usr/local/php/lib/php/20131226/memcached.so
extension=/usr/local/php/lib/php/20131226/redis.so
extension=/usr/local/php/lib/php/20131226/xdebug.so
extension=/usr/local/php/lib/php/20131226/swoole.so
memory_limit=128M
expose_php = On
EOF
fi
#local down php-xdebug
if [ ! -f ${DEBU} ];then
cat > ${DEBU} << EOF
zend_extension = "xdebug.so"
xdebug.remote_enable = On
;远程调试开关
xdebug.remote_handler = "dbgp"
;;官方文档说从xdebug2.1以后的版本只支持dbgp这个协议
xdebug.remote_host = "10.10.0.98"
;;远程调试xdebug回连的主机ip，如果开启了remote_connect_back，则该配置无效
xdebug.remote_port = 9000
;;远程调试回连的port，默认即为9000，如果有端口冲突，可以修改，对应ide的debug配置里面也要同步修改
xdebug.remote_connect_back = 1
;;是否回连，如果开启该选项，那么xdebug回连的ip会是发起调试请求对应的ip
xdebug.auto_trace = on
;;当此设置被设置为on，函数调用跟踪将要启用的脚本运行之前。这使得有可能跟踪代码中的auto_prepend_file。
xdebug.auto_profile = on
xdebug.collect_params = on
xdebug.collect_return = on
xdebug.profiler_enable = off
xdebug.trace_output_dir = "/tmp"
xdebug.profiler_output_dir = "/tmp"
xdebug.dump.GET = *
xdebug.dump.POST = *
xdebug.dump.COOKIE = *
xdebug.dump.SESSION = *
xdebug.var_display_max_data = 4056
xdebug.var_display_max_depth = 5
;;xdebug.idekey=netbeans
;;调试使用的关键字，发起IDE上的idekey应该和这里配置的idekey一致，不一致则无效
EOF
fi
#load config php 
if [ ! -f ${MEME} ];then
cat > ${MEME} << EOF
chdir = /data/wwwroot
listen = 9000
listen.backlog = -1
listen.owner = www
listen.group = www
listen.mode = 0777
user = www
group = www
pm = dynamic
pm.max_children = 12
pm.start_servers = 6
pm.min_spare_servers = 2
pm.max_spare_servers = 10
pm.max_requests = 2048
pm.process_idle_timeout = 10s
request_terminate_timeout = 120
request_slowlog_timeout = 0
EOF
fi
if [ ! -f ${PHPF} ];then
cat > ${PHPF} << EOF
[global]
pid = run/php-fpm.pid
error_log = /data/logs/php-fpm.log
log_level = warning
emergency_restart_threshold = 30
emergency_restart_interval = 60s
process_control_timeout = 5s
daemonize = yes
[php]
include=/usr/local/php/etc/pp.conf
;listen = /dev/shm/php-cgi.sock
;Come from www.linuxea.com for mark
;listen.allowed_clients = 127.0.0.1
pm.status_path = /php-fpm_status
slowlog = /data/logs/slow.log
rlimit_files = 51200
rlimit_core = 0
catch_workers_output = yes
;env[HOSTNAME] = $HOSTNAME
env[PATH] = /usr/local/bin:/usr/bin:/bin
env[TMP] = /tmp
env[TMPDIR] = /tmp
env[TEMP] = /tmp
EOF
fi
envsubst < ${PHPD}/php_module.env  > ${MODU} && envsubst < ${PHPD}/php-configuration.env > ${MEME} 
if [ `env |grep "DISABLED_REDIS=yes"` > /dev/null ];then 
	sed -i 's/extension=redis.so/;extension=redis.so/g' ${MODU}
else
	echo  "`date +%F-%r` ENABLED_REDIS is ENABLED!"
fi
if [ `env |grep "DISABLED_MEMCACHE=yes"` > /dev/null ];then 
	sed -i 's/extension=memcached.so/;extension=memcached.so/g' ${MODU}
else
	echo  "`date +%F-%r` ENABLED_MEMCACHE is ENABLED!"
fi
if [ `env |grep "DISABLED_SWOOLE=yes"` > /dev/null ];then 
	sed -i 's/extension=swoole.so/;extension=swoole.so/g' ${MODU}
else
	echo  "`date +%F-%r` ENABLED_SWOOLE is ENABLED!"
fi
if [ `env |grep "DISABLED_XDEBUG=yes"` > /dev/null ];then 
	sed -i 's/extension=xdebug.so/;extension=xdebug.so/g' ${MODU} 
else
	 echo  "`date +%F-%r` ENABLED_XDEBUG is ENABLED!"
fi
if [ `ps aux|grep php &> /dev/null` ]; then
	echo "`date +%F-%r` php is running..."
else
	/usr/local/php/sbin/php-fpm --nodaemonize
fi
