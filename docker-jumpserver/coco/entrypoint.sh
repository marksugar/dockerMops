#!/bin/bash
#########################################################################
# File Name: entrypoint.sh
# Author: marksugar
# blog: www.linuxea.com
# Version:
# Created Time: 2019年04月23日 星期二 18时13分52秒
#########################################################################
if [ ! -f "/opt/coco/config.yml" ]; then
    cp /opt/coco/config_example.yml /opt/coco/config.yml
    sed -i "s/BOOTSTRAP_TOKEN: <PleasgeChangeSameWithJumpserver>/BOOTSTRAP_TOKEN: $BOOTSTRAP_TOKEN/g" /opt/coco/config.yml
    sed -i "s/# LOG_LEVEL: INFO/LOG_LEVEL: ERROR/g" /opt/coco/config.yml
fi
source /opt/py3/bin/activate
export LC_ALL=zh_CN.UTF-8
echo 'LANG="zh_CN.UTF-8"' > /etc/default/locale
exec ./cocod start
