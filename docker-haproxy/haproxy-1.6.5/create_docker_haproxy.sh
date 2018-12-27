#!/bin/bash
pat=/data/docker/haproxy
mkdir -p $pat
curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-haproxy1.6.5/master/haproxy.cfg -o $pat/haproxy.cfg
curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-haproxy1.6.5/master/docker-compose.yaml -o $pat/docker-compose.yaml
cd $pat && docker-compose up -d 
