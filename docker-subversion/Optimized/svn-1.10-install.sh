#!/bin/bash
mkdir /data/docker/ -p
curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-subversion1.9.4/master/Optimized/docker-compose.yaml -o /data/docker/docker-compose.yaml
/usr/local/bin/docker-compose -f /data/docker/docker-compose.yaml up -d
