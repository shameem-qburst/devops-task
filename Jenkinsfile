pipeline {
  agent any
//   tools {
//     maven 'MAVEN'
//   }
    environment {
        DOCKER_IMAGE_NAME = "django-todo-app"
        DOCKER_HUB_REPO = "shameem2001/django-todo-app:v1.0"
    }

  stages {
    stage('SonarQube Analysis (SAST)') {
      steps {
        withCredentials([string(credentialsId: 'SONAR_TOKEN', variable: 'SONAR_TOKEN')]) {
          sh 'sonar-scanner -Dsonar.login=$SONAR_TOKEN -Dsonar.projectKey=devops-task -Dsonar.host.url=http://localhost:9000/'
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