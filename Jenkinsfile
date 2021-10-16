pipeline {
    agent any
    tools {
        maven 'maven-3.8.3' 
    }
    stages {
        stage('Clone') {
            steps {
                //sh git clone "url" 
                git 'https://github.com/coolgourav147/spring-boot-war-example.git'
            }
        }
        stage('Build') {
            steps {
                echo 'Build'
                sh 'mvn package'
            }
        }
        stage('Deploy On Test') {
            steps {
                deploy adapters: [tomcat9(credentialsId: 'tomcatpass', path: '', url: 'http://3.108.236.252:8080')], contextPath: '/app', war: '**/*.war'
                echo 'Deploy on test'
            }
        }
        stage('Confirmation') {
            input {
                    message "Should we continue?"
                    ok "Yes, we should."
            }
            steps {
                echo " "
            }
        }
        stage('Deploy On Prod') {
            steps {
                deploy adapters: [tomcat9(credentialsId: 'tomcatpass', path: '', url: 'http://13.233.27.62:8080')], contextPath: '/app', war: '**/*.war'
                echo 'deploy on prod'
            }
        }
    }
    
}
