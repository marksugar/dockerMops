FROM alpine:3.6
MAINTAINER www.linuxea.com by mark
ENV VERSION=1.7.9
ENV DOWN_URL=http://www.haproxy.org/download \
	TMP_DIR=/tmp/haproxy \
	USR_DIR=/usr/local/haproxy \
	CONF_DIR=/etc/haproxy \
	HAUSER=haproxy
RUN set -x \
	&& habak="make gcc g++ linux-headers python pcre-dev openssl-dev zlib-dev tar curl" \
	&& DOWN_URL=${DOWN_URL}/${VERSION%.*}/src/haproxy-${VERSION}.tar.gz \
	&& mkdir ${USR_DIR} ${CONF_DIR} ${TMP_DIR} -p \
	&& addgroup -g 411 -S ${HAUSER} && adduser -u 411 -S -H -s /sbin/nologin -g 'haproxy' -G ${HAUSER} ${HAUSER} \
	&& apk --update --no-cache upgrade \
	&& apk add --no-cache --virtual build-debase ${habak} \
	&& curl -Lk ${DOWN_URL}|tar xz --strip-components=1 -C ${TMP_DIR} \
	&& cd ${TMP_DIR} && make TARGET=linux2628 PREFIX=${USR_DIR} && make install PREFIX=${USR_DIR} \
#	&& echo "net.ipv4.ip_nonlocal_bind 1" >> /etc/sysctl.conf
	&& apk del build-debase \
	&& runDev="$( \
	scanelf --needed --nobanner /usr/local/haproxy \
		| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
		|sort -u \
		| xargs -r  apk info --installed \
		|sort -u \
	)" \
	&& rm -rf /tmp/* /var/cache/apk/*
EXPOSE 80/tcp 1080/tcp
ENTRYPOINT /usr/local/haproxy/sbin/haproxy -f /etc/haproxy/haproxy.cfg -db
