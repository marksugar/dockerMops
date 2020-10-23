FROM debian:10.6
MAINTAINER www.linuxea.com

ARG versionurl="http://mirror.rise.ph/mariadb//mariadb-10.5.6/bintar-linux-systemd-x86_64/mariadb-10.5.6-linux-systemd-x86_64.tar.gz"
ENV versionurl=${versionurl}

COPY my.cnf /etc/my.cnf
COPY docker-entrypoint.sh /bin/docker-entrypoint.sh
#COPY mariadb-10.5.6-linux-systemd-x86_64.tar.gz /mariadb.tar.gz
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
	&& \rm -rf /usr/local/mysql/bin/*.pdb /usr/local/mysql/mysql-test/ /usr/local/mysql/share/charsets /usr/local/mysql/lib/plugin/ \
	&& \rm -rf /mariadb.tar.gz \
	&& chmod +x /bin/docker-entrypoint.sh /bin/gosu
EXPOSE 3306
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["start-mariadb"]
