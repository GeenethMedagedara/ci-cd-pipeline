pipeline {
    agent any

    environment {
        AZURE_REGISTRY = "myazurecontainerregistry.azurecr.io"
        DOCKER_IMAGE = "${AZURE_REGISTRY}/my-app:latest"
        KUBE_CONFIG_PATH = "/var/jenkins_home/.kube/config"
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

        stage('Push to Azure Container Registry') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'azure-acr', usernameVariable: 'ACR_USER', passwordVariable: 'ACR_PASSWORD')]) {
                    sh "docker login ${AZURE_REGISTRY} -u $ACR_USER -p $ACR_PASSWORD"
                    sh "docker push ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Deploy to Azure Kubernetes Service') {
            steps {
                withKubeConfig([credentialsId: 'azure-kubeconfig', serverUrl: '']) {
                    sh "kubectl apply -f k8s/deployment.yaml"
                    sh "kubectl apply -f k8s/service.yaml"
                }
            }
        }
    }
}
