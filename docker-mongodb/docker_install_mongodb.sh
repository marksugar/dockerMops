#!/bin/bash
mkdir -p /data/docker/mongodb/db/
curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-mongodb/master/mongodb.conf -o /data/docker/mongodb/mongodb.conf
curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-mongodb/master/docker-compose.yaml -o /data/docker/mongodb/docker-compose.yaml
cd /data/docker/mongodb/ && /usr/local/bin/docker-compose up -d
