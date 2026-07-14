# -----------------------------
# CloudWatch Logs
# -----------------------------
resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/flask-express"
  retention_in_days = 7
}

# -----------------------------
# ECS Cluster
# -----------------------------
resource "aws_ecs_cluster" "main" {
  name = "part3-cluster"
}

# -----------------------------
# Backend Task Definition
# -----------------------------
resource "aws_ecs_task_definition" "backend" {

  family                   = "backend-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = "256"
  memory = "512"

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "backend"
      image = "${aws_ecr_repository.backend.repository_url}:latest"

      essential = true

      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "backend"
        }
      }
    }
  ])
}

# -----------------------------
# Frontend Task Definition
# -----------------------------
resource "aws_ecs_task_definition" "frontend" {

  family                   = "frontend-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = "256"
  memory = "512"

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "frontend"
      image = "${aws_ecr_repository.frontend.repository_url}:latest"

      essential = true

      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]

      environment = [
        {
          name  = "BACKEND_URL"
          value = "http://${aws_lb.main.dns_name}"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "frontend"
        }
      }
    }
  ])
}

# -----------------------------
# Backend Service
# -----------------------------
resource "aws_ecs_service" "backend" {

  name            = "backend-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.backend.arn

  desired_count = 1
  launch_type   = "FARGATE"

  network_configuration {

    subnets = [
      aws_subnet.public1.id,
      aws_subnet.public2.id
    ]

    security_groups = [
      aws_security_group.ecs.id
    ]

    assign_public_ip = true
  }

  load_balancer {

    target_group_arn = aws_lb_target_group.backend.arn

    container_name = "backend"

    container_port = 5000
  }

  depends_on = [
    aws_lb_listener.http
  ]
}

# -----------------------------
# Frontend Service
# -----------------------------
resource "aws_ecs_service" "frontend" {

  name            = "frontend-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.frontend.arn

  desired_count = 1
  launch_type   = "FARGATE"

  network_configuration {

    subnets = [
      aws_subnet.public1.id,
      aws_subnet.public2.id
    ]

    security_groups = [
      aws_security_group.ecs.id
    ]

    assign_public_ip = true
  }

  load_balancer {

    target_group_arn = aws_lb_target_group.frontend.arn

    container_name = "frontend"

    container_port = 3000
  }

  depends_on = [
    aws_lb_listener.http
  ]
}
