FROM debian:10
MAINTAINER wwww.linuxea.com
ARG version="2.7.3"
ENV version=${version}
ARG Pversion="5.0"
ENV Pversion=${Pversion}
ENV PingURL=http://github.com/schweikert/fping/releases/download/v${Pversion}/fping-${Pversion}.tar.gz
ENV SmoKingUrl=https://oss.oetiker.ch/smokeping/pub/smokeping-${version}.tar.gz
ENV USER=www
COPY docker-entrypoint.sh /bin/docker-entrypoint.sh
RUN groupadd -g 400 -r  ${USER} \
  && useradd -u 400 -s /sbin/nologin -g 'www' -G  ${USER}  ${USER} \
  && apt-get update \
  && apt-get install sendmail \
	fcgiwrap \
	gcc \
	echoping \
	wget \
	curl \
	rrdtool \
	librrds-perl \
	libssl-dev \
	libnet-ssleay-perl -y \
  && wget ${PingURL} -O - | tar -xz -C /usr/local/ \
  &&  cd /usr/local/fping-5.0/ \
  && ./configure \
  && make \
  && make install \
  && curl -Lk ${SmoKingUrl} | tar xz -C  /usr/local/ \
  && cd /usr/local/smokeping-2.7.3/ \
  && ln -s /usr/bin/make /usr/bin/gmake \
  && ln -s /usr/local/smokeping/bin/smokeping /usr/local/bin/ \
  && ./configure --prefix=/usr/local/smokeping \
  && /usr/bin/gmake install \
  && bash -c 'mkdir /usr/local/smokeping/log /usr/local/smokeping/htdocs/{cache,data,var} -p' \
  && cp /usr/local/smokeping/etc/config.dist  /usr/local/smokeping/etc/config \
  && sed -i 's@/usr/sbin/fping@/usr/local/sbin/fping@g'  /usr/local/smokeping/etc/config \
  && sed -i 's@imgcache =.*@imgcache=/usr/local/smokeping/htdocs/cache@g' /usr/local/smokeping/etc/config \
  && sed -i 's@datadir  =.*@datadir=/usr/local/smokeping/htdocs/data@g' /usr/local/smokeping/etc/config \
  && sed -i 's@piddir  =.*@piddir=/usr/local/smokeping/htdocs/var@g'  /usr/local/smokeping/etc/config \
  && mv /usr/local/smokeping/htdocs/smokeping.fcgi.dist /usr/local/smokeping/htdocs/smokeping.fcgi \
  && chmod 600 /usr/local/smokeping/etc/smokeping_secrets.dist   \
  && chmod +x /bin/docker-entrypoint.sh \
  && rm -rf /usr/local/fping-5.0 /usr/local/smokeping-2.7.3/ \
  && apt-get autoremove curl wget gcc -y\
  && apt-get autoclean all
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["smokepingrun"]