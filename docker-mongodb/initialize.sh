#!/bin/bash
USER=mark
DATABASE=admin
PASS=password
directory="/data/mongodb/db"
if [ "$(ls -A $directory)" ]; then
    /usr/local/mongodb/bin/mongod --dbpath=/data/mongodb/db/ --bind_ip=0.0.0.0 --port=27017
else
	#mongod --config=/etc/mongodb.conf --dbpath=/data/mongodb/db/ --bind_ip=0.0.0.0 --port=27017	
	curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-mongodb/master/mongodb.conf -o /etc/mongodb.conf && \
    /usr/local/mongodb/bin/mongod --dbpath=/data/mongodb/db/ --bind_ip=0.0.0.0 --port=27017 && \
  	mongo admin --eval "db.createUser({user: '${USER}', pwd: '${PASS}', roles: [ { role: "userAdminAnyDatabase", db: "admin" }]});"
fi
