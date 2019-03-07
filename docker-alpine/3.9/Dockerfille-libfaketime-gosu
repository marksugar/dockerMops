FROM alpine:3.9 as libfaketime
MAINTAINER www.linuxea.com
LABEL maintainer="www.linuxea.com"
COPY entrypoint.sh /bin/entrypoint.sh
RUN apk add --no-cache --virtual .build-deps \
		git \
		make \
		gcc \
		libc-dev \
	&& git clone https://github.com/wolfcw/libfaketime.git \
	&& cd libfaketime/src \
	&& make install \
	&& apk add --no-cache bash \
	&& wget https://github.com/tianon/gosu/releases/download/1.11/gosu-amd64 -O /usr/local/bin/gosu \
	&& chmod +x /bin/entrypoint.sh /usr/local/bin/gosu \
	&& apk del .build-deps \
	&& \rm -rf /var/cache/apk/*
ENTRYPOINT ["entrypoint.sh"]
