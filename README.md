# AWS Flask & Express Deployment using Terraform

## Project Overview

This project demonstrates three different deployment approaches for a Flask backend and an Express frontend application using AWS and Terraform.

The project covers:

- Terraform Infrastructure as Code (IaC)
- AWS EC2
- Docker
- Amazon ECR
- Amazon ECS (Fargate)
- Application Load Balancer (ALB)
- Amazon VPC
- Git & GitHub

---

# Project Structure

```
aws-flask-express-terraform/
│
├── app/
│   ├── backend/
│   │   ├── app.py
│   │   ├── requirements.txt
│   │   └── Dockerfile
│   │
│   └── frontend/
│       ├── server.js
│       ├── package.json
│       ├── Dockerfile
│       └── views/
│
├── terraform-part1/
├── terraform-part2/
├── terraform-part3/
│
├── README.md
└── screenshots/
```

---

# Technologies Used

- AWS EC2
- AWS ECS (Fargate)
- Amazon ECR
- Application Load Balancer
- Amazon VPC
- Terraform
- Docker
- Python Flask
- Node.js Express
- Git
- GitHub

---

# Part 1 - Flask & Express on Single EC2

## Objective

Deploy both applications on one EC2 instance using Terraform.

### Resources Created

- EC2 Instance
- Security Group

### Configuration

- Installed Python
- Installed Node.js
- Started Flask Backend
- Started Express Frontend

### Ports

| Application | Port |
|-------------|------|
| Flask | 5000 |
| Express | 3000 |

---

# Part 2 - Separate EC2 Instances

## Objective

Deploy Flask and Express on separate EC2 instances.

### Resources Created

- VPC
- Public Subnets
- Route Tables
- Internet Gateway
- Security Groups
- Flask EC2
- Express EC2

### Communication

- Express communicates with Flask
- Security Groups allow traffic
- Applications accessible via Public IP

---

# Part 3 - Docker + AWS ECS

## Objective

Deploy both applications using Docker containers on AWS ECS Fargate.

---

## Infrastructure

Terraform creates:

- VPC
- Public Subnets
- Internet Gateway
- Route Tables
- Security Groups
- ECS Cluster
- ECS Services
- Task Definitions
- ECR Repositories
- Application Load Balancer
- Target Groups
- Listener

---

## Docker Images

### Backend

```
flask-backend
```

### Frontend

```
express-frontend
```

Both images are pushed to Amazon ECR.

---

# Deployment Steps

## Clone Repository

```bash
git clone <repository-url>
cd aws-flask-express-terraform
```

---

## Terraform

Initialize Terraform

```bash
terraform init
```

Validate

```bash
terraform validate
```

Plan

```bash
terraform plan
```

Deploy

```bash
terraform apply
```

View Outputs

```bash
terraform output
```

---

## Docker

Build Backend

```bash
docker build -t flask-backend .
```

Build Frontend

```bash
docker build -t express-frontend .
```

Login to Amazon ECR

```bash
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.ap-south-1.amazonaws.com
```

Tag Images

```bash
docker tag flask-backend:latest <backend-ecr-url>:latest

docker tag express-frontend:latest <frontend-ecr-url>:latest
```

Push Images

```bash
docker push <backend-ecr-url>:latest

docker push <frontend-ecr-url>:latest
```

---

## ECS Verification

List Clusters

```bash
aws ecs list-clusters
```

List Services

```bash
aws ecs list-services --cluster part3-cluster
```

Describe Services

```bash
aws ecs describe-services \
--cluster part3-cluster \
--services backend-service frontend-service
```

Check Target Health

```bash
aws elbv2 describe-target-health
```

---

# Application URLs

## Home Page

```
http://<ALB-DNS>
```

Example:

```
http://part3-alb-1557441204.ap-south-1.elb.amazonaws.com
```

---

## Students API

```
http://<ALB-DNS>/students
```

Example:

```
http://part3-alb-1557441204.ap-south-1.elb.amazonaws.com/students
```

---

# Verification

The following components were verified successfully:

- Terraform deployment completed
- Docker images built
- Images pushed to Amazon ECR
- ECS Cluster created
- ECS Services running
- ECS Tasks healthy
- ALB configured
- Target Groups healthy
- Backend API working
- Student records successfully stored and retrieved
- Frontend accessible through ALB

---

# Commands Used

## Terraform

```bash
terraform init
terraform validate
terraform plan
terraform apply
terraform output
terraform destroy
```

---

## Docker

```bash
docker build
docker images
docker tag
docker push
```

---

## AWS CLI

```bash
aws configure

aws ecr get-login-password

aws ecs list-clusters

aws ecs list-services

aws ecs list-tasks

aws ecs describe-services

aws elbv2 describe-target-health
```

---

## Git

```bash
git clone

git add .

git commit -m "Completed AWS Terraform Assignment"

git push origin main
```

---

# Screenshots

Include screenshots of:

- EC2 Instances
- Terraform Apply
- Terraform Output
- Docker Build
- Docker Push
- Amazon ECR
- ECS Cluster
- ECS Services
- ECS Tasks
- ALB
- Target Groups
- Application Running
- Students API Output

---

# Author

**Dilip Chaluvadi**

AWS | Terraform | Docker | ECS | DevOps
