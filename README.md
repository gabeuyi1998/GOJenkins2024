# AWS Infrastructure and CI/CD Pipeline Setup

## Overview

This project demonstrates the setup of AWS infrastructure using Terraform, including EC2 instances, VPCs, subnets, security groups, and the configuration of Jenkins, Docker, and Kubernetes (EKS) for a CI/CD pipeline.

## Table of Contents

- [Infrastructure Components](#infrastructure-components)
- [CI/CD Pipeline](#cicd-pipeline)
- [File Descriptions](#file-descriptions)
- [Usage Instructions](#usage-instructions)
- [Next Steps](#next-steps)

## Infrastructure Components

1. **VPC**: `vpc-0dfe4361091cc28f3`
   - Provides an isolated network environment for all AWS resources.

2. **Subnets**:
   - `GO-Dev-public1-subnet` (CIDR: 12.0.2.0/24)
   - `GO-Dev-public2-subnet` (CIDR: 12.0.3.0/24)

3. **Security Groups**:
   - `GO-SG-Proj1`: Controls inbound and outbound traffic.

4. **EC2 Instances**:
   - `GO-Jenkins-Master-EC2` (AMI: ami-0892a9c01908fafd1, t3.medium)
   - `GO-DEV1-EC2` (AMI: ami-0892a9c01908fafd1, t2.micro)

5. **S3 Bucket**:
   - `go-lambda-s3`: Used for storing Terraform state files.

6. **DynamoDB Table**:
   - `GO-TFState-table`: Used for state locking and consistency checks.

## CI/CD Pipeline

1. **Jenkins**:
   - Installed on `GO-Jenkins-Master-EC2`.
   - Orchestrates the CI/CD pipeline.

2. **Docker**:
   - Used to containerize the application.

3. **Kubernetes (EKS)**:
   - Deployed for managing Docker containers.

4. **Terraform Backend Configuration**:
   - **S3 Backend**: Stores Terraform state.
   - **DynamoDB Table**: Manages state locking.

## File Descriptions

1. **`main.tf`**:
   - Contains Terraform configurations for AWS resources.

2. **`backend.tf`**:
   - Configures remote state storage with S3 and DynamoDB.

3. **`Dockerfile`**:
   - Defines the Docker image for the Jenkins pipeline.

4. **`jenkinsfile`**:
   - Jenkins pipeline script for automating the deployment process.

## Usage Instructions

1. **Initialize Terraform**:
   ```bash
   terraform init