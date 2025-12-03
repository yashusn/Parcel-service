pipeline {
    agent { label 'slave3' }
    stages {
        stage('Setup Environment') {
            steps {
                sh 'Env_setup.sh'
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
