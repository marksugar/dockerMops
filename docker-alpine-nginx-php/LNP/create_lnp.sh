#!/bin/bash
mkdir /data/{wwwroot,logs,LNP} -p
curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-alpine-nginx-php/master/LNP/docker-compose-LNP.yaml -o /data/LNP/docker-compose-LNP.yaml
docker-compose -f /data/LNP/docker-compose-LNP.yaml up --build -d
