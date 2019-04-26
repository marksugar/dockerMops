#!/bin/sh
directory="/data/mariadb"
SQFILE="/SLQ"
MYSQL_DATABASE=${MYSQL_DATABASE:-""}
MYSQL_USER=${MYSQL_USER:-""}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}
ROTPASD="abc123"
if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi
if [ -d /data/mariadb/mysql ]; then
    echo '[i] MySQL directory already present, skipping creation ! Direct start'
    /usr/bin/mysqld_safe --defaults-file=/etc/my.cnf
else

echo "[i] create ${SQFILE}"
cat << EOF > ${SQFILE}
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db LIKE 'test%';
DROP DATABASE test;
UPDATE mysql.user SET password = password('${ROTPASD}') WHERE user = 'root';
EOF


    echo "[i] MySQL data directory not found, creating initial DBs"
    echo 'Initializing database.......'
    mysql_install_db --user=mysql --datadir=${directory}  > /dev/null
	if [ ${MYSQL_DATABASE} != "" ]; then
	    echo "[i] Creating database: $MYSQL_DATABASE"
	    echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> ${SQFILE}

	    if [ ${MYSQL_USER} != "" ]; then
		echo "[i] Creating user: $MYSQL_USER with password $MYSQL_PASSWORD"
		echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> ${SQFILE}
		echo "flush privileges;"  >> ${SQFILE}
	    fi
	fi
    echo "[i] Initialize the root password ${ROTPASD} "
    echo "[i] run tempfile: ${SQFILE}"
#    /usr/bin/mysqld --user=mysql --bootstrap --verbose=0 < ${SQFILE}
	/usr/bin/mysqld --init-file=${SQFILE} --user=mysql --verbose=0
fi
echo "[i] Sleeping 5 sec"
sleep 5

rm -f ${SQFILE}
echo '[i] start running mysqld'
#exec /usr/bin/mysqld --user=mysql --console
exec /usr/bin/mysqld_safe --defaults-file=/etc/my.cnf
