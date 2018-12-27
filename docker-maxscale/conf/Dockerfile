FROM centos:7
MAINTAINER wwww.linuxea.com
ENV NODE_VERSION 2.1.9
ENV MAXCON "/data/maxscale/maxscale.cnf"
RUN groupadd -r -g 307 maxscale \
	&& useradd -r -g 307 -u 307 maxscale -s /sbin/nologin -M \
	&& curl -Lk https://downloads.mariadb.com/MaxScale/${NODE_VERSION}/centos/7/x86_64/maxscale-${NODE_VERSION}.centos.7.tar.gz -o ./maxscale-${NODE_VERSION}.centos.7.tar.gz \
	&& tar xf maxscale-${NODE_VERSION}.centos.7.tar.gz -C /usr/local/ \
	&& cd /usr/local/ && ln -s maxscale-${NODE_VERSION}.centos.7 maxscale \
	&& ln -s /usr/local/maxscale/bin/maxadmin /usr/bin/ \
	&& yum -y install epel* && yum install python-pip inotify-tools -y \
	&& pip install supervisor \
	&& curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/maxscale/master/conf/supervisord.conf -o /etc/supervisord.conf \
	&& yum clean all && rm -rf /maxscale-${NODE_VERSION}.centos.7.tar.gz \
  && curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/maxscale/master/conf/start.sh -o /start.sh && chmod +x /start.sh
ENTRYPOINT [ "/start.sh" ]
