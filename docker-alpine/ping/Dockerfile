FROM alpine:3.9
MAINTAINER www.linuxea.com
LABEL maintainer="www.linuxea.com"
RUN && echo "https://mirrors.ustc.edu.cn/alpine/v3.6/main/" > /etc/apk/repositories \
    && echo "https://mirrors.ustc.edu.cn/alpine/v3.6/community/" >> /etc/apk/repositories \
    && apk update \
    && apk add bash \
    && rm /var/cache/apk/*
CMD ["tail","-f","/etc/hosts"]
