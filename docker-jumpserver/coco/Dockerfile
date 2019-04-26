FROM ubuntu:16.04
MAINTAINER www.linuxea.com and marksugar
LABEL maintainer="www.linuxea.com"
COPY entrypoint.sh /bin/entrypoint.sh
SHELL ["/bin/bash", "-c"]
#RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN set -x && \
	APTAPP="wget gcc libffi-dev git libmysqlclient-dev software-properties-common libkrb5-dev krb5-doc" \
	&& apt-get update \
#	&& apt-get -y upgrade \
	&& apt-get -y install $APTAPP \
	&& apt-get -y install language-pack-zh-hans \
	&& export LC_ALL=zh_CN.UTF-8 \
	&& echo 'LANG="zh_CN.UTF-8"' > /etc/default/locale \
	&& add-apt-repository ppa:jonathonf/python-3.6 -y \
	&& apt-get update \
	&& apt-get -y install python3.6 python3.6-dev python3.6-venv \
	&& cd /opt \
	&& python3.6 -m venv py3 \
	&& source /opt/py3/bin/activate \
	&& git clone https://github.com/jumpserver/coco.git && cd coco && git checkout master \
	&& cd /opt/coco/requirements \
	&& pip install --upgrade pip setuptools \
	&& pip install -r requirements.txt \
	&& apt-get -y --purge remove $APTPAK \
	&& apt-get autoclean \
	&& apt-get clean \
	&& apt-get autoremove \
	&& \rm -rf /var/cache/apt/archives /var/cache/apt/archives/partial \
	&& chmod +x /bin/entrypoint.sh
WORKDIR /opt/coco
CMD ["entrypoint.sh"]
