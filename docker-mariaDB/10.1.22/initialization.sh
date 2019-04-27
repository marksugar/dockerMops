#!/bin/bash

# if the /mydata/data directory doesn't contain anything, then initialise it
directory="/data/mysql"
if [ "$(ls -A $directory)" ]; then
        /usr/local/mysql/bin/mysqld_safe
else
        /usr/local/mysql/scripts/mysql_install_db --user=mysql --datadir=/data/mysql/ --basedir=/usr/local/mysql
        /usr/local/mysql/bin/mysqld --user=mysql --datadir=/data/mysql --basedir=/usr/local/mysql --init-file=/initialization.sql
        #/usr/local/mysql/bin/mysql < /initialization.sql
        #/usr/local/mysql/bin/mysql --init-file=/initialization.sql
fi
