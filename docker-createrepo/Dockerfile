FROM centos:7
MAINTAINER wwww.linuxea.com
ENV version=1.9.9
ENV USER=www
ENV INSTALL_PATH="/usr/local"
ENV WWWPATH="/data/wwwroot"
RUN useradd ${USER} -s /sbin/nologin -M \
	&& yum install epel* -y \
	&& yum install openssl-devel pcre pcre-devel gcc make createrepo python-pip inotify-tools git gettext -y \
	&& pip install supervisor \
	&& git clone https://github.com/aperezdc/ngx-fancyindex.git "${INSTALL_PATH}/ngx-fancyindex" \
	&& sed -i 's/f4f4f4/fff/g' /usr/local/ngx-fancyindex/template.html \
	&& curl -Lk http://nginx.org/download/nginx-${version}.tar.gz |tar xz -C ${INSTALL_PATH} \
	&& cd /usr/local/nginx-${version} && ./configure \
		--prefix=/usr/local/nginx \
		--conf-path=/etc/nginx/nginx.conf \
		--user=${USER} \
		--group=${USER} \
		--error-log-path=/data/logs/error.log \
		--http-log-path=/data/logs/access.log \
		--pid-path=/var/run/nginx/nginx.pid \
		--lock-path=/var/lock/nginx.lock \
		--with-http_ssl_module \
		--with-http_stub_status_module \
		--with-http_gzip_static_module \
		--with-http_flv_module \
		--with-http_mp4_module \
		--http-client-body-temp-path=/var/tmp/nginx/client \
		--http-proxy-temp-path=/var/tmp/nginx/proxy \
		--http-fastcgi-temp-path=/var/tmp/nginx/fastcgi \
		--http-uwsgi-temp-path=/var/tmp/nginx/uwsgi \
		--add-module=${INSTALL_PATH}/ngx-fancyindex/  \
	&& make && make install \
	&& ln -s /usr/local/nginx/sbin/nginx /sbin/nginx \
	&& rm -rf /etc/nginx/nginx.conf \
	&& mkdir -p /var/tmp/nginx/{client,fastcgi,proxy,uwsgi} /etc/nginx/vhost ${WWWPATH}/ /data/logs \
	&& curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-createrepo/master/nginx.conf -o /etc/nginx/nginx.conf \
	&& curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-createrepo/master/footer.html -o /tmp/footer.html \
	&& curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-createrepo/master/header.html -o /tmp/header.html \
	&& curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-createrepo/master/supervisord.conf -o /etc/supervisord.conf \
	&& echo -e "listen 80;\nserver_name localhost;" > /etc/nginx/vhost/ps.conf \
	&& echo -e "listen \${NGINX_PORT};\nserver_name \${SERVER_NAME};" > /etc/nginx/vhost/ps.env \
	&& echo -e '#!/bin/bash\nmkdir /data/{wwwroot,logs} -p\n cp /tmp/*.html /data/wwwroot \ncreaterepo -pdo /data/wwwroot /data/wwwroot\nenvsubst < /etc/nginx/vhost/ps.env > /etc/nginx/vhost/ps.conf \nsupervisord  -n -c /etc/supervisord.conf' > /startup.sh \
	&& chmod +x /startup.sh \
	&& yum remove git openssl-devel pcre-devel gcc make python-pip -y \
	&& \rm -rf /usr/local/nginx-1.9.9/ ngx-fancyindex/ /var/cache/yum \
	&& yum clean all
ENTRYPOINT ["/startup.sh"]
