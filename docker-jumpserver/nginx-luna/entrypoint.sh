#!/bin/sh
#########################################################################
# File Name: entrypoint.sh
# Author: marksugar
# blog: www.linuxea.com
# Version:
# Created Time: 2019年04月23日 星期二 18时13分52秒
#########################################################################
PATHNGINX='/etc/nginx/vhost/jumpserver.conf'

R_LISTEN=${R_LISTEN:-localhost:8080}
SERVER_NAME=${SERVER_NAME:-_}
SOCKER_DESCRIBE=${SOCKER_DESCRIBE:-localhost:5000}
COCO_DESCRIBE=${COCO_DESCRIBE:-localhost:5000}
GUACAMOLE_DESCRIBE=${GUACAMOLE_DESCRIBE:-localhost:8081}
LISTEN_PORT=${LISTEN_PORT:-80}

sed -i "s/R_LISTEN/${R_LISTEN}/g" $PATHNGINX
sed -i "s/SERVER_NAME/${SERVER_NAME}/g" $PATHNGINX
sed -i "s/SOCKER_DESCRIBE/${SOCKER_DESCRIBE}/g" $PATHNGINX
sed -i "s/COCO_DESCRIBE/${COCO_DESCRIBE}/g" $PATHNGINX
sed -i "s/GUACAMOLE_DESCRIBE/${GUACAMOLE_DESCRIBE}/g" $PATHNGINX
sed -i "s/LISTEN_PORT/${LISTEN_PORT}/g" $PATHNGINX

#export LC_ALL=zh_CN.UTF-8
#echo 'LANG="zh_CN.UTF-8"' > /etc/default/locale


exec supervisord  -n -c /etc/supervisord.conf
