# -----------------------------
# Backend ECR
# -----------------------------
resource "aws_ecr_repository" "backend" {

  name = "flask-backend"

  image_scanning_configuration {
    scan_on_push = true
  }

  force_delete = true

  tags = {
    Name = "backend-ecr"
  }
}

# -----------------------------
# Frontend ECR
# -----------------------------
resource "aws_ecr_repository" "frontend" {

  name = "express-frontend"

  image_scanning_configuration {
    scan_on_push = true
  }

  force_delete = true

  tags = {
    Name = "frontend-ecr"
  }
}
