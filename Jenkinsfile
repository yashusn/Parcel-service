pipeline {

    agent { label 'slave3' }
    triggers {
         cron '5 * * * *' 
    }
    	environment {
    JFROG_URL = 'https://yashusn.jfrog.io/artifactory'
    REPO_NAME = 'parcelservice-libs-snapshot'      // JFrog repo for feature branches
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

		stage('Create Versioned Artifact') {
      steps {
        script {
          def branchSafe = env.BRANCH_NAME.replaceAll('[^a-zA-Z0-9_.-]', '_')
          env.ARTIFACT = "parcel-services-${branchSafe}-${env.BUILD_NUMBER}-${sha}.jar"

          sh "cp /home/ubuntu/workspace/parcel-services-job_main/target/*.jar ${env.ARTIFACT}"
          archiveArtifacts artifacts: "${env.ARTIFACT}", fingerprint: true
        }
      }
    }
          stage('Upload to JFrog') {
      steps {
        withCredentials([string(credentialsId: 'JFROG_API_KEY', variable: 'JFROG_API_KEY')]) {
          sh """
            curl -f -H "X-JFrog-Art-Api: ${JFROG_API_KEY}" \
                -T "${env.ARTIFACT}" \
                "${JFROG_URL}/${REPO_NAME}/${env.BRANCH_NAME}/${env.ARTIFACT}"
          """
        }
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
