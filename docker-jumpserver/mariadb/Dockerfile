FROM alpine:3.8
MAINTAINER www.linuxea.com
ENV USERSQL=mysql
ENV DATADIR=/data/mariadb

COPY my.cnf /etc/my.cnf
COPY entrypoint.sh /bin/entrypoint.sh

ARG GSERVER="0.9.14"
ENV GSERVER=${GSERVER}

RUN apk --update --no-cache add mariadb mariadb-client curl \
  && mkdir ${DATADIR} ${DATADIR}/tmp -p \
  && chown -R ${USERSQL}.${USERSQL}  ${DATADIR} \
  && apk del curl \
  && rm -rf /var/cache/apk/* /tmp/* /var/lib/apt/lists/* /var/tmp/* /usr/share/doc/* \
  && chmod +x /bin/entrypoint.sh
EXPOSE 3306
ENTRYPOINT ["entrypoint.sh"]
