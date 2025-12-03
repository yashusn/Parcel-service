pipeline {
    agent any
    stages {
        stage('Setup Environment') {
            steps {
                sh 'envsetup2.sh.sh'
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
                mvn spring-boot:run
            }
        }
         stage('Application-stop') { 
            steps {
                sleep 300
                sh 'mvn spring-boot:stop'

                        }
        }
    }
}
