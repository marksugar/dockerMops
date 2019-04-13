#!/bin/sh
#########################################################################
# File Name: start.sh
# Author: www.linuxea.com
# Created Time: 2018年07月17日 星期二 14时13分02秒
#########################################################################
JAVAPATH=/data/java
JARNAME=$(echo `ls ${JAVAPATH}`|grep -o *.jar)
if [ ! -d ${JAVAPATH} ];then
	mkdir ${JAVAPATH} -p
fi

if [  $(ls /data/java/|grep -c *.jar) -gt 0 ];then 
	echo -e "\033[32mDid not find any jar package files\033[0m";
else
	cd ${JAVAPATH} && java -jar ${JARNAME};
fi
