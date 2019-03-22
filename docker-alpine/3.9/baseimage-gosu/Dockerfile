FROM alpine:3.9
MAINTAINER www.linuxea.com
LABEL maintainer="www.linuxea.com"
COPY entrypoint.sh /bin/entrypoint.sh
RUN apk update \
    && apk add bash \
    && wget https://github.com/tianon/gosu/releases/download/1.11/gosu-amd64 -O /usr/local/bin/gosu \
    && chmod +x /bin/entrypoint.sh /usr/local/bin/gosu \
    && rm /var/cache/apk/*
ENTRYPOINT ["entrypoint.sh"]
