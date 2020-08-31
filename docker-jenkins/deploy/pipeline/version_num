pipeline {
	agent any
	parameters { string(defaultValue: '', name: 'GIT_TAG', description: '请直接输入版本号:' ) }
	environment { 
	def ANSIBLEFILE = "/etc/ansible/net-new"
	def ANSIBLE_NAME = "net_new"
	def DESTPATH = "/data/wwwroot/new/"
	}
	stages {	
		stage('网络检查') {
			steps {
				echo "检查连通性"
				script{
					try {
						sh 'ansible  -i ${ANSIBLEFILE} ${ANSIBLE_NAME}  -m ping'		
					} catch (e) {
					currentBuild.result = 'FAILURE'
					throw e
					}}}}
		stage('拉取最新代码') {
			steps {
				script {		
					try {
						sh '''
							if [ ! -n "$GIT_TAG" ];then
								echo "请输入版本号"
								exit 1
							else
								ansible  -i ${ANSIBLEFILE} ${ANSIBLE_NAME} -m shell -a "chattr -R -i  /data/wwwroot/new/"
								ansible  -i ${ANSIBLEFILE} ${ANSIBLE_NAME} -m shell -a "cd $DESTPATH && git pull origin master && git checkout $GIT_TAG"
			          ansible  -i ${ANSIBLEFILE} ${ANSIBLE_NAME} -m shell -a "chown -R 400.400 $DESTPATH"
								ansible  -i ${ANSIBLEFILE} ${ANSIBLE_NAME} -m shell -a "chattr -R +i  /data/wwwroot/new/"
							fi
						'''
							
					} catch (e) {
					currentBuild.result = 'FAILURE'
					throw e
					}}}}						
		}	
}
