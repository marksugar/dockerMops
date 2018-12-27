#!/bin/sh
USRPATH=/usr/local
OPTPATH=/opt/java
TOMCATH=/usr/local/tomcat/webapps
JAR_XMX=${JAR_XMX:-""}
JAR_XMS=${JAR_XMS:-""}

if [ ! `ls ${OPTPATH}/*.jar` ];then 
	echo "[info] No jar package, Ready to start tomcat"
	 if [ ! `ls -A ${TOMCATH}` ];then 
		echo "[err]Please hang war under /usr/local/tomcat/webapps"
		echo "[err]Or, hang jar packages under /opt/java"
		exit 1;
	else
		echo "[ok] tomcat start"
		supervisord  -n -c /etc/supervisord.conf
	fi
else
	echo "[info] No tomcat file, Ready to start jar"
	echo "[ok] start jar"
#	cd ${OPTPATH} && java -jar *.jar -server -XX:-UseGCOverheadLimit -Xmx${JAR_XMX}m -Xms${JAR_XMS}m -verbose:gc -XX:+PrintGCDetails -XX:+HeapDumpOnOutOfMemoryError -XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:+UseCMSCnly -XX:CMSInitiatingOccupancyFraction=70  --logging.config=./logback.xml
	cd ${OPTPATH} && java -jar *.jar -server -XX:-UseGCOverheadLimit -Xmx${JAR_XMX}m -Xms${JAR_XMS}m -verbose:gc -XX:+PrintGCDetails -XX:+HeapDumpOnOutOfMemoryError -XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:+UseCMSCnly -XX:CMSInitiatingOccupancyFraction=70
fi
