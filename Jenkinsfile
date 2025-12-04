pipeline {
    agent { label 'slave3' }
    triggers {
         cron '5 * * * *' 
    }
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
                sh 'mvn spring-boot:run &'

                        }
        }
    stage('Wait for 5 minutes') {
        steps {
            // Wait for 5 minutes (simulating app running)
            echo "App has been running for 5 minutes. Waiting..."
            sleep(time: 5, unit: 'MINUTES')
        }
    }
   stage('Stop Application') {
        steps {
            // Stop the Spring Boot application gracefully
            sh 'mvn spring-boot:stop'
    }
	}
    }
}
