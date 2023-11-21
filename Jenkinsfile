pipeline {
  agent {
    docker {
      image 'ubuntu'
    }

  }
  stages {
    stage('Checkout Code') {
      steps {
        checkout scm
      }
    }

    stage('Initialize Terraform') {
      steps {
        bat 'terraform init'
      }
    }

    stage('Terraform Apply') {
      steps {
        withCredentials(bindings: [file(credentialsId: 'GOOGLE_APPLICATION_CREDENTIAL', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
          bat 'terraform apply -auto-approve'
        }

      }
    }

    stage('Clean Up') {
      steps {
        input 'Destroy data science infra?'
        withCredentials(bindings: [file(credentialsId: 'GOOGLE_APPLICATION_CREDENTIAL', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
          bat 'terraform destroy -auto-approve'
        }

      }
    }

  }
  post {
    success {
      echo 'Dataproc cluster provisioned successfully!'
    }

    failure {
      echo 'Failed to provision the Dataproc cluster.'
    }

  }
}