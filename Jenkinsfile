pipeline{
    agent "any"
    stages{
        // clone code from git.
        
        // create a build.
        stage("Build"){
            steps{
                sh '''ls'''
                withMaven(maven: 'example-maven-name') {
                    // some block
                    echo "========Build code.========"
                    sh ''' mvn clean install'''
                    sh '''ls'''
                    slackSend channel: 'jenkinsdemo', message: 'build successfull', teamDomain: 'crgaurav', tokenCredentialId: 'slack'
                }   
            }
        }

	stage("createImage and Push"){
		environment {
				Name1 = "Saurav"
				SERVICE_CREDS_GAURAV = credentials('dockerID')
		}
		steps{
			sh '''
				docker image build -t spring:${BUILD_ID} .
				docker login -u $SERVICE_CREDS_GAURAV_USR -p $SERVICE_CREDS_GAURAV_PSW
				docker image tag spring:${BUILD_ID} monika21vash/spring:${BUILD_ID}
				docker image push monika21vash/spring:${BUILD_ID} 
                docker image ls
			'''
		}
	}
	stage("deploy in testing"){
		steps{
                	sh '''
                        	docker context use testing
				            docker service create -p 8080:8080 --name testjavaapp --replicas=5 monika21vash/spring:${BUILD_ID} || docker service update --image monika21vash/spring:${BUILD_ID} testjavaapp
                        '''
		}
        }
    }
    stage("deploy in productions"){
		steps{
                	sh '''
                        	docker context use prod
				            docker service create -p 8080:8080 --name testjavaapp --replicas=5 monika21vash/spring:tag1 || docker service update --image monika21vash/spring:tag1 testjavaapp
                        '''
		}
        }
    }

    post{
        always{
            echo "========always========"
	    sh '''
		docker context use default
        	'''
	}
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}
