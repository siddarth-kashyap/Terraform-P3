1. Prerequisites
AWS CLI configured with appropriate permissions.

Docker Desktop installed and running.

Terraform installed.

2. Infrastructure Deployment
Initialize and apply the Terraform configuration:

Bash
terraform init
terraform apply -auto-approve
3. Docker Image Build & Push
Login to ECR and push the images (Replace <AWS_ID> with 291159641502):

Bash
# Login
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin <AWS_ID>.dkr.ecr.ap-south-1.amazonaws.com

# Build & Push Backend
cd flask_app
docker build -t flask-backend .
docker tag flask-backend:latest <AWS_ID>.dkr.ecr.ap-south-1.amazonaws.com/flask-backend:latest
docker push <AWS_ID>.dkr.ecr.ap-south-1.amazonaws.com/flask-backend:latest

# Build & Push Frontend
cd ../express_app
docker build -t express-frontend .
docker tag express-frontend:latest <AWS_ID>.dkr.ecr.ap-south-1.amazonaws.com/express-frontend:latest
docker push <AWS_ID>.dkr.ecr.ap-south-1.amazonaws.com/express-frontend:latest

Troubleshooting & Common Issues
1. Health Check "Unhealthy" Loop
If the Backend target group shows as unhealthy:

Root Route: Ensure app.py has a @app.route('/') that returns a 200 status code.

Host Binding: Flask must run on host='0.0.0.0' to accept traffic from the ALB.

Grace Period: Increase health_check_grace_period_seconds in ecs_services.tf if the app takes a long time to boot.

2. Frontend Connection Error
If the frontend cannot "see" the backend:

Update the Frontend environment variable or API URL to point to the ALB DNS Name at port 5000 (e.g., [http://app-lb-xxxx.ap-south-1.elb.amazonaws.com:5000](http://app-lb-xxxx.ap-south-1.elb.amazonaws.com:5000)).

Security
ALB Security Group: Allows public ingress on Port 80 and 5000.

ECS Security Group: Restricts ingress to only allow traffic originating from the Load Balancer.
