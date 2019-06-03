#!/bin/bash
#########################################################################
# File Name: entrypoint.sh
# Author: www.linuxea.com
# Created Time: 2019年06月03日 星期一 16时11分39秒
#########################################################################

supervisord -n -c /etc/supervisord.conf
