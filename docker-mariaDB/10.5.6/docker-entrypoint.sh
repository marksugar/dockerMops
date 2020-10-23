#!/bin/bash
#########################################################################
# File Name: docker-entrypoint.sh
# Author: www.linuxea.com
# Created Time: Thu Oct 22 04:50:24 EDT 2020
#########################################################################
USER_ID=${USER_ID:-306}
USER_NAME=${USER_NAME:-mysql}

echo "Starting with UID : $USER_ID And user $USER_NAME"
groupadd -r -g ${USER_ID} ${USER_NAME}
useradd -r -g ${USER_ID} -u ${USER_ID} ${USER_NAME}
export HOME=/home/$USER_NAME

#echo never > /sys/kernel/mm/transparent_hugepage/enabled

directory="/data/mariadb"
SQFILE="/SLQ"
MYSQL_DATABASE=${MYSQL_DATABASE:-""}
MYSQL_USER=${MYSQL_USER:-""}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}
ROTPASD="abc123"

set -e 
if [ "$1" = 'start-mariadb' ]; then
	if [ ! -d "/run/mysqld" ]; then
		mkdir -p /run/mysqld
		chown -R ${USER_NAME}:${USER_NAME} /run/mysqld
	fi
	if [ -d /data/mariadb/mysql ]; then
		echo '[i] MySQL directory already present, skipping creation ! Direct start'
		exec gosu  $USER_NAME  /usr/local/mysql/bin/mysqld_safe --defaults-file=/etc/my.cnf
	else
	
		echo "[i] create ${SQFILE}"
		cat << EOF > ${SQFILE}
			DELETE FROM mysql.user WHERE User='';
			DELETE FROM mysql.db WHERE Db LIKE 'test%';
			DROP DATABASE test;
                        ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROTPASD}';
EOF
	
		if [ "${MYSQL_DATABASE}" != "" ]; then
			echo "[i] Creating database: $MYSQL_DATABASE"
			echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> ${SQFILE}
		fi
		if [ "${MYSQL_USER}" != "" ]; then
			echo "[i] Creating user: $MYSQL_USER with password $MYSQL_PASSWORD"
			echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> ${SQFILE}
		fi

		echo "[i] MySQL data directory not found, creating initial DBs"
		echo 'Initializing database.......'
		
		chown ${USER_NAME}.${USER_NAME} /usr/local/mysql &&\
		/usr/local/mysql/scripts/mysql_install_db --user=${USER_NAME} --datadir=/data/mariadb --basedir=/usr/local/mysql > /dev/null && \
		#  mysql_install_db --user=mysql --datadir=${directory}  > /dev/null
		
		echo "[i] Initialize the root password ${ROTPASD} "
		echo "[i] run tempfile: ${SQFILE}"
		echo "flush privileges;"  >> ${SQFILE}
		# /usr/bin/mysqld --user=mysql --bootstrap --verbose=0 < ${SQFILE}
		#/usr/local/mysql/bin/mysqld --init-file=${SQFILE} --user=${USER_NAME} --verbose=0 --console
		/usr/local/mysql/bin/mysqld --init-file=${SQFILE} --user=${USER_NAME}  --console &
		#/usr/local/mysql/bin/mysql --defaults-extra-file=${SQFILE} --user=${USER_NAME}
		echo "[i] Sleeping 5 sec"
		sleep 5 
		rm -f ${SQFILE}
		echo '[i] start running mysqld'
		exec gosu  $USER_NAME  /usr/local/mysql/bin/mysqld_safe --defaults-file=/etc/my.cnf
	fi
fi
exec "$@"
