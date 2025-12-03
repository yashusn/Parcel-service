pipeline {
  agent { label 'slave3' }
	environment {
    JFROG_URL = 'https://yashusn.jfrog.io/artifactory'
    REPO_NAME = 'parcelservice-libs-snapshot'      // JFrog repo for feature branches
  }
	stages {
	 stage('Create Versioned Artifact') {
      steps {
        script {
          def branchSafe = env.BRANCH_NAME.replaceAll('[^a-zA-Z0-9_.-]', '_')

          env.ARTIFACT = "parcel-services-${branchSafe}-${env.BUILD_NUMBER}"
		  
			sh "ls /home/slave2/workspace/parcel-services-job_feature-1/target/*.jar
          sh "cp /home/slave2/workspace/parcel-services-job_feature-1/target/*.jar ${env.ARTIFACT}-f1.jar"
		  sh "cp /home/ubuntu/workspace/parcel-services-job_feature-2/target/*.jar ${env.ARTIFACT}-f2.jar"
		  
          archiveArtifacts artifacts: "${env.ARTIFACT}-f1.jar", fingerprint: true
			archiveArtifacts artifacts: "${env.ARTIFACT}-f2.jar", fingerprint: true
        }
      }
    }

    stage('Upload to JFrog') {
      steps {
        withCredentials([string(credentialsId: 'JFROG_API_KEY', variable: 'JFROG_API_KEY')]) {
          sh """
            curl -f -H "X-JFrog-Art-Api: ${JFROG_API_KEY}" \
                -T "${env.ARTIFACT}-f1.jar" \
                "${JFROG_URL}/${REPO_NAME}/${env.BRANCH_NAME}/${env.ARTIFACT}-f1.jar"
          """
		  sh """
            curl -f -H "X-JFrog-Art-Api: ${JFROG_API_KEY}" \
                -T "${env.ARTIFACT}-f2.jar" \
                "${JFROG_URL}/${REPO_NAME}/${env.BRANCH_NAME}/${env.ARTIFACT}-f2.jar"
          """
        }
      }
    }
    }
}
