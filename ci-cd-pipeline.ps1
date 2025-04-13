# PowerShell script to automate CI/CD pipeline for the application

# Step 1: Define variables
$dockerImage = "hamzakoc/todo-app"
$tag = "v1.1.8"  # Update this tag dynamically if needed
$deploymentFile = "kubernetes-deployment.yaml"

# Step 2: Commit changes and push to GitHub with a new tag
Write-Host "Committing changes and pushing to GitHub..."
git add .
git commit -m "Automated CI/CD pipeline update with tag $tag"
git tag $tag
git push origin main --tags


Write-Host "GitHub push completed successfully."

# Step 3: Build the Docker image
# Pass the tag dynamically to the Docker build command
Write-Host "Building Docker image with dynamic tag..."
docker build --build-arg TAG=$tag -t "${dockerImage}:${tag}" .

# Step 4: Push the Docker image to Docker Hub
Write-Host "Pushing Docker image to Docker Hub..."
docker push "${dockerImage}:${tag}"

# Step 5: Create or update the ConfigMap for dynamic values
Write-Host "Creating or updating ConfigMap..."
kubectl create configmap deployment-config --from-literal=dockerImage=$dockerImage --from-literal=tag=$tag --dry-run=client -o yaml | kubectl apply -f -

# Backup the original deployment file with placeholders
$originalDeploymentFile = "$deploymentFile.original"
if (-Not (Test-Path $originalDeploymentFile)) {
    Write-Host "Creating a backup of the original deployment file..."
    Copy-Item $deploymentFile $originalDeploymentFile
}

# Restore the deployment file to its original state with placeholders
Write-Host "Restoring the deployment file to its original state..."
Copy-Item $originalDeploymentFile $deploymentFile -Force

# Replace placeholders in the deployment file with actual values
Write-Host "Replacing placeholders in the deployment file with actual values..."
(Get-Content $deploymentFile) -replace "\$\{DOCKER_IMAGE\}", "$dockerImage" -replace "\$\{TAG\}", "$tag" | Set-Content $deploymentFile

# Step 6: Apply the Kubernetes deployment
Write-Host "Applying Kubernetes deployment..."
kubectl apply -f $deploymentFile

# Step 7: Verify the deployment
Write-Host "Verifying deployment..."
kubectl get pods
kubectl get services

# Step 8: Restore the deployment file to its original state
Write-Host "Restoring the deployment file to its original state..."
Copy-Item $originalDeploymentFile $deploymentFile -Force
Write-Host "Deployment file restored to its original state with placeholders."

Write-Host "CI/CD pipeline completed successfully."
