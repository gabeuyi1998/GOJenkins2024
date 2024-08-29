# GOJenkins2024 Project Documentation

## Project Overview

The GOJenkins2024 project is a comprehensive DevOps solution that integrates multiple technologies to achieve a fully automated CI/CD pipeline. This project was designed to showcase advanced skills in cloud infrastructure management, automation, and container orchestration.

### Key Technologies

- **Terraform**: Used for provisioning and managing AWS resources, including EC2 instances, VPC, subnets, and security groups.
- **Jenkins**: A CI/CD tool employed to automate the build, test, and deployment processes.
- **Docker**: A platform for containerizing the Node.js application, ensuring consistency across development, testing, and production environments.
- **Kubernetes (EKS)**: Amazon's managed Kubernetes service, utilized for orchestrating containerized applications at scale.
- **AWS CLI**: A command-line interface for interacting with AWS services, enabling infrastructure management and automation.

## Directory Structure


aws-devops-training/
│
├── aws/
│   ├── main.tf
│   ├── backend.tf
│   └── variables.tf
│
├── jenkins/
│   ├── jenkins-pipeline.groovy
│   ├── jenkinsfile
│
├── docker/
│   ├── Dockerfile
│   ├── docker-compose.yml
│   ├── package.json
│   ├── app.js
│
├── kubernetes/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│
├── readme/
│   ├── README.md
│   ├── project-documentation.md
│
└── misc/
    ├── notes.txt
    ├── setup-commands.sh
    ├── Agent-success-log.png
### Explanation of Files and Directories

- **`/aws`**: Contains Terraform configuration files responsible for provisioning AWS infrastructure resources.
  - **`main.tf`**: The primary Terraform configuration file for resource provisioning.
  - **`backend.tf`**: Defines the backend configuration for storing Terraform state, typically in an S3 bucket.
  - **`variables.tf`**: Stores variables used across Terraform configurations, making the setup flexible and reusable.

- **`/jenkins`**: Contains Jenkins-related files for managing the CI/CD pipeline.
  - **`jenkinsfile`**: A Jenkins pipeline definition file that outlines the CI/CD process.
  - **`jenkins-pipeline.groovy`**: A Groovy script used within Jenkins for more complex automation tasks.

- **`/docker`**: Contains Docker-related files for containerizing the Node.js application.
  - **`Dockerfile`**: Specifies the steps required to build the Docker image for the Node.js application.
  - **`docker-compose.yml`**: Defines services, networks, and volumes for multi-container Docker applications.
  - **`package.json`**: Lists the Node.js application’s dependencies and metadata.
  - **`app.js`**: The source code for the Node.js application.

- **`/kubernetes`**: Contains Kubernetes YAML files for deploying and managing the application on an EKS cluster.
  - **`deployment.yaml`**: Kubernetes Deployment configuration for managing the application’s pods.
  - **`service.yaml`**: Kubernetes Service configuration to expose the application within the cluster.
  - **`ingress.yaml`**: Defines the Ingress resources to manage external access to the services within the Kubernetes cluster.

- **`/readme`**: Contains project documentation and notes.
  - **`README.md`**: The main project documentation file (this file).
  - **`project-documentation.md`**: Detailed documentation of the project, including setup steps and configurations.

- **`/misc`**: Miscellaneous files used during the project.
  - **`notes.txt`**: Contains miscellaneous notes and commands used during the setup.
  - **`setup-commands.sh`**: A shell script with all commands used to set up the environment.
  - **`Agent-success-log.png`**: Screenshot showing the successful connection of the Jenkins agent.

## CI/CD Pipeline Overview

### Jenkins Pipeline

The Jenkins pipeline automates the entire process from code checkout to deployment in a Kubernetes cluster. Below is the definition of the pipeline used in this project:

```groovy
pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "gojenkins2024:${env.BUILD_ID}"
        KUBECONFIG_CREDENTIALS = credentials('kubeconfig-credentials-id')
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/gabeuyi1998/GOJenkins2024.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(DOCKER_IMAGE)
                }
            }
        }
        stage('Push Docker Image to Registry') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials-id') {
                        docker.image(DOCKER_IMAGE).push()
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withCredentials([file(credentialsId: KUBECONFIG_CREDENTIALS, variable: 'KUBECONFIG')]) {
                        sh 'kubectl apply -f kubernetes/deployment.yaml'
                        sh 'kubectl apply -f kubernetes/service.yaml'
                    }
                }
            }
        }
    }
}
```

## How to Use

### SSH Access

- Use the provided SSH keys (`id_rsa_gabriel`, `id_rsa_gabrielonyijen`) to access the respective EC2 instances.

### Jenkins Pipeline

- Access Jenkins on the first EC2 instance and manage the CI/CD pipeline through the `jenkinsfile`.

### Docker Management

- Use Docker to manage containerized applications, with the Dockerfile and Compose file located in the `docker/` directory.

### Kubernetes Management

- Deploy and manage Kubernetes resources using the YAML files located in the `kubernetes/` directory.

### Terraform

- Use the `main.tf` and `backend.tf` files to manage and automate AWS infrastructure.

## Purpose and Outcome

The GOJenkins2024 project was designed to demonstrate your ability to:

- **Integrate Multiple AWS Services**: Using EC2 for computing resources, EKS for Kubernetes orchestration, and S3 for storage.
- **Automate Infrastructure**: Leveraging Terraform for IaC (Infrastructure as Code).
- **Implement CI/CD Pipelines**: Setting up Jenkins to automate the build, test, and deployment processes.
- **Manage Containers**: Using Docker for containerization and Kubernetes for orchestration.
- **Ensure Security**: Generating and managing SSH keys for secure instance communication.

## Conclusion

The GOJenkins2024 project is a testament to proficiency in cloud computing, DevOps practices, and infrastructure management. The structured approach, detailed documentation, and successful integration of multiple technologies.
