mkdir -p /data/java
curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-tomcat/master/jar/docker-compose.yml -o /data/docker-compose.yml
docker-compose -f /data/docker-compose.yml up -d
