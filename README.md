# Todo List Application with CI/CD Pipeline

## Overview
This project is a simple Todo List application built with Node.js and Express. It includes a CI/CD pipeline implemented using PowerShell to automate the deployment process. The application is containerized using Docker and deployed to a Kubernetes cluster.

## Features
- Add, view, and delete tasks in a Todo List.
- Modern and responsive UI with a fancy delete button.
- CI/CD pipeline for automated deployment.
- Dockerized application for easy portability.
- Kubernetes deployment with dynamic image and tag management.

## Project Structure
```
todo-list-by-day/
├── app.js                  # Main application logic
├── ci-cd-pipeline.ps1     # PowerShell script for CI/CD pipeline
├── date.js                # Utility for date management
├── Dockerfile             # Docker configuration file
├── index.html             # Frontend HTML file
├── kubernetes-deployment.yaml  # Kubernetes deployment configuration
├── package.json           # Node.js dependencies
├── public/                # Static assets (CSS, JS, images)
│   └── css/
│       └── styles.css     # Styles for the application
├── views/                 # EJS templates for dynamic rendering
│   ├── footer.ejs
│   ├── header.ejs
│   └── list.ejs
└── README.md              # Project documentation
```

## Prerequisites
- Node.js and npm installed.
- Docker installed.
- Kubernetes cluster set up (e.g., Minikube, Docker Desktop, or a cloud provider).
- PowerShell installed on your system.

## Setup Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/hamzakoc/todo-list-by-day.git
cd todo-list-by-day
```

### 2. Install Dependencies
```bash
npm install
```

### 3. Run Locally
```bash
node app.js
```
Access the application at `http://localhost:3000`.

### 4. Build and Run with Docker
```bash
docker build -t hamzakoc/todo-app:latest .
docker run -p 3000:3000 hamzakoc/todo-app:latest
```

### 5. Deploy to Kubernetes
```bash
kubectl apply -f kubernetes-deployment.yaml
```

### 6. Run the CI/CD Pipeline
Run the PowerShell script to automate the deployment process:
```powershell
powershell -ExecutionPolicy Bypass -File ci-cd-pipeline.ps1
```

### 7. Access the Application
After running the CI/CD pipeline or deploying to Kubernetes, you can access the application at:
```
http://127.0.0.1:80
```

## CI/CD Pipeline Workflow
1. **Commit and Push to GitHub**: The CI/CD pipeline script commits changes to the repository and pushes them to GitHub with a new tag.
2. **Build Docker Image**: The script builds a Docker image using the same tag version as the GitHub tag.
3. **Push Docker Image**: The Docker image is pushed to Docker Hub.
4. **Update Kubernetes Deployment**: The deployment file is dynamically updated with the new Docker image and tag.
5. **Apply Kubernetes Deployment**: The updated deployment file is applied to the Kubernetes cluster.
6. **Verify Deployment**: The script verifies the status of pods and services to ensure the deployment is successful.
7. **Access the Application**: The application is accessible at `http://127.0.0.1:80`.

### How to Use the CI/CD Pipeline
1. Ensure you have the prerequisites installed (Node.js, Docker, Kubernetes, and PowerShell).
2. Clone the repository and navigate to the project directory:
   ```bash
   git clone https://github.com/hamzakoc/todo-list-by-day.git
   cd todo-list-by-day
   ```
3. Run the CI/CD pipeline script:
   ```powershell
   powershell -ExecutionPolicy Bypass -File ci-cd-pipeline.ps1
   ```
4. Once the script completes, access the application in your browser at:
   ```
   http://127.0.0.1:80
   ```

## Notes
- The `ci-cd-pipeline.ps1` script dynamically updates the Kubernetes deployment file with the correct Docker image and tag.
- The delete button in the UI has been styled to be visually appealing and user-friendly.

## Contributing
Feel free to fork this repository and submit pull requests for improvements or bug fixes.

## License
This project is licensed under the MIT License. See the LICENSE file for details.
