#!/bin/bash
#########################################################################
# File Name: check_SECRET-TOKEN.sh
# Author: www.linuxea.com
# Email: marksugar
# Created Time: 2019年04月25日 星期四 15时17分23秒
#########################################################################

COMPOSEFILE='/data/docker-compose.yml'
SECRET_KEY=`cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 50`
BOOTSTRAP_TOKEN=`cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 16`
sed -i "s/BOOTSTRAP_TOKEN=.*/BOOTSTRAP_TOKEN=${BOOTSTRAP_TOKEN}/g" $COMPOSEFILE
sed -i "s/SECRET_KEY=.*/SECRET_KEY=${SECRET_KEY}/g" $COMPOSEFILE

TOKENV=`awk -F= '/BOOTSTRAP_TOKEN/{print $2;exit}' $COMPOSEFILE`
SECRETV=`awk -F= '/SECRET_KEY/{print $2}' $COMPOSEFILE`
if [ "$BOOTSTRAP_TOKEN" == "${TOKENV}" ];then 
  echo -e "\n\033[32m [i] BOOTSTRAP_TOKEN Consistent configuration. \033[0m";
else 
  echo -e "\033[31m\033[01m\n[ERR] Please check the >BOOTSTRAP_TOKEN< value. \033[0m";
fi
if [ "$SECRET_KEY" == "${SECRETV}" ];then 
  echo -e "\n\033[32m [i] SECRET_KEY Consistent configuration. \033[0m";
else 
  echo -e "\033[31m\033[01m\n[ERR] Please check the >SECRET_KEY< value. \033[0m";
fi
