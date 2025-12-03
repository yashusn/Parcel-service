pipeline {
    agent { label 'slave2' }
    stages {
        stage('Setup Environment') {
            steps {
                sh 'chmod 700 envsetup2.sh'
                sh './envsetup2.sh'
            }
        } 

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }


        stage('Build') {
            steps {
                sh 'mvn clean install' 
            }
        }

        stage('Application') { 
            steps { 
                sh 'mvn spring-boot:run'
            }
        }
    }
}
