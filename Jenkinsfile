pipeline {
    agent { label 'slave3' }
    stages {
        stage('Setup Environment') {
            steps {
                sh 'chmod 700 Envsetup.sh'
                sh './Envsetup.sh'
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
