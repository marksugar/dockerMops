FROM jenkins/jenkins:2.176.1-alpine
USER root
COPY jenkins.sh /usr/local/bin/jenkins.sh
RUN apk update && apk add ansible bash sshpass\
    && chown jenkins.jenkins /usr/local/bin/jenkins.sh \
    && chmod +x /usr/local/bin/jenkins.sh
USER jenkins
