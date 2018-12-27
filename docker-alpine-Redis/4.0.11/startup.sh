#!/bin/sh
# File Name: startup.sh
# Author: www.linuxea.com
# Created Time: 2018年08月11日 星期六 21时46分20秒
########################################################################################
# If REDIS_CONF=on replaces the passed variable:                                       #
#     - REQUIREPASSWD                                                                  #
#     - MASTERAUTHPAD                                                                  #
#     - MAXCLIENTS_NUM                                                                 #
#     - MAXMEMORY_SIZE                                                                 #
# If equal to REDIS_CONF=off, you can use the /etc/redis/redis.conf configuration file.#
########################################################################################
export MAXMEMORY_SIZE=`echo "expr $(($(awk '/MemTotal/{print $2}' /proc/meminfo)*88/102400))"|awk '{print $2}'`
if [ `env |grep REDIS_CONF=on|wc -l` -ne 0 ];then envsubst < /opt/redis.env > /etc/redis/redis.conf; fi
supervisord  -n -c /etc/supervisord.conf 
