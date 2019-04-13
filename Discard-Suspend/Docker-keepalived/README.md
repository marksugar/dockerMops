# Docker-keepalived
#### Terms and Conditions
Use the alpine base image, apk add install
Initial attempts, the brain split with the scheduled task to run once a minute, testing services are normal, if not remove the container, which seems inevitable that some backward, but I did not find a better solution in the create_docker-keepalived.sh script, There are two keepalived.conf, respectively master and backup, do not be confused to start. . .


这是我测试使用的，并不具备任何使用价值

* install

curl -Lks4 https://raw.githubusercontent.com/marksugar/dockerMops/master/Docker-keepalived/create_docker-keepalived.sh |bash
