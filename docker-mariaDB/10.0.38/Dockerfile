FROM debian:9.8-slim
MAINTAINER www.linuxea.com

ARG versionurl="https://downloads.mariadb.com/MariaDB/mariadb-galera-5.5.63/bintar-linux-x86_64/mariadb-galera-5.5.63-linux-x86_64.tar.gz"
ENV versionurl=${versionurl}

COPY my.cnf /etc/my.cnf
COPY entrypoint.sh /bin/entrypoint.sh

RUN apt-get update \
	&& apt-get -y install wget sysfsutils libncurses5 libjemalloc-dev libaio-dev \
	&& echo 'kernel/mm/transparent_hugepage/enabled = never' >> /etc/sysfs.conf \
	&& echo 'kernel/mm/transparent_hugepage/defrag = never' >> /etc/sysfs.conf \
	&& wget https://github.com/tianon/gosu/releases/download/1.11/gosu-amd64 -O /bin/gosu \
	&& wget $versionurl -O /mariadb.tar.gz \
	&& mkdir /usr/local/mysql && tar -xf /mariadb.tar.gz --strip-components 1 -C /usr/local/mysql \
	&& ln -sf /usr/local/mysql/bin/mysql /bin/mysql \
	&& apt-get -y --purge remove wget \
	&& apt-get autoclean \
	&& apt-get clean \
	&& apt-get autoremove -y \
	&& \rm -rf /var/cache/apt/archives /var/cache/apt/archives/partial \
	&& \rm -rf /mariadb.tar.gz \
	&& chmod +x /bin/entrypoint.sh /bin/gosu
EXPOSE 3306
ENTRYPOINT ["entrypoint.sh"]
