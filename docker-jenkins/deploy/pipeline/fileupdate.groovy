pipeline {
	agent any
	environment { 
		def GITCODE="/data/source_codes/api"
		def ConfigS="/data/source_codes/api/Config.php"	
		def ConfigD="/data/www/api/Class/Config.php"
		def WWWCODE="/data/www/api"
		def ANSIBLEFILE = "/etc/ansible/pc"
		def ANSIBLE_NAME = "api"
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
		stage('更新代码和配置文件') {
			steps {
				script {
					try {
						sh '''
							ansible -i ${ANSIBLEFILE} ${ANSIBLE_NAME} -m shell -a "cp -r $GITCODE/* $WWWCODE/"
							ansible -i ${ANSIBLEFILE} ${ANSIBLE_NAME} -m shell -a "cp -r  $ConfigS $ConfigD"							
						'''		
					} catch (e) {
					currentBuild.result = 'FAILURE'
					throw e
					}}}
		}
	}
}
