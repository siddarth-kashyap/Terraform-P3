resource "aws_ecr_repository" "flask_repo" {
  name                 = "flask-backend"
  image_tag_mutability = "MUTABLE"
  force_delete         = true # Allows destroy to work easily

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "express_repo" {
  name                 = "express-frontend"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }
}

output "flask_ecr_url" {
  value = aws_ecr_repository.flask_repo.repository_url
}

output "express_ecr_url" {
  value = aws_ecr_repository.express_repo.repository_url
}
#291159641502