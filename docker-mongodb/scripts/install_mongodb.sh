#!/bin/bash
########################################################################
# Author: www.linuxea.com
# Email: admin#dwhd.org
# Version:
# Created Time: 2018年07月05日 星期四 18时53分06秒
#########################################################################
MONGO_NAME=mongodb-linux-x86_64
MONGO_CONF="https://raw.githubusercontent.com/LinuxEA-Mark/docker-mongodb/master/scripts/mongodb.conf"
MONGO_CONF_DIR=/usr/local/mongodb/conf
MONGO_LOGS_DIR=/usr/local/mongodb/logs
VERSION_MONGO="rhel70-4.0.0"
if [ ! -n "`grep mongodb /etc/passwd`" ];then 
  echo -e "\033[32madd mongodb user,create mongodb dir\033[0m"
  groupadd -r mongodb && mkdir /data/mongodb -p && useradd -M -r -g mongodb -d /data/mongodb/ -s /bin/false -c mongodb mongodb; 
else
  echo -e "\033[32mmongodb user exist\033[0m";
fi
 
if [ ! -n "`rpm -q axel`" ];then 
  echo -e "\033[32minstall axel now....\033[0m"
  clear
  yum install epel* -y \
  yum install axel -y;
else
  echo -e "\033[32maxel exist...\033[0m"
fi
clear
echo -e "\033[32mdownload ${MONGO_NAME}-${VERSION_MONGO} now....\033[0m"
sleep 1
cd /usr/local && axel -n 40 https://fastdl.mongodb.org/linux/${MONGO_NAME}-${VERSION_MONGO}.tgz
echo -e "\033[32mmongodb configure now....\033[0m"
tar xf ${MONGO_NAME}-${VERSION_MONGO}.tgz && ln -s ${MONGO_NAME}-${VERSION_MONGO} mongodb
echo "export PATH=/usr/local/mongodb/bin:\$PATH" >> /etc/profile && source /etc/profile
if [ ! -d ${MONGO_CONF_DIR} ];then
  echo -e "\033[32mmongodb mongodb.conf download now....\033[0m"
  mkdir -p ${MONGO_LOGS_DIR} && mkdir -p ${MONGO_CONF_DIR}
else
  echo "${MONGO_CONF_DIR} exist";
fi  
if [ ! "$(ls -A ${MONGO_CONF_DIR})" ];then
   curl -Lk ${MONGO_CONF} -o ${MONGO_CONF_DIR}/mongodb.conf &&  chown mongodb -R /data/mongodb/ /usr/local/mongodb;
else
  echo "${MONGO_CONF_DIR} mongodb.conf exist"
fi
mongod -f /usr/local/mongodb/conf/mongodb.conf
