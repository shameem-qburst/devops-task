pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = "django-todo-app"
        DOCKER_HUB_REPO = "shameem2001/django-todo-app:v1.0"
        SONAR_URL = "http://localhost:9000/"
        SONAR_PROJECT_KEY = "devops-task"
    }

  stages {
    stage('SonarQube Analysis (SAST)') {
      steps {
        def scannerHome = tool 'Sonarqube-scanner';
        withSonarQubeEnv(credentialsId: 'SONAR_TOKEN', installationName: 'SonarQube') {
            sh '${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=$SONAR_PROJECT_KEY -Dsonar.sources=./src -Dsonar.host.url=$SONAR_URL -Dsonar.login=$SONAR_TOKEN'
        }
      }
    }
    stage('Build Docker image from Django project') {
      steps {
        sh 'docker build -t $DOCKER_IMAGE_NAME .'
        withDockerRegistry([string(credentialsId: 'DOCKERHUB_CREDENTIALS', variable: 'DOCKERHUB_CREDENTIALS')]) {
          script {
            sh 'docker login'
          }
        sh 'docker tag $DOCKER_IMAGE_NAME $DOCKER_HUB_REPO'
        sh 'docker push $DOCKER_HUB_REPO'
        }
      }
    }
  }
}