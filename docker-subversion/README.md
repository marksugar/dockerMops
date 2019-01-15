# subversion

Use alpine base image, apk add subversion version 1.9.4, mount /data/docker/subversion corresponding container /data/docker/svn/, you can refer to initialization.sh script

* install 

curl -Lks4 https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-subversion/docker-create-svn.sh |bash


# Optimized subversion 1.10

Joined the supervisor daemon

Version 1.10

Please make sure your host is using the redhat series.

If yes, try

All files are in the optimized path.

* install 

curl -Lks4 https://raw.githubusercontent.com/marksugar/dockerMops/master/docker-subversion/Optimized/svn-1.10-install.sh|bash
