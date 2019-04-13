FROM centos
MAINTAINER wwww.linuxea.com
ENV TMDD /data/docker/
ENV TMJDK=jdk-8u102-linux-x64.rpm
ENV TMAPA=apache-tomcat-8.5.4
RUN yum install -y http://mirrors.ds.com/JDK/$TMJDK && mkdir $TMDD -p && cd $TMDD \
  && curl -s http://mirrors.ds.com/tar%E5%8C%85/${TMAPA}.tar.gz -o /data/docker/${TMAPA}.tar.gz \
  && tar xf ${TMAPA}.tar.gz && rm -rf ${TMAPA}.tar.gz \
  && mv /data/docker/${TMAPA} /data/docker/tomcat \
#  && rm -rf /data/docker/tomcat/webapps/* \
  && sed -i '/allow/ s/$/-->/'  /data/docker/tomcat/webapps/manager/META-INF/context.xml \
  && sed -i '/className/ s/^/<!--/' /data/docker/tomcat/webapps/manager/META-INF/context.xml \
  && sed -i '/allow/ s/$/-->/' /data/docker/tomcat/webapps/host-manager/META-INF/context.xml \
  && sed -i '/className/ s/^/<!--/' /data/docker/tomcat/webapps/host-manager/META-INF/context.xml \
  && rm -rf /data/docker/tomcat/conf/tomcat-users.xml \
  && curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-tomcat/master/tomcat-users.xml -o /data/docker/tomcat/conf/tomcat-users.xml \
  && mkdir /opt/{app,config} && mv /data/docker/tomcat/webapps/* /opt/app  && mv /data/docker/tomcat/conf/* /opt/config \
  && curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-tomcat/master/judgment.sh  -o /judgment.sh \
  && chmod +x /judgment.sh
ENTRYPOINT ["/judgment.sh"]
