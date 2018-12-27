FROM centos
MAINTAINER www.linuxea.com mark
RUN yum install ntp curl -y && rm -rf /etc/ntp.conf\
#&& curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-ntp/master/ntp.conf -o /etc/ntp.conf \
&& curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-ntp/master/start.sh -o /start.sh && mkdir /data \
&& yum clean all && chmod +x /start.sh
ENTRYPOINT ["/start.sh"]
