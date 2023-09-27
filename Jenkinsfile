pipeline {
    agent any
    tools {
        maven 'MAVEN'
    }
    environment {
        DOCKER_IMAGE_NAME = "django-todo-app"
        DOCKER_HUB_REPO = "shameem2001/django-todo-app:v1.0"
        SONAR_URL = "http://localhost:9000/"
        SONAR_PROJECT_KEY = "devops-task"
    }

  stages {
    stage('SonarQube Analysis (SAST)') {
      steps {
        withCredentials([string(credentialsId: 'SONAR_TOKEN', variable: 'SONAR_TOKEN')]) {
          sh 'mvn -Dmaven.test.failure.ignore verify sonar:sonar -Dsonar.login=$SONAR_TOKEN -Dsonar.projectKey=$SONAR_PROJECT_KEY -Dsonar.host.url=$SONAR_URL'
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