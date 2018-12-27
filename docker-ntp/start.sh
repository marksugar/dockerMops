#!/bin/bash
directory="/data/ntp.conf"
if [ "$(ls $directory)" ]; then
	/usr/sbin/ntpd -c /data/ntp.conf -p /tmp/ntpd.pid -d
else
	curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-ntp/master/ntp.conf -o /data/ntp.conf
	/usr/sbin/ntpd -c /data/ntp.conf -p /tmp/ntpd.pid -d
fi
