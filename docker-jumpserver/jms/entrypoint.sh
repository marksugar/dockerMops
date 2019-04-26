#!/bin/bash
#########################################################################
# File Name: entrypoint.sh
# Author: marksugar
# blog: www.linuxea.com
# Version:
# Created Time: 2019年04月23日 星期二 18时13分52秒
#########################################################################

if [ ! -f "/opt/jumpserver/config.yml" ]; then
    cp /opt/jumpserver/config_example.yml /opt/jumpserver/config.yml
    sed -i "s/SECRET_KEY:/SECRET_KEY: $SECRET_KEY/g" /opt/jumpserver/config.yml
    sed -i "s/BOOTSTRAP_TOKEN:/BOOTSTRAP_TOKEN: $BOOTSTRAP_TOKEN/g" /opt/jumpserver/config.yml
    sed -i "s/# DEBUG: true/DEBUG: false/g" /opt/jumpserver/config.yml
    sed -i "s/# LOG_LEVEL: DEBUG/LOG_LEVEL: ERROR/g" /opt/jumpserver/config.yml
    sed -i "s/# SESSION_EXPIRE_AT_BROWSER_CLOSE: false/SESSION_EXPIRE_AT_BROWSER_CLOSE: true/g" /opt/jumpserver/config.yml
    sed -i "s/DB_HOST: 127.0.0.1/DB_HOST: $DB_HOST/g" /opt/jumpserver/config.yml
    sed -i "s/DB_PORT: 3306/DB_PORT: $DB_PORT/g" /opt/jumpserver/config.yml
    sed -i "s/DB_USER: jumpserver/DB_USER: $DB_USER/g" /opt/jumpserver/config.yml
    sed -i "s/DB_PASSWORD: /DB_PASSWORD: $DB_PASSWORD/g" /opt/jumpserver/config.yml
    sed -i "s/DB_NAME: jumpserver/DB_NAME: $DB_NAME/g" /opt/jumpserver/config.yml
    sed -i "s/REDIS_HOST: 127.0.0.1/REDIS_HOST: $REDIS_HOST/g" /opt/jumpserver/config.yml
    sed -i "s/REDIS_PORT: 6379/REDIS_PORT: $REDIS_PORT/g" /opt/jumpserver/config.yml
    sed -i "s/# REDIS_PASSWORD: /REDIS_PASSWORD: $REDIS_PASSWORD/g" /opt/jumpserver/config.yml
fi
export LC_ALL=zh_CN.UTF-8
echo 'LANG="zh_CN.UTF-8"' > /etc/default/locale

source /opt/py3/bin/activate
exec ./jms start all
