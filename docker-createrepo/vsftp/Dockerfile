FROM centos:7
LABEL master="www.linuxea.com"
ENV version=1.14.2
ENV USER=www
ENV INSTALL_PATH="/usr/local"
ENV WWWPATH="/data/wwwroot"
COPY ngx-fancyindex ${INSTALL_PATH}/ngx-fancyindex
RUN useradd ${USER} -s /sbin/nologin -M \
	&& yum install epel* -y \
	&& yum makecache \
	&& yum install openssl-devel pcre pcre-devel gcc make createrepo python-pip inotify-tools git gettext vsftpd -y \
	&& pip install supervisor \
#	&& git clone https://github.com/aperezdc/ngx-fancyindex.git "${INSTALL_PATH}/ngx-fancyindex" \
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
	&& yum remove git openssl-devel pcre-devel gcc make python-pip -y \
	&& \rm -rf /usr/local/nginx-${version}/ ngx-fancyindex/ /var/cache/yum \
	&& yum clean all
COPY logs.conf /etc/nginx/vhost/logs.conf
COPY vsftpd.conf /opt/.vsftpd
COPY nginx.conf /opt/.nginx.conf
COPY supervisord.conf /opt/.supervisord.conf
COPY footer.html /tmp/footer.html
COPY header.html /tmp/header.html
COPY entrypoint.sh /bin/entrypoint.sh
#CMD ["/usr/sbin/nginx","-g","daemon off;"]
ENTRYPOINT ["entrypoint.sh"]
