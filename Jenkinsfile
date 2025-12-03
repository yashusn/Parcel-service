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
                java -jar target/simple-parcel-service-app-1.0-SNAPSHOT.jar

                        }
        }
    }
}
