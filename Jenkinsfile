pipeline {
  agent any
//   tools {
//     maven 'MAVEN'
//   }

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
        sh 'docker build -t django-todo-app .'
        withDockerRegistry([credentialsId: "dockerhub-credentials", url: ""]) {
          script {
            sh 'docker login -u your-dockerhub-username -p $DOCKERHUB_CREDENTIALS'
            app = docker.build("shameem2001/django-todo-app:v1.0")
          }
        }
      }
    }
  }
}