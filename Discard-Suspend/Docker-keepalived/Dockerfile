FROM alpine
MAINTAINER wwww.linuxea.com
RUN echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && echo "http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
    && apk --update -t add keepalived curl iproute2 \
    && curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/Docker-keepalived/master/run.sh -o /run.sh && chmod +x /run.sh \
    && rm -f /var/cache/apk/* /tmp/* /etc/keepalived/keepalived.conf
ENTRYPOINT ["/run.sh"]
