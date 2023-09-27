pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = "django-todo-app"
        DOCKER_HUB_REPO = "shameem2001/django-todo-app:v1.0"
        SONAR_URL = "http://localhost:9000/"
        SONAR_PROJECT_KEY = "devops-task"
        DOCKERHUB_USER = "shameem2001"
    }

    stages {
        // stage('SonarQube Analysis (SAST)') {
        //     steps {
        //         script {
        //             // Use the configured SonarQube Scanner tool
        //             def scannerHome = tool name: 'Sonarqube-scanner'

        //             withSonarQubeEnv(credentialsId: 'SONAR_TOKEN', installationName: 'Sonarqube-scanner') {
        //                 sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=$SONAR_PROJECT_KEY -Dsonar.sources=./src -Dsonar.host.url=$SONAR_URL -Dsonar.login=$SONAR_TOKEN"
        //             }
        //         }
        //     }
        // }

        stage('Build Docker image from Django project') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE_NAME ./django_todo/'
                sh 'docker login -u $DOCKERHUB_USER -p Seltos@8786'
                sh 'docker tag $DOCKER_IMAGE_NAME $DOCKER_HUB_REPO'
                sh 'docker push $DOCKER_HUB_REPO'
            }
        }
    }
}
