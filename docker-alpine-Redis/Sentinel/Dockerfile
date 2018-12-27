FROM alpine:3.6
MAINTAINER www.linuxea.com mark
ENV RS_VSON="3.2.9"
ENV RS_USER="redis"
ENV RS_VSON_URL="http://download.redis.io/releases/redis-${RS_VSON}.tar.gz" \
	BATADIR=/usr/local/redis \
	DATADIR=/data/redis \
	DATALOG=/data/logs
RUN buildADD='gcc make musl-dev linux-headers tar curl' \
	&& set -x \
	&& addgroup -g 401 -S ${RS_USER} && adduser -u 401 -S -H -s /sbin/nologin -g 'redis' -G ${RS_USER} ${RS_USER} \
	&& mkdir -p ${BATADIR} ${DATADIR} ${DATALOG}\
	&& chown ${RS_USER}.${RS_USER} ${DATADIR} \
	&& apk add --no-cache --virtual .build-deps ${buildADD} \
	&& curl -Lks4  ${RS_VSON_URL}|tar xz -C ${BATADIR} --strip-components=1 \
	&& curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-alpine-Redis/master/Sentinel/start.sh -o /start.sh \
	&& chmod +x /start.sh \	
	&& cd ${BATADIR} && make && make install \
#	&& make -c ${BATADIR} -j $(awk '/processor/{i++}END{print i}' /proc/cpuinfo) \
#	&& make -C ${BATADIR} install \
	&& /bin/cp ${BATADIR}/redis.conf /etc/ \
	&& apk del .build-deps \
	&& rm -rf /var/cache/apk/* ${BATADIR} 
EXPOSE 6379/tcp 26379/tcp
ENTRYPOINT ["/start.sh"]
