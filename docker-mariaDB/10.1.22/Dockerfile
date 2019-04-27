FROM centos
MAINTAINER wwww.linuxea.com and mark make
ENV version=10.1.22
RUN yum install epel* -y \
        && yum install libaio axel curl -y \
        #&& axel -n 10  http://kodeterbuka.beritagar.id/mariadb//mariadb-10.1.17/bintar-linux-x86_64/mariadb-10.1.17-linux-x86_64.tar.gz \
        && axel -n 30 http://kartolo.sby.datautama.net.id/mariadb//mariadb-10.1.22/bintar-linux-x86_64/mariadb-${version}-linux-x86_64.tar.gz \
        #&& axel -n 10 http://mirrors.ds.com/tar%E5%8C%85/mariadb-10.1.17-linux-x86_64.tar.gz \    
        #&& axel -n 30 http://mirrors.ds.com/tar%E5%8C%85/mariadb-10.1.19-linux-glibc_214-x86_64.tar.gz \
        && tar xf mariadb-${version}-linux-x86_64.tar.gz -C /usr/local \
        && rm -rf mariadb-${version}-linux-x86_64.tar.gz \
        && groupadd -r -g 306 mysql \
        && useradd -r -g 306 -u 306 mysql \
        && mkdir -p /data/mysql \
        && chown -R mysql.mysql  /data/mysql \
        && chown -R root.mysql /usr/local/mariadb-${version}-linux-x86_64 \
        && ln -s /usr/local/mariadb-${version}-linux-x86_64 /usr/local/mysql && cd /usr/local/mysql \
        && curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-mariaDB/master/initialization.sh -o /initialization.sh \
        && curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/Docker-MariaDB/master/initialization.sql -o /initialization.sql \
        && chmod +x /initialization.sh \
        && chown -R mysql.mysql /data/mysql \
        #&& yum remove epel* axel curl -y 
        && yum clean all && mkdir -p /data/mysql /data/logs/mysql 
ENV PATH /usr/local/mysql/bin:$PATH
EXPOSE 3306
ENTRYPOINT ["/initialization.sh"]
