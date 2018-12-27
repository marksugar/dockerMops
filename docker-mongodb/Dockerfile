FROM centos
MAINTAINER wwww.linuxea.com and mark make
RUN curl -O https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-3.4.2.tgz \
	&& tar xf mongodb-linux-x86_64-3.4.2.tgz -C /usr/local && rm -rf mongodb-linux-x86_64-3.4.2.tgz \
	&& ln -s /usr/local/mongodb-linux-x86_64-3.4.2/ /usr/local/mongodb \
	&& mkdir /data/mongodb/{db,logs} -p  \
	&& useradd -r mongodb -d /usr/local/mongodb -s /sbin/nologin \
	&& chown -R mongodb:mongodb /data/ && rm -rf /etc/mongodb.conf \
	&& curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-mongodb/master/mongodb.conf -o /etc/mongodb.conf \
	&& curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-mongodb/master/initialize.sh -o /initialize.sh \
	&& chmod +x /initialize.sh
ENV PATH /usr/local/mongodb/bin:$PATH
#EXPOSE 3306
ENTRYPOINT ["/initialize.sh"]
