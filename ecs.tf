# 1. The ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "assignment-cluster"
}

# 2. Flask Task Definition
resource "aws_ecs_task_definition" "flask_task" {
  family                   = "flask-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name      = "flask-app"
    image     = "291159641502.dkr.ecr.ap-south-1.amazonaws.com/flask-backend:latest"
    portMappings = [{
      containerPort = 5000 # Flask port
      hostPort      = 5000
    }]
  }])
}

# 3. Express Task Definition
resource "aws_ecs_task_definition" "express_task" {
  family                   = "express-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name      = "express-app"
    image     = "291159641502.dkr.ecr.ap-south-1.amazonaws.com/express-frontend:latest"
    portMappings = [{
      containerPort = 3000 # Express port
      hostPort      = 3000
    }]
  }])
}