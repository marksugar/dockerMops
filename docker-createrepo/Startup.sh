#!/bin/bash
CONFPATH="/etc/nginx/vhost"
envsubst < ${CONFPATH}/ps.env > ${CONFPATH}/ps.conf 
supervisord  -n -c /etc/supervisord.conf 
