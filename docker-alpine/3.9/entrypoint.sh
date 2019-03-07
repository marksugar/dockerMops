#!/bin/bash
#########################################################################
# File Name: entrypoint.sh
# Author: www.linuxea.com
# Created Time: Tue 05 Mar 2019 03:59:05 PM CST
#########################################################################

USER_ID=${LOCAL_USER_ID:-1101}
USER_NAME=${LOCAL_USER_NAME:-www}

echo "Starting with UID : $USER_ID And user $USER_NAME"
addgroup --gid $USER_ID $USER_NAME 
adduser -u $USER_ID -S -H -s /bin/bash -g $USER_NAME -G $USER_NAME $USER_NAME -D
# useradd --shell /bin/bash -u $USER_ID -o -c "" -m user
export HOME=/home/$USER_NAME

exec /usr/local/bin/gosu www "$@"
