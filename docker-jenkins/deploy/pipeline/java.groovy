pipeline {
	agent any
	environment { 
		def GITCODE=""
		def WWWCODE="/data/pc"
		def ANSIBLEFILE = "/etc/ansible/pc"
		def ANSIBLE_NAME = "pc"
		def JDK_OPTS="-server -Xmx2g -Xms2g -Xmn256m -XX:PermSize=128m -Xss256k -XX:+DisableExplicitGC -XX:+UseCMSCnly -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:+UseCMSCompactAtFullCollection -XX:LargePageSizeInBytes=128m -XX:+UseFastAccessorMethods -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=70"
		def LOG_CONF_FILE="logback.xml"	
	}
	stages {	
		stage('网络检查') {
			steps {
				echo "检查连通性"
				script{
					try {
						sh 'ansible -i ${ANSIBLEFILE} ${ANSIBLE_NAME} -m ping'		
					} catch (e) {
					currentBuild.result = 'FAILURE'
					throw e
					}}}
		}
		stage('拉取最新代码') {
			steps {
				script {		
					try {
						sh '''
							ansible -i ${ANSIBLEFILE} ${ANSIBLE_NAME} -m shell -a "cd $GITCODE && git pull -u origin master"
						'''
					} catch (e) {
					currentBuild.result = 'FAILURE'
					throw e
					}}}
		}
		stage('复制代码') {
			steps {
				script {
					try {
						sh '''
							ansible -i ${ANSIBLEFILE} ${ANSIBLE_NAME} -m shell -a "cp -r $GITCODE/* $WWWCODE/"
						'''		
					} catch (e) {
					currentBuild.result = 'FAILURE'
					throw e
					}}}
		}
		stage('杀掉进程') {
			steps {
				script {
					try {
						sh '''
							ansible -i ${ANSIBLEFILE} ${ANSIBLE_NAME} -m shell -a "pkill -f "java -jar""
						'''		
					} catch (e) {
					currentBuild.result = 'FAILURE'
					throw e
					}}}
		}	
		stage('重新启动') {
			steps {
				script {
					try {
						sh '''					
							ansible -i ${ANSIBLEFILE} ${ANSIBLE_NAME} -m shell -a "/usr/bin/nohup java -jar *.jar ${JDK_OPTS} --logging.config=${WWWCODE}/${LOG_CONF_FILE} &"
						'''		
					} catch (e) {
					currentBuild.result = 'FAILURE'
					throw e
					}}}
		}					
	}
}
