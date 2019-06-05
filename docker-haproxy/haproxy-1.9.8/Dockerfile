FROM alpine:3.9

ENV HAPROXY_VERSION 1.9.8
ENV HAPROXY_URL https://www.haproxy.org/download/1.9/src/haproxy-1.9.8.tar.gz
ENV HAPROXY_SHA256 2d9a3300dbd871bc35b743a83caaf50fecfbf06290610231ca2d334fd04c2aee
ENV USER=haproxy
ENV USID=401
# entrypoint.sh start scripts And supervisord.conf file
ADD entrypoint.sh /bin/entrypoint.sh
ADD supervisord.conf /etc/supervisord.conf
# see https://sources.debian.net/src/haproxy/jessie/debian/rules/ for some helpful navigation of the possible "make" arguments
RUN set -x \
	\
	&& apk add --no-cache --virtual .build-deps \
		ca-certificates \
		gcc \
		libc-dev \
		linux-headers \
		lua5.3-dev \
		make \
		openssl \
		openssl-dev \
		pcre-dev \
		readline-dev \
		tar \
		zlib-dev \
		py-pip \
	\
	&& addgroup -g ${USID} -S ${USER} \
	&& adduser -HDu ${USID} -s /sbin/nologin -g 'haproxy server' -G ${USER} ${USER} \
	&& wget -O haproxy.tar.gz "$HAPROXY_URL" \
	&& echo "$HAPROXY_SHA256 *haproxy.tar.gz" | sha256sum -c \
	&& mkdir -p /usr/src/haproxy /usr/local/haproxy /var/run \
	&& tar -xzf haproxy.tar.gz -C /usr/src/haproxy --strip-components=1 \
	&& rm haproxy.tar.gz \
	\
	&& makeOpts=' \
		TARGET=linux2628 \
		USE_LUA=1 LUA_INC=/usr/include/lua5.3 LUA_LIB=/usr/lib/lua5.3 \
		USE_GETADDRINFO=1 \
		USE_OPENSSL=1 \
		USE_PCRE=1 PCREDIR= \
		USE_ZLIB=1 \
		PREFIX=/usr/local/haproxy \
	' \
	&& make -C /usr/src/haproxy -j "$(getconf _NPROCESSORS_ONLN)" all $makeOpts \
	&& make -C /usr/src/haproxy install-bin $makeOpts \
	&& make -C /usr/src/haproxy/contrib/halog halog \
	\
	&& mkdir -p /usr/local/etc/haproxy \
	&& cp -R /usr/src/haproxy/examples/errorfiles /usr/local/etc/haproxy/errors \
	&& cp /usr/src/haproxy/contrib/halog/halog /bin/halog \
	&& rm -rf /usr/src/haproxy \
	&& ln -s /usr/local/haproxy/sbin/haproxy /bin/haproxy \
	\
	&& runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)" \
	&& apk add --virtual .haproxy-rundeps $runDeps inotify-tools supervisor socat bash \
	&& pip install supervisor-stdout \
	&& apk del .build-deps \
	&& rm -rf /var/cache/apk/* \
	&& chmod +x /bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
