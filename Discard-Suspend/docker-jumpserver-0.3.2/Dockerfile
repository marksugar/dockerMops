FROM alpine
MAINTAINER mark Blog: www.linuxea.com
RUN apk add --update openssh sshpass python py-mysqldb py-psutil py-crypto git \
        && git clone https://github.com/jumpserver/jumpserver.git \
        && apk del git \
        && cd /jumpserver \
        && python /jumpserver/install/docker/get-pip.py \
        && pip install -r /jumpserver/install/docker/piprequires.txt \
        && cp /jumpserver/install/docker/run.sh /run.sh \
        && chmod +x /run.sh \
        && rm -rf /jumpserver/keys /jumpserver/logs /home /etc/ssh  /etc/shadow /etc/passwd /etc/motd /var/cache/apk/* /jumpserver/docs /jumpserver/jumpserver.conf\
        && cp -r /jumpserver/install/docker/useradd /usr/sbin/useradd \
        && cp -r /jumpserver/install/docker/userdel /usr/sbin/userdel \
        && chmod +x /usr/sbin/useradd  \
        && chmod +x /usr/sbin/userdel \
        && mkdir -p /data/home /data/logs /data/keys /data/ssh \
        && cp -r /jumpserver/install/docker/shadow /data/shadow \
        && cp -r /jumpserver/install/docker/passwd /data/passwd \
        && ln -s /data/logs /jumpserver/logs \
        && ln -s /data/keys /jumpserver/keys \
        && ln -s /data/home /home \
        && ln -s /data/ssh /etc/ssh \
        && ln -s /data/passwd /etc/passwd \
        && ln -s /data/shadow /etc/shadow \
        && chmod -R 777 /jumpserver
VOLUME /data
EXPOSE 8000
CMD /run.sh
