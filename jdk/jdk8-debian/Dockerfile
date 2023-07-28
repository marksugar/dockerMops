# Base image
# registry.cn-hangzhou.aliyuncs.com/marksugar/jdk:8u202-debian-stable-20230725
FROM 	uhub.service.ucloud.cn/marksugar-k8s/debian:stable-20230725

LABEL maintainer="marksugar @ www.linuxea.com"
# https://repo.huaweicloud.com/java/jdk
COPY  ./curl /bin/curl
ENV LC_ALL=C \
    LANGUAGE="zh_CN:zh" \
    LC_CTYPE="zh_CN.UTF-8" \
    LANG="zh_CN.UTF-8" \
    JAVA_VERSION=8 \
    JAVA_UPDATE=202 \
    JAVA_UPDATE_SMALL_VERSION=08 \
    JAVA_BASE_URL=https://download.oracle.com/otn-pub/java \
    JAVA_BASE_MIRRORS_URL=https://repo.huaweicloud.com/java \
    GLIBC_BASE_URL=https://github.com/sgerrand/alpine-pkg-glibc/releases/download \
    GLIBC_PACKAGE_VERSION=2.31-r0 \
    JAVA_HOME=/opt/java \
    PATH=$PATH:${JAVA_HOME}/bin \
    USER_HOME_DIR="/root"



RUN mkdir -p /opt/java \
    && chmod +x /bin/curl \
    && cd /tmp \
    && curl -Lk4 "${JAVA_BASE_MIRRORS_URL}/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_UPDATE_SMALL_VERSION}/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" |tar xz -C "${JAVA_HOME}"  \
    #&& tar -xzf "jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" -C "${JAVA_HOME}" --strip-components=1 \
    && ln -s ${JAVA_HOME}/bin/* /usr/bin/ \
    && rm -rf /etc/localtime \
    && cp /usr/share/zoneinfo/right/Asia/Shanghai  /etc/localtime 

ENV JAVA_HOME /opt/java/jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:$JAVA_HOME/bin

CMD ["java","-c","-version"]