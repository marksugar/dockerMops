#!/bin/sh
#########################################################################
# File Name: entrypoint.sh
# Created Time: 2018年12月31日 星期一 15时12分25秒
#########################################################################
FTPLOGS=${FTPLOGS:-/data/logs}
FTPDATA=${FTPDATA:-/data/wwwroot}
USERNAME=${USERNAME:-marksugar}
WELCOME=${WELCOME:-welcome to linuxea.com}
FTPPASSWD=${FTPPASSWD:-marksugar}

useradd -g root ${USERNAME} -d ${FTPDATA}
sed -i "s@/var/ftp@${FTPDATA}@g"  /etc/passwd
echo "${FTPPASSWD}" | passwd --stdin "${USERNAME}"
chown ${USERNAME} ${FTPDATA}
chmod +rx ${FTPDATA}

eval "echo \"$(cat /opt/.vsftpd)\"" > /etc/vsftpd/vsftpd.conf
eval "echo \"$(cat /opt/.nginx.conf)\"" > /etc/nginx/nginx.conf
eval "echo \"$(cat /opt/.supervisord.conf)\"" > /etc/supervisord.conf

echo "$WELCOME" > /etc/vsftpd/anon_welcome.txt
mkdir $FTPLOGS $FTPDATA -p
cp /tmp/*.html /data/wwwroot
createrepo -pdo /data/wwwroot /data/wwwroot
#exec /usr/sbin/nginx "-g daemon off;"
exec supervisord  -n -c /etc/supervisord.conf
#exec "$@"
