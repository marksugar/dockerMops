FROM alpine
MAINTAINER mark www.linuxea.com
ENV SPA /data/docker/svn
RUN apk add --update subversion curl\
  && rm /var/cache/apk/* \
  && mkdir $SPA -p \
  && curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-subversion1.9.4/master/initialization.sh -o /initialization.sh \
  && chmod +x /initialization.sh
#  && svnadmin create $SPA \
#  && sed -i  's/# anon-access = read/anon-access = none/g' $SPA/conf/svnserve.conf \
#  && sed -i  's/# password-db = passwd/password-db = passwd/g' $SPA/conf/svnserve.conf \
#  && sed -i  's/# auth-access = write/auth-access = write/g' $SPA/conf/svnserve.conf \
#  && sed -i  's/# realm = My First Repository/realm = web1/g' $SPA/conf/svnserve.conf \
#  && sed -i  's/# authz-db = authz/authz-db = authz/g' $SPA/conf/svnserve.conf \
#  && echo linuxea=mark >> $SPA/conf/passwd \
#  && curl -Lks4  https://raw.githubusercontent.com/LinuxEA-Mark/docker-subversion1.9.4/master/authz >> $SPA/conf/authz \
#  && curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-subversion1.9.4/master/initialization.sh -o /initialization.sh && cp -ra $SPA/conf/* /tmp && rm -rf $SPA/conf/*
ENTRYPOINT  ["/initialization.sh"]
