#!/bin/bash
#echo "enable frontend frontend-web.com"|socat stdio /tmp/haproxy.sock
#echo "disable frontend frontend-web.com"|socat stdio /tmp/haproxy.sock
# bash proxy-node.sh disable node1
# bash proxy-node.sh enable node1

SERVRE=backend-webgroup.com
for i in $(seq 1)
  do
      echo "$1 server ${SERVRE}/$2" | socat stdio /tmp/haproxy.sock
done
