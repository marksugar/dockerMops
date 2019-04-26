#!/bin/bash
#########################################################################
# File Name: entrypoint.sh
# Author: marksugar
# blog: www.linuxea.com
# Version:
# Created Time: 2019年04月23日 星期二 18时13分52秒
#########################################################################
PATHTOMCAT='/config/tomcat/conf'
GPORT=${GPORT:-8081}
sed -i "s/Connector port=\"8080\"/Connector port=\"${GPORT}\"/g" $PATHTOMCAT/server.xml  # 修改默认端口为 8081
sed -i 's/FINE/WARNING/g' $PATHTOMCAT/logging.properties  # 修改 log 等级为 WARNING
export LC_ALL=zh_CN.UTF-8
echo 'LANG="zh_CN.UTF-8"' > /etc/default/locale
exec supervisord  -n -c /etc/supervisor/supervisord.conf
