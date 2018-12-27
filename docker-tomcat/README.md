# docker-tomcat

* Notice:

base image uses centos。Apache-tomcat version 8.5.4 。Jdk use jdk-8u102

The configuration file is mounted at: /data/docker/tomcat/conf

Webapps is mounted on: /data/docker/tomcat/webapps


* local install apache-tomcat 8.5.4 jdk use jdk-8u102

curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-tomcat/master/local_create_docker_tomcat.sh |bash

* intenet install apache-tomcat 8.5.9 jdk use jdk-8u111

curl -Lks4 https://raw.githubusercontent.com/LinuxEA-Mark/docker-tomcat/master/intenet_create_docker_tomcat.sh |bash


