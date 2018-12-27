我建议你创建一个目录存放

mkdir /data/java

而后下载compose的yaml文件

curl -Lks https://raw.githubusercontent.com/LinuxEA-Mark/java/master/jdk1.8.0_131/docker-compsoe.yaml -o /data/java/docker-compsoe.yaml

而后将jar包或者war包放在对应的位置

- 如果是jar包，请挂在到容器内的/opt/java/内。可以传递部分参数，其他参数请查看本页的启动脚本内置参数
- 如果是war包或者tomcat，请挂载到/usr/local/tomcat/webapps/目录下

而后使用`docker-compose -f  /data/java/docker-compsoe.yaml up -d`

示例：

```
    environment:
    - JAR_XMX=2048
    - JAR_XMS=1096
    volumes:
    - /etc/localtime:/etc/localtime:ro
    - /data/jdk/symphony:/usr/local/tomcat/webapps/symphony
#    - /data/jdk/symphony.war:/usr/local/tomcat/webapps   
#    - /data/jdk/helo:/opt/java
```
