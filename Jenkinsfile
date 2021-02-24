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

        stage("build and push image"){
environment {
				Name1 = "Saurav"
				SERVICE_CREDS_GAURAV = credentials('dockerID')
			}          
  steps {
                sh ''' 
               # ansible-playbook -i inventory.ini ansible.yml
docker image build -t spring:tag1 .
	docker login -u $SERVICE_CREDS_GAURAV_USR -p $SERVICE_CREDS_GAURAV_PSW
				docker image tag image1:tag1 monika21vash/spring:tag1
				docker image push monika21vash/spring:tag1 
				'''
         }
        }
        
        // Extra: upload war file to artifactory.
        
        // depoly code to the testing server(tomcat) using ansible
        
        // wait for approva
        
        // deploy code to production server(tomcat) using ansible.

        // send message to the slack.        
    }
    post{
        always{
            echo "========always========"
        }
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}
