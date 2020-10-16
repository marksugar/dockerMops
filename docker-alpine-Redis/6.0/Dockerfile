FROM alpine:3.9
MAINTAINER www.linuxea.com mark
ARG RS_VSON="5.0.0"
ENV RS_VSON=${RS_VSON}
ENV RS_USER="redis"
ENV RS_VSON_URL="http://download.redis.io/releases/redis-${RS_VSON}.tar.gz" \
	BATADIR=/usr/local/redis \
	DATADIR=/data/redis \
	DATALOG=/data/logs \
	DATACIG=/etc/redis
COPY ./docker-entrypoint.sh /bin/docker-entrypoint.sh
COPY ./redis.conf /etc/redis/redis.conf
RUN buildADD='gcc make musl-dev linux-headers tar curl' \
	&& set -x \
	&& addgroup -g 401 -S ${RS_USER} && adduser -u 401 -S -H -s /sbin/nologin -g 'redis' -G ${RS_USER} ${RS_USER} \
	&& mkdir -p ${BATADIR} ${DATADIR} ${DATALOG} ${DATACIG} ${DATAOPT}\
	&& chown ${RS_USER}.${RS_USER} ${DATADIR} \
	&& apk add --no-cache --virtual .build-deps ${buildADD}  \
	&& apk add --no-cache bash \
	&& curl -Lks4  ${RS_VSON_URL}|tar xz -C ${BATADIR} --strip-components=1 \
	&& cd ${BATADIR} && make && make install \
	&& apk del .build-deps \
	&& rm -rf /var/cache/apk/* ${BATADIR} \
#auto configure maxmemory_size
        && export MAXMEMORY_SIZE=`echo "expr $(($(awk '/MemTotal/{print $2}' /proc/meminfo)*88/102400))"|awk '{print $2}'` \
	&& chmod +x /bin/docker-entrypoint.sh
EXPOSE 6379/tcp 26379/tcp
ENTRYPOINT ["bash","docker-entrypoint.sh"]
CMD ["redis-init"]
