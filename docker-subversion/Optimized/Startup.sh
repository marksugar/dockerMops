#!/bin/sh
#########################################################################
# File Name: Startup.sh
# Author: www.linuxea.com
# Email: admin#dwhd.org
# Version:
# Created Time: 2018年07月20日 星期五 14时53分14秒
#########################################################################
SPA=/data/docker/svn
if [ ! "$(ls -A $SPA)" ];then
	svnadmin create $SPA \
	&& sed -i  's/# anon-access = read/anon-access = none/g' $SPA/conf/svnserve.conf \
	&& sed -i  's/# password-db = passwd/password-db = passwd/g' $SPA/conf/svnserve.conf \
	&& sed -i  's/# auth-access = write/auth-access = write/g' $SPA/conf/svnserve.conf \
	&& sed -i  's/# realm = My First Repository/realm = web1/g' $SPA/conf/svnserve.conf \
	&& sed -i  's/# authz-db = authz/authz-db = authz/g' $SPA/conf/svnserve.conf \
	&& echo linuxea=mark >> $SPA/conf/passwd \
	&& curl -Lks4  https://raw.githubusercontent.com/LinuxEA-Mark/docker-subversion1.9.4/master/authz >> $SPA/conf/authz
fi
supervisord  -n -c /etc/supervisord.conf 
