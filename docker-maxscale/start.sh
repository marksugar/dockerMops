#!/bin/bash
MSE=`ps aux|grep -v grep|grep -c /usr/local/maxscale/bin/maxscale`
MSEID=`ps aux|awk  '/maxscale/{print $2}'|awk NR==1`
MAXCON=/data/maxscale/maxscale.cnf
if [ -f ${MAXCON} ]; then
	echo 'Maxscale Configuration File Already Exists /data/maxscale/maxscale.cnf '
else 
	echo 'Maxscale Configuration File is Downloading......'
	cd /data/maxscale && mkdir -p {data,cache,logs,tmp,pid} && mkdir -p logs/{binlog,trace}
	chown -R maxscale:maxscale /data/maxscale
	curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/maxscale/master/maxscale.cnf -o ${MAXCON}
fi	
if [ "${MSE}" -eq  "0" ]; then
    echo 'Maxscale Process Start Just Now ...... '
    /usr/local/maxscale/bin/maxscale -f ${MAXCON} --nodaemon
else
    echo 'Maxscale Process exists, has just been restarted'    
#    kill -9 ${MSEID} && /usr/local/maxscale/bin/maxscale -f ${MAXCON} --nodaemon
fi
