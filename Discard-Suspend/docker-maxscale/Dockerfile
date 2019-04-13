FROM centos
MAINTAINER wwww.linuxea.com
ENV NODE_VERSION 2.1.9
RUN groupadd -r -g 307 maxscale \
	&& useradd -r -g 307 -u 307 maxscale -s /sbin/nologin -M \
	&& curl -Lk https://downloads.mariadb.com/MaxScale/${NODE_VERSION}/centos/7/x86_64/maxscale-${NODE_VERSION}.centos.7.tar.gz -o ./maxscale-${NODE_VERSION}.centos.7.tar.gz \
  && curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/maxscale/master/start.sh -o /start.sh \
	&& chmod +x /start.sh \
	&& tar xf maxscale-${NODE_VERSION}.centos.7.tar.gz -C /usr/local/ \
	&& cd /usr/local/ && ln -s maxscale-${NODE_VERSION}.centos.7 maxscale \
	&& ln -s /usr/local/maxscale/bin/maxadmin /usr/bin/ \
	&& yum clean all && rm -rf /maxscale-${NODE_VERSION}.centos.7.tar.gz
ENTRYPOINT [ "/start.sh" ]
