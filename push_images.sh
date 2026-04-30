#!/bin/bash

# Variables
AWS_ID="291159641502"
REGION="ap-south-1"
REPO_URL="$AWS_ID.dkr.ecr.$REGION.amazonaws.com"

# 1. Login to ECR
# This uses your 'aws configure' credentials to get a temporary password
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $REPO_URL

# 2. Build and Push Flask (Assuming your folder is named 'flask_app')
cd flask_app
docker build -t flask-backend .
docker tag flask-backend:latest $REPO_URL/flask-backend:latest
docker push $REPO_URL/flask-backend:latest
cd ..

# 3. Build and Push Express (Assuming your folder is named 'express_app')
cd express_app
docker build -t express-frontend .
docker tag express-frontend:latest $REPO_URL/express-frontend:latest
docker push $REPO_URL/express-frontend:latest
cd ..

echo "--- All images pushed to ECR! ---"