# -----------------------------
# ALB Security Group
# -----------------------------
resource "aws_security_group" "alb" {

  name   = "part3-alb-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "HTTP"

    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "part3-alb-sg"
  }
}

# -----------------------------
# ECS Security Group
# -----------------------------
resource "aws_security_group" "ecs" {

  name   = "part3-ecs-sg"
  vpc_id = aws_vpc.main.id

  ingress {

    description = "ALB to ECS"

    from_port = 3000
    to_port   = 5000

    protocol = "tcp"

    security_groups = [
      aws_security_group.alb.id
    ]
  }

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "part3-ecs-sg"
  }
}
