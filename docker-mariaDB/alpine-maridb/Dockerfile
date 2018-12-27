FROM alpine:3.8
MAINTAINER www.linuxea.com
ENV USERSQL=mysql
ENV DATADIR=/data/mariadb
RUN apk --update --no-cache add mariadb mariadb-client curl \
  && mkdir ${DATADIR} ${DATADIR}/tmp -p \
  && chown -R ${USERSQL}.${USERSQL}  ${DATADIR} \
  && curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-mariaDB/master/alpine-maridb/start.sh -o /start.sh \
  && curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-mariaDB/master/alpine-maridb/my.cnf -o /etc/my.cnf \
  && chmod +x /*.sh \
  && apk del mariadb-client curl \
  && rm -rf /var/cache/apk/* /tmp/* /var/lib/apt/lists/* /var/tmp/* /usr/share/doc/*
EXPOSE 3306
ENTRYPOINT ["/start.sh"]
