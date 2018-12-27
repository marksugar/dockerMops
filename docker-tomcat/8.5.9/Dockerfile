FROM centos
MAINTAINER wwww.linuxea.com
ENV TMDD /data/docker/
RUN yum install epel-release -y && yum install axel -y \
#  && axel -n 30 -o /tmp/ http://mirrors.dtops.cc/java/8/8u111-b14/jdk-8u111-linux-x64.rpm \
#  && axel -n 30 -o /tmp/ http://download.oracle.com/otn-pub/java/jdk/8u111-b14/jdk-8u111-linux-x64.rpm \
  && axel -a -n 30 -o /tmp/ http://app.nidc.kr/java/jdk-8u111-linux-x64.rpm \
  && yum install /tmp/jdk-8u111-linux-x64.rpm -y && mkdir $TMDD -p && cd $TMDD \
  && curl -s http://mirror.rise.ph/apache/tomcat/tomcat-8/v8.5.9/bin/apache-tomcat-8.5.9.tar.gz -o /data/docker/apache-tomcat-8.5.9.tar.gz \
  && tar xf /data/docker/apache-tomcat-8.5.9.tar.gz -C /data/docker/ && rm -rf /data/docker/apache-tomcat-8.5.9.tar.gz \
  && mv /data/docker/apache-tomcat-8.5.9 /data/docker/tomcat \
# && rm -rf /data/docker/tomcat/webapps/* \
  && sed -i '/allow/ s/$/-->/'  /data/docker/tomcat/webapps/manager/META-INF/context.xml \
  && sed -i '/className/ s/^/<!--/' /data/docker/tomcat/webapps/manager/META-INF/context.xml \
  && sed -i '/allow/ s/$/-->/' /data/docker/tomcat/webapps/host-manager/META-INF/context.xml \
  && sed -i '/className/ s/^/<!--/' /data/docker/tomcat/webapps/host-manager/META-INF/context.xml \
  && rm -rf /data/docker/tomcat/conf/tomcat-users.xml /tmp/jdk-8u111-linux-x64.rpm \
  && curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-tomcat/master/tomcat-users.xml -o /data/docker/tomcat/conf/tomcat-users.xml \
  && mkdir /opt/{app,config} && mv /data/docker/tomcat/webapps/* /opt/app  && mv /data/docker/tomcat/conf/* /opt/config \
  && curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-tomcat/master/judgment.sh  -o /judgment.sh \
  && chmod +x /judgment.sh \
  && yum remove axel -y \
  && yum clean all
ENTRYPOINT ["/judgment.sh"]
