# Task Manager Project

This project allows you to efficiently manage your daily tasks by providing a complete set of CRUD (Create, Read, Update, Delete) operations. The application is built using **MongoDB**, **Node.js**, and **Express.js**, offering a simple environment for managing your tasks. Additionally, it integrates **AWS**, **Terraform**, and **Docker** for infrastructure provisioning, deployment, and scalability.

## Project Architecture

The Task Manager project has the following key components:

### Frontend
- **React.js**: A simple, user-friendly interface for managing tasks.

### Backend
- **Node.js** with **Express.js**: Handles the core business logic and API requests for task management.
- **MongoDB**: A NoSQL database used for storing tasks.

### Infrastructure as Code
- **Terraform**: Provision infrastructure on AWS, including setting up EC2 instances, VPC, and networking.

### Deployment & CI/CD
- **AWS EC2**: Hosts the backend application on an EC2 instance.
- **Docker**: The backend is containerized using Docker for easy deployment and scaling.
- **GitHub Actions**: Automates the CI/CD pipeline, handling deployment to AWS EC2 and infrastructure provisioning using Terraform.

## Tools Used

- **MongoDB**: Database for storing task data.
- **Node.js**: Backend server and application logic.
- **Express.js**: Web framework for building REST APIs.
- **Terraform**: For provisioning and managing AWS infrastructure as code.
- **Docker**: Containerizes the application for deployment.
- **GitHub Actions**: Automates the CI/CD pipeline for continuous integration and delivery.
- **AWS EC2**: Cloud infrastructure to host the application.
- **AWS ECR**: Stores the Docker image used for deploying the backend.

## Getting Started

To get started with the Task Manager application, follow these steps:

1. Clone the repository to your local machine.

    ```bash
    git clone https://github.com/Saayem123/TO_DO-app.git
    cd TO_DO
    ```

2. Install the necessary dependencies:

    ```bash
    npm install
    ```

3. Set up environment variables for your MongoDB connection and server configuration. Create a `.env` file and include the following:

    ```env
    SERVER_PORT=5000
    MONGODB_CONNECTION_URL=your-mongodb-connection-url
    AWS_ACCESS_KEY_ID=your-aws-access-key-id
    AWS_SECRET_ACCESS_KEY=your-aws-secret-access-key
    AWS_REGION=your-aws-region
    ```

4. Run the application locally:

    ```bash
    npm start
    ```

    This will start the server on the specified port, and you can interact with the application via the API.

## API Documentation

Explore the application's functionality by utilizing the provided endpoints. The documentation outlines each endpoint's purpose and how to use it effectively. Please refer to the [API Documentation](https://documenter.getpostman.com/view/28416524/2s9Xy2QCRK) for detailed information.

## Terraform Setup

To provision the infrastructure and deploy the backend application, Terraform is used to manage AWS resources. The following resources are created:

- **EC2 Instance**: Hosts the backend application.
- **VPC**: Ensures secure and isolated networking for the EC2 instance.
- **Security Group**: Configures rules to allow SSH and HTTP access to the EC2 instance.

### Terraform Configuration

To apply the Terraform configuration:

1. Initialize Terraform:

    ```bash
    terraform init
    ```

2. Plan the Terraform changes:

    ```bash
    terraform plan
    ```

3. Apply the Terraform configuration to create the resources:

    ```bash
    terraform apply
    ```

4. Terraform will output the public IP address of the EC2 instance once the resources are created.

## CI/CD Pipeline

The project utilizes **GitHub Actions** for continuous integration and deployment. The pipeline consists of two main steps:

1. **Provision Infrastructure with Terraform**: The workflow applies Terraform configurations to provision AWS EC2 instances and other necessary resources.
2. **Deploy Application to EC2**: The Dockerized Node.js backend is deployed to the EC2 instance using SSH and Docker commands. The application Docker image is pulled from **AWS ECR**.
