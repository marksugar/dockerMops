#!/bin/sh
# www.linuxea.com
CONFIG_PATH="/etc/redis"
REDIS_CONF=${REDIS_CONF:-""}
MAXCLIENTS_NUM=${MAXCLIENTS_NUM:-""}
MAXMEMORY_SIZE=${MAXMEMORY_SIZE:-""}
MASTER_AUTH=${MASTER_AUTH:-""}
REQUIRE_PASS=${REQUIRE_PASS:-""}


#echo $REDIS_CONF $MAXCLIENTS_NUM $MAXMEMORY_SIZE $MASTER_AUTH
if [ -f ${CONFIG_PATH}/redis.conf ]; then
	echo "[i] Start configuration ${CONFIG_PATH}"
	echo -e "[ok] ${CONFIG_PATH}/redis.conf config ready"
	if [ "${REDIS_CONF}" = "on" ]; then
	echo -e "[ok] Start variable substitution REDIS_CONF=${REDIS_CONF}"
		if [ "${MAXCLIENTS_NUM}" != "" ]; then
			sed -i "s/maxclients.*/maxclients ${MAXCLIENTS_NUM}/g" ${CONFIG_PATH}/redis.conf
			echo -e "[ok] Replace the maxclients=${MAXCLIENTS_NUM} variable value"
		fi
		if [ "${MAXMEMORY_SIZE}" != "" ]; then
			sed -i "s/maxmemory .*/maxmemory ${MAXMEMORY_SIZE}/g" ${CONFIG_PATH}/redis.conf
			echo -e "[ok] Replace the maxmemory=${MAXMEMORY_SIZE} variable value"
		fi
		if [ "${REQUIRE_PASS}" != "" ]; then
			sed -i "s/requirepass.*/requirepass \"${REQUIRE_PASS}\"/g" ${CONFIG_PATH}/redis.conf
			echo -e "[ok] Replace the requirepass=${REQUIRE_PASS} variable value"
		fi
		if [ "${MASTER_AUTH}" != "" ]; then
			sed -i "s/masterauth.*/masterauth \"${MASTER_AUTH}\"/g" ${CONFIG_PATH}/redis.conf
			echo -e "[ok] Replace the masterauth=${MASTER_AUTH} variable value"
		fi	
		echo -e "[i] Start up /usr/local/bin/redis-server /etc/redis/redis.conf "
		exec /usr/local/bin/redis-server /etc/redis/redis.conf
	else
		echo -e "[i] If you want to use variables, please turn on REDIS_CONF=on"
		echo -e "[i] No variable substitution /etc/redis/redis.conf"
		echo -e "[i] Start up /usr/local/bin/redis-server /etc/redis/redis.conf"
		exec /usr/local/bin/redis-server /etc/redis/redis.conf
	fi
	  
else
	echo "${CONFIG_PATH}/redis.conf config not find"
fi
