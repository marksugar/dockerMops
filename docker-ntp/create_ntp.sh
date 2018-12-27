mkdir -p /data/docker/ntp/
curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-ntp/master/ntp.conf -o /data/docker/ntp/ntp.conf
curl -lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-ntp/master/docker-compose.yaml -o /data/docker/ntp/docker-compose.yaml
cd /data/docker/ntp/ && docker-compose up -d
