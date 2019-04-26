FROM ubuntu:16.04
MAINTAINER www.linuxea.com and marksugar
LABEL maintainer="www.linuxea.com"
COPY entrypoint.sh /bin/entrypoint.sh

ARG TOMURL="http://apache.mirrors.pair.com/tomcat/tomcat-8/v8.5.40/bin/apache-tomcat-8.5.40.tar.gz"
ENV TOMURL=${TOMURL}

ARG GSERVER="0.9.14"
ENV GSERVER=${GSERVER}

SHELL ["/bin/bash", "-c"]

ADD entrypoint.sh /bin/entrypoint.sh
RUN set -x && \
	APTPAK="libtool autoconf libcairo2-dev libjpeg-turbo8-dev libpng12-dev  libguac-dev pax-utils libavcodec-dev libavutil-dev libswscale-dev libfreerdp-dev libpango1.0-dev libssh2-1-dev libtelnet-dev libvncserver-dev libpulse-dev libssl-dev libvorbis-dev  ghostscript curl git" \
	&& apt-get update \
	&& apt-get -y install language-pack-zh-hans libossp-uuid-dev libwebp-dev default-jre default-jdk \
	&& export LC_ALL=zh_CN.UTF-8 \
	&& echo 'LANG="zh_CN.UTF-8"' > /etc/default/locale \
	&& apt-get install -y $APTPAK \
	&& cd /opt \
	&& git clone --depth=1 https://github.com/jumpserver/docker-guacamole.git \
	&& cd docker-guacamole \
	&& tar xf guacamole-server-${GSERVER}.tar.gz \
	&& cd guacamole-server-${GSERVER} \
	&& autoreconf -fi \
	&& ./configure --with-init-dir=/etc/init.d \
	&& make \
	&& make install \
	&& cd .. && rm -rf guacamole-server-${GSERVER}* \
	&& ldconfig \
	&& mkdir -p /config/guacamole /config/guacamole/lib /config/guacamole/extensions \
	&& ln -sf /opt/docker-guacamole/guacamole-auth-jumpserver-${GSERVER}.jar /config/guacamole/extensions/guacamole-auth-jumpserver-${GSERVER}.jar \
	&& ln -sf /opt/docker-guacamole/root/app/guacamole/guacamole.properties /config/guacamole/guacamole.properties \
	&& curl -Lk https://github.com/ibuler/ssh-forward/releases/download/v0.0.5/linux-amd64.tar.gz |tar xz -C /bin/ \
	&& chmod +x /bin/ssh-forward \
	&& curl -Lk $TOMURL |tar xz -C /config/ \
	&& mv /config/apache-tomcat-* /config/tomcat \
	&& rm -rf /config/tomcat/webapps/* \
	&& ln -sf /opt/docker-guacamole/guacamole-${GSERVER}.war /config/tomcat/webapps/ROOT.war \
	&& apt-get install supervisor -y \
	&& apt-get -y --purge remove $APTPAK \
	&& apt-get autoclean \
	&& apt-get clean \
	&& apt-get autoremove -y \
	&& \rm -rf /var/cache/apt/archives /var/cache/apt/archives/partial \
	&& chmod +x /bin/entrypoint.sh
ADD supervisord.conf /etc/supervisor/supervisord.conf
WORKDIR /config/tomcat/bin
CMD ["entrypoint.sh"]
