#!/bin/bash
pat=/data/docker/keepliaved
mkdir $pat -p
curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/Docker-keepalived/master/docker-compose.yaml $pat/docker-compose.yaml
curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/Docker-keepalived/master/keepalived_backup.conf $pat/keepalived_B.conf
curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/Docker-keepalived/master/keepalived_master.conf $pat/keepalived_M.cobf
curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/Docker-keepalived/master/crontab_Cerebral-cleft.sh $pat/crontab_Cerebral-cleft.sh
chmod +x $pat/crontab_Cerebral-cleft.sh
cd $pat && docker-compose up -d
(crontab -l;echo -e "*/1 * * * * $pat/crontab_Cerebral-cleft.sh") | crontab -
