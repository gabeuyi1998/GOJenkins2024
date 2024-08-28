# GOJenkins2024 Project

This project demonstrates the creation and deployment of a CI/CD pipeline using Jenkins, Docker, Kubernetes (EKS), and Terraform. The pipeline automates the deployment of a Node.js application to an AWS infrastructure.

## Project Overview

The project consists of:

- **Terraform**: Used for provisioning AWS resources such as EC2 instances, VPC, subnets, and security groups.
- **Jenkins**: CI/CD tool used to automate the pipeline.
- **Docker**: Containerization platform for the Node.js application.
- **Kubernetes (EKS)**: Managed Kubernetes service on AWS used for orchestrating containerized applications.
- **AWS CLI**: Command-line tool to interact with AWS services.

## Directory Structure

- `/aws`: Contains Terraform configuration files.
- `/node_modules`: Node.js dependencies.
- `.gitignore`: Files and directories to be ignored by Git.
- `Dockerfile`: Instructions to build the Docker image.
- `app.js`: Node.js application source code.
- `deployment.yaml`: Kubernetes deployment configuration.
- `service.yaml`: Kubernetes service configuration.
- `README.md`: Project documentation (this file).

## CI/CD Pipeline Overview

### Jenkins Pipeline

The Jenkins pipeline is defined as follows:

```groovy
pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/gabeuyi1998/GOJenkins2024.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("gojenkins2024:${env.BUILD_ID}")
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    kubectl.apply('-f k8s-deployment.yml')
                }
            }
        }
    }
}