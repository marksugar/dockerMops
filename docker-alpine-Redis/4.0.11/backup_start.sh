#!/bin/sh
###############################################################################################################################
# If you don't set the memory size, it will automatically be set to 80% of the host memory.                                   #
# If MAXMEMORY_SIZE is equal to off, the automatic setting will be turned off                                                 #
# Then you need to pass in the MAXMEMORY_SIZE = value, or hang in the configuration file                                      #
# About MAXCLIENTS_NUM REQUIREPASSWD MASTERAUTHPAD you need to specify how much or equal to modify in the configuration file  #
###############################################################################################################################
mv /opt/redis.* /etc/redis/
export MAXMEMORY_SIZE=`echo "expr $(($(awk '/MemTotal/{print $2}' /proc/meminfo)*88/102400))"|awk '{print $2}'`
#if [ `env |grep MAXMEMORY_SIZE=off|wc -l` -ne 0 ];then unset MAXMEMORY_SIZE; fi
if [ `env |grep REDIS_CONF=on|wc -l` -ne 0 ];then envsubst < /etc/redis/redis.env > /etc/redis/redis.conf; fi
#if [ `env |grep MAXCLIENTS_NUM|wc -l` -ne 0 ];then envsubst '${MAXCLIENTS_NUM}' < /etc/redis/redis.env > /etc/redis/redis.conf; fi
#if [ `env |grep MAXMEMORY_SIZE|wc -l` -ne 0 ];then envsubst '${MAXMEMORY_SIZE}' < /etc/redis/redis.env > /etc/redis/redis.conf; fi
#if [ `env |grep REQUIREPASSWD|wc -l` -ne 0 ];then envsubst '${REQUIREPASSWD}' < /etc/redis/redis.env > /etc/redis/redis.conf; fi
#if [ `env |grep MASTERAUTHPAD|wc -l` -ne 0 ];then envsubst '${MASTERAUTHPAD}' < /etc/redis/redis.env > /etc/redis/redis.conf; fi
supervisord  -n -c /etc/supervisord.conf 
