#!/bin/bash
mkdir /data/docker/ -p
curl -Lks4 https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-subversion/Optimized/docker-compose.yaml -o /data/docker/docker-compose.yaml
/usr/local/bin/docker-compose -f /data/docker/docker-compose.yaml up -d
