FROM alpine:3.8
MAINTAINER www.linuxea.com mark
ENV RS_VSON="4.0.11"
ENV RS_USER="redis"
ENV RS_VSON_URL="http://download.redis.io/releases/redis-${RS_VSON}.tar.gz" \
	BATADIR=/usr/local/redis \
	DATADIR=/data/redis \
	DATALOG=/data/logs \
	DATACIG=/etc/redis \
	DATAOPT=/opt
RUN buildADD='gcc make musl-dev linux-headers tar curl' \
	&& set -x \
	&& addgroup -g 401 -S ${RS_USER} && adduser -u 401 -S -H -s /sbin/nologin -g 'redis' -G ${RS_USER} ${RS_USER} \
	&& mkdir -p ${BATADIR} ${DATADIR} ${DATALOG} ${DATACIG} ${DATAOPT}\
	&& chown ${RS_USER}.${RS_USER} ${DATADIR} \
	&& apk add --no-cache --virtual .build-deps ${buildADD} \
	&& curl -Lks4  ${RS_VSON_URL}|tar xz -C ${BATADIR} --strip-components=1 \
	&& cd ${BATADIR} && make && make install \
	&& curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-alpine-Redis/master/4.0.11/redis.env -o /${DATAOPT}/redis.env \
	&& curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-alpine-Redis/master/4.0.11/redis.conf -o /${DATALOG}/redis.conf \
	&& curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-alpine-Redis/master/4.0.11/supervisord.conf -o /etc/supervisord.conf \
	&& curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-alpine-Redis/master/4.0.11/startup.sh -o /startup.sh \
	&& chmod +x /startup.sh \
	&& apk del .build-deps \
	&& apk add supervisor gettext \
	&& rm -rf /var/cache/apk/* ${BATADIR} \
#auto configure maxmemory_size
    && export MAXMEMORY_SIZE=`echo "expr $(($(awk '/MemTotal/{print $2}' /proc/meminfo)*88/102400))"|awk '{print $2}'`
EXPOSE 6379/tcp 26379/tcp
ENTRYPOINT ["/startup.sh"]
