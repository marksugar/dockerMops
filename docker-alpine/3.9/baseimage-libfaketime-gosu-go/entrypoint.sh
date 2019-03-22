#!/bin/bash
#########################################################################
# File Name: entrypoint.sh
# Author: www.linuxea.com
# Created Time: Tue 05 Mar 2019 03:59:05 PM CST
#########################################################################

USER_ID=${USER_ID:-1101}
USER_NAME=${USER_NAME:-www}
TIME_OFFSET=${TIME_OFFSET:-FAKETIME_NO_CACHE=1 FAKETIME=""}

echo "Starting with UID : $USER_ID And user $USER_NAME"
addgroup --gid $USER_ID $USER_NAME 
adduser -u $USER_ID -S -H -s /bin/bash -g $USER_NAME -G $USER_NAME $USER_NAME -D
# useradd --shell /bin/bash -u $USER_ID -o -c "" -m user
mkdir -p /home/$USER_NAME
chown -R $USER_NAME.$USER_NAME /home/$USER_NAME
export HOME=/home/$USER_NAME
export LD_PRELOAD=/usr/local/lib/faketime/libfaketime.so.1 $TIME_OFFSET

exec /usr/local/bin/gosu $USER_NAME "$@"
