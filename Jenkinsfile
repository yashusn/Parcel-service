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

          env.ARTIFACT1 = "news-app-${branchSafe}-${env.BUILD_NUMBER}-f1.jar"
		  env.ARTIFACT2 = "news-app-${branchSafe}-${env.BUILD_NUMBER}-f2.jar"

          sh "cp /home/slave2/workspace/parcel-services-job_feature-1/target/*.jar ${env.ARTIFACT1}"
		  sh "cp /home/slave2/workspace/parcel-services-job_feature-2/target/*.jar  ${env.ARTIFACT2}"
		  
          archiveArtifacts artifacts: "${env.ARTIFACT1}.war", fingerprint: true
			archiveArtifacts artifacts: "${env.ARTIFACT2}", fingerprint: true
        }
      }
    }

    stage('Upload to JFrog') {
      steps {
        withCredentials([string(credentialsId: 'JFROG_API_KEY', variable: 'JFROG_API_KEY')]) {
          sh """
            curl -f -H "X-JFrog-Art-Api: ${JFROG_API_KEY}" \
                -T "${env.ARTIFACT1}" \
                "${JFROG_URL}/${REPO_NAME}/${env.BRANCH_NAME}/${env.ARTIFACT1}"
          """
		  sh """
            curl -f -H "X-JFrog-Art-Api: ${JFROG_API_KEY}" \
                -T "${env.ARTIFACT2}" \
                "${JFROG_URL}/${REPO_NAME}/${env.BRANCH_NAME}/${env.ARTIFACT2}"
          """
        }
      }
    }
    }
}
