pipeline {
  agent any
  environment {
    VERSION = "1.0.${BUILD_NUMBER}"
  }
  stages {
    stage('Checkout') {
      steps {
        git url: 'https://github.com/quarkusio/quarkus.git', branch: 'main'
      }
    }
    stage('Build') {
      steps {
        sh './scripts/build.sh ${VERSION} dev'
      }
    }
    stage('Test') {
      steps {
        sh 'cd app && ./mvnw test'
        junit '**/target/surefire-reports/*.xml'
      }
    }
    stage('Security Scan') {
      steps {
        sh './scripts/security-scan.sh'
      }
    }
    stage('Deploy to DEV') {
      steps {
        sh './scripts/deploy.sh ${VERSION} dev'
      }
    }
    stage('Deploy to PROD') {
      when {
        branch 'main'
      }
      steps {
        input message: 'Deploy to production?', ok: 'Deploy'
        sh './scripts/build.sh ${VERSION} prod'
        sh './scripts/deploy.sh ${VERSION} prod'
      }
    }
  }
  post {
    success {
      echo "✅ Build ${VERSION} finalizado com sucesso!"
    }
    failure {
      echo "❌ Build ${VERSION} falhou!"
    }
  }
}
