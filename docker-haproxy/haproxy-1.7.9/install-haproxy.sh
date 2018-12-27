#!/bin/bash
#########################################################################
# File Name: haproxy.sh
# Created Time: 2017年11月22日 星期三 10时54分57秒
#########################################################################

HAVISON=1.7.9
DPA=/usr/local
HACON=/etc/haproxy
SICATSON=1.7.3.2
HSTART=/etc/init.d/haproxy

yum install gcc -y
if [ `grep -c haproxy /etc/passwd` != 1 ];then
	echo -e "\033[43m create haproxy user haproxy\033[0m"
	groupadd -r -g 149 haproxy 
	useradd -g haproxy -r -s /sbin/nologin -u 149 haproxy 
	echo -e "\033[42m haproxy user create done \033[0m"
fi
if [ ! -d /usr/local/haproxy ];then
	echo -e "\033[43m haproxy install start\033[0m"
	wget http://www.haproxy.org/download/1.7/src/haproxy-${HAVISON}.tar.gz
	tar xf haproxy-${HAVISON}.tar.gz -C ${DPA}
	cd ${DPA}/haproxy-${HAVISON}
	make TARGET=linux31 PREFIX=/usr/local/haproxy 
	make install PREFIX=/usr/local/haproxy
	echo -e "\033[42m haproxy install done \033[0m"
fi
if [ ! -f ${HACON}/haproxy.cfg ];then
	echo -e "\033[43m ${HACON}/haproxy.cfg download start \033[0m"
	mkdir ${HACON} -p
	wget https://raw.githubusercontent.com/LinuxEA-Mark/docker-haproxy1.6.5/master/haproxycfg -O ${HACON}/haproxy.cfg
	echo -e "\033[42m ${HACON}/haproxy.cfg download done \033[0m"
fi
if [ ! -f ${HSTART} ];then
	echo -e "\033[43m ${HSTART} start script download \033[0m"
	wget https://raw.githubusercontent.com/LinuxEA-Mark/docker-haproxy1.6.5/master/haproxy -o ${HSTART}
	chmod +x ${HSTART}
	echo -e "\033[42m ${HSTART} start script download done \033[0m"
fi
if [ ! -d ${DPA}/socat-${SICATSON} ];then
	echo -en "\033[5;31;49;1m Need to install Socat-${SICATSON}? \033[25;39;49;0m \033[43;31myes/no\033[0m"
	read QAZ
		case $QAZ in 
		y|yes)
			echo -e "\033[43m socat install start \033[0m"
			wget http://www.dest-unreach.org/socat/download/socat-${SICATSON}.tar.gz
			tar xf socat-${SICATSON}.tar.gz -C ${DPA}
			cd ${DPA}/socat-${SICATSON}
			./configure
			make
			make install
			echo -e "\033[42m socat install done \033[0m"
			;;
		n|no)
			exit 0
			;;
		esac
fi
