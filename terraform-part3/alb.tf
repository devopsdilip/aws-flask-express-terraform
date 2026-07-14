# -----------------------------
# Application Load Balancer
# -----------------------------
resource "aws_lb" "main" {

  name               = "part3-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb.id
  ]

  subnets = [
    aws_subnet.public1.id,
    aws_subnet.public2.id
  ]

  tags = {
    Name = "part3-alb"
  }
}

# -----------------------------
# Backend Target Group
# -----------------------------
resource "aws_lb_target_group" "backend" {

  name        = "backend-tg"
  port        = 5000
  protocol    = "HTTP"
  target_type = "ip"

  vpc_id = aws_vpc.main.id

  health_check {
    path = "/students"
  }
}

# -----------------------------
# Frontend Target Group
# -----------------------------
resource "aws_lb_target_group" "frontend" {

  name        = "frontend-tg"
  port        = 3000
  protocol    = "HTTP"
  target_type = "ip"

  vpc_id = aws_vpc.main.id

  health_check {
    path = "/"
  }
}

# -----------------------------
# Listener
# -----------------------------
resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.main.arn

  port     = 80
  protocol = "HTTP"

  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.frontend.arn
  }
}

# -----------------------------
# Backend Rule
# -----------------------------
resource "aws_lb_listener_rule" "backend" {

  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  action {

    type = "forward"

    target_group_arn = aws_lb_target_group.backend.arn
  }

  condition {

    path_pattern {

      values = ["/students*"]
    }
  }
}
