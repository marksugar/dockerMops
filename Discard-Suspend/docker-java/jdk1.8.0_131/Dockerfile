FROM marksugar/alpine:jdk8
#ENV JAVA_HOME=/usr/local/share/jdk-11
#ENV PATH="$JAVA_HOME/bin:${PATH}"
#ENV MAV_HOME=/usr/local/apache-maven-3.6.0
#ENV PATH="$MAV_HOME/bin:${PATH}"
ENV USRPATH=/usr/local
#ENV JDKURL="http://10.10.240.145/windows-client/jdk/openjdk-11+28_linux-x64-musl_bin.tar.gz"
#ENV MAVURL="http://10.10.240.145/apache-maven-3.6.0-bin.tar.gz"
ENV TOMURL="http://mirror.rise.ph/apache/tomcat/tomcat-9/v9.0.13/bin/apache-tomcat-9.0.13.tar.gz"
RUN apk update \
    && apk add curl \
    && apk add supervisor \
#	&& curl -Lk ${JDKURL} | tar xz -C ${USRPATH} \
#	&& cd ${USRPATH} && chmod +x jdk-11 && mv jdk-11 /usr/local/share \
#	&& curl -Lk ${MAVURL} | tar xz -C ${USRPATH} \
	&& curl -Lks ${TOMURL} | tar xz -C ${USRPATH} \
	&& curl -Lks https://raw.githubusercontent.com/LinuxEA-Mark/java/master/jdk1.8.0_131/supervisord.conf -o /etc/supervisord.conf \
#	&& curl -Lks https://raw.githubusercontent.com/LinuxEA-Mark/java/master/jdk1.8.0_131/Initialization.sh -o /Initialization.sh \
#	&& curl -Lks https://raw.githubusercontent.com/LinuxEA-Mark/java/master/jdk1.8.0_131/Init.sh -o /etc/init.sh \
	&& curl -Lks https://raw.githubusercontent.com/LinuxEA-Mark/java/master/jdk1.8.0_131/initialize.sh -o /initialize.sh \
	&& cd ${USRPATH} && mv apache-tomcat-9.0.13 tomcat \
	&& export JAR_XMX=2048 \
	&& export JAR_XMS=2048 \
	&& chmod +x  /initialize.sh \
	&& rm -rf /usr/local/tomcat/webapps/* /var/cache/apk/*
EXPOSE 8080/tcp 8080/tcp
ENTRYPOINT ["/initialize.sh"]
