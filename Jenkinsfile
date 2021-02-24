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
                }   
            }
        }
        
        // Extra: upload war file to artifactory.
        
        // depoly code to the testing server(tomcat) using ansible
        
        // wait for approval
        
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