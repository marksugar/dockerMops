#!/bin/bash
DTDIR="/data/mariadb"
DTLNMP="/data/"
if [ -d ${DTLNMP} ];then
  echo "${DTLNMP} Was created"
else
  echo "create ${DTLNMP} success"
  mkdir ${DTLNMP} -p 
  if [ -d ${DTDIR} ]; then
    echo "${DTDIR} lready exists. Create an interrupt"
  else
    echo "create ${DTDIR} success"
    mkdir ${DTDIR} -p
  fi
fi
curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-mariaDB/master/alpine-maridb/docker-compose-mariadb.yaml -o ${DTLNMP}/docker-compose-mariadb.yaml
docker-compose -f  ${DTLNMP}/docker-compose-mariadb.yaml up --build -d
