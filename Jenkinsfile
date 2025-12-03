pipeline {
    agent { label 'slave2' }
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

stage('Application-stop') {
    steps {
        sh '''
            PID=$(ps -ef | grep SimpleParcelServiceApp | grep -v grep | awk '{print $2}')
            if [ -n "$PID" ]; then
                echo "Stopping app with PID: $PID"
                kill -9 $PID
            else
                echo "Application not running."
            fi
        '''
    }
}
    }
}
