#!/bin/bash
#########################################################################
MSE=`ps aux|grep -v grep|grep -c /usr/local/maxscale/bin/maxscale`
MSEID=`ps aux|awk  '/maxscale/{print $2}'|awk NR==1`
MAXCON=/data/maxscale/maxscale.cnf
SVDPATH=/etc/supervisord.conf
if [ -f ${MAXCON} ]; then
	echo 'Maxscale Configuration File Already Exists /data/maxscale/maxscale.cnf '
else 
	echo 'Maxscale Configuration File is Downloading......'
	cd /data/maxscale && mkdir -p {data,cache,logs,tmp,pid} && mkdir -p logs/{binlog,trace}
	chown -R maxscale:maxscale /data/maxscale
	curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/maxscale/master/maxscale.cnf -o ${MAXCON}
fi	
if [ -f ${SVDPATH} ]; then
  echo 'supervisord Configuration File Already Exists /etc/supervisord.conf '
else
    echo 'Maxscale Process exists, has just been restarted'    
    curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/maxscale/master/conf/supervisord.conf -o ${SVDPATH}
fi
\rm -r /data/maxscale/pid/*
supervisord -n -c /etc/supervisord.conf
