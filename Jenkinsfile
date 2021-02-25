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
		steps{
			sh '''
				docker image build -t spring:tag1 .
				docker login -u $SERVICE_CREDS_GAURAV_USR -p $SERVICE_CREDS_GAURAV_PSW
				docker image tag spring:tag1 monika21vash/spring:tag1
				docker image push monika21vash/spring:tag1 
			'''
		}
	}
	stage("deploy in testing"){
                sh '''
                        docker context use ms
			docker service create -p 8080:8080 monika21vash/spring:tag1
                                
                '''
        }
    post{
        always{
            echo "========always========"
	    docker context use default
        }
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}
