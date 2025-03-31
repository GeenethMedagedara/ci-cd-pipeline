pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "geemlops/test_flask/my-app:latest"
    }

    stages {
        stage('Debugging') {
            steps {
                echo "Jenkins pipeline is triggered! 🎉"
            }
        }

        stage('Build') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Test') {
            steps {
                sh "pytest tests/"
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub', url: 'https://index.docker.io/v1/']) {
                    sh "docker push ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                // Ensure kubectl is configured before running these commands
                sh "kubectl config set-context --current --namespace=default"
                sh "kubectl apply -f k8s/deployment.yaml"
                sh "kubectl apply -f k8s/service.yaml"
            }
        }
    }
}
