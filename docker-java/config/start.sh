#!/bin/bash
# Created Time: Wed 17 Oct 2018 05:28:15 PM CST
#########################################################################

cd ${RUN_JAR_DIR}
JAVA_OPTS=${JAVA_OPTS:--Duser.timezone=Asia/Shanghai}
JDK_OPTS="-server -Xmx2g -Xms2g -Xmn256m -XX:PermSize=128m -Xss256k"
JDK_OPTS="${JDK_OPTS} -XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:+UseCMSCompactAtFullCollection"
JDK_OPTS="${JDK_OPTS} -XX:LargePageSizeInBytes=128m -XX:+UseFastAccessorMethods -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=70"
#LOG_CONF_FILE="/data/tomcat/pc-betinfo-record/logback.xml"

#java ${JDK_OPTS} -jar ${JAVA_OPTS} ${JAR_NAME} --logging.config=${LOG_CONF_FILE} --spring.config.location=/etc/bootstrap.properties
java ${JDK_OPTS} -jar ${JAVA_OPTS} ${JAR_NAME} --spring.config.location=/etc/bootstrap.properties
