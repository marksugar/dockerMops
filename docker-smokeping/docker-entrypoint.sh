#!/bin/bash
#########################################################################
# File Name: docker-entrypoint.sh
# Author: www.linuxea.com
# Created Time: 2020-09-30-21:22:43
#########################################################################
set -e
if [ "$1" = 'smokepingrun' ]; then
    chown -R www.www /usr/local/smokeping/htdocs/
    if [ ! -z "$(ls -A "/usr/local/smokeping/htdocs/smokeping.fcgi")" ]; then
        spawn-fcgi -a 127.0.0.1 -p 9007 -P /var/run/smokeping-fastcgi.pid -u www -f /usr/local/smokeping/htdocs/smokeping.fcgi
    fi
    exec smokeping --nodaemon --config=/usr/local/smokeping/etc/config --logfile=/usr/local/smokeping/log/smokeping.log "$@"
fi
exec "$@"