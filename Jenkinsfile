pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = "django-todo-app"
        DOCKER_HUB_REPO = "shameem2001/django-todo-app:v1.0"
        SONAR_URL = "https://66d0-111-93-116-30.ngrok-free.app/"
        SONAR_PROJECT_KEY = "devops-task"
        DOCKERHUB_USER = "shameem2001"
        KUBECONFIG = '/home/shameem/.kube/config'
    }

    stages {
        // stage('Static code analysis') {
        //     steps {
        //         script {
        //             docker.image('sonarsource/sonar-scanner-cli').inside {
        //                 stage('Sonarqube') {
        //                     withCredentials([string(credentialsId: 'SONAR_TOKEN', variable: 'SONAR_TOKEN')]) {
        //                         sh 'sonar-scanner -Dsonar.projectKey=$SONAR_PROJECT_KEY -Dsonar.sources=django_todo -Dsonar.host.url=$SONAR_URL -Dsonar.token=$SONAR_TOKEN'
        //                     }
        //                 }
        //             }
        //         }
        //     }
        // } // Success

        // stage('Analyze IAC code') {
        //     steps {
        //         // sh('pip install checkov')
        //         sh('/var/lib/jenkins/.local/bin/checkov -s -d /home/shameem/Documents/Devops_Task/Terraform/ | tee /home/shameem/Training/DevSecOps/checkov-analysis.txt')
        //     }
        // } // Success

        // stage('Build Docker image from Django project') {
        //     steps {
        //         sh 'docker build -t $DOCKER_IMAGE_NAME ./django_todo/'
        //         withCredentials([string(credentialsId: 'DOCKERHUB_PASSWORD', variable: 'DOCKERHUB_PASSWORD')]) {
        //             sh 'docker login -u $DOCKERHUB_USER -p $DOCKERHUB_PASSWORD'
        //         }
        //         sh 'docker tag $DOCKER_IMAGE_NAME $DOCKER_HUB_REPO'
        //         sh 'docker push $DOCKER_HUB_REPO'
        //     }
        // } // Success

        // EKS cluster

        stage('EKS deploying using Terraform') {
            steps {
                sh 'cd Terraform/ && terraform init'
                sh 'cd Terraform/ && terraform validate'
                sh 'cd Terraform/ && terraform plan'
            }
        } // Success

        // Deploy
        // stage('Kubernetes') {
        //     steps {
        //         sh 'export KUBECONFIG=$KUBECONFIG && kubectl apply -f ./Kubernetes/'
        //     }
        // } // Success
    }
}
