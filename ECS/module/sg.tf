resource "aws_security_group" "lb" {
  name        = "${var.company}-${var.product}-alb-sg-${var.sdlc}"
  description = "controls access to the ALB"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "tcp"
    from_port   = var.app_port
    to_port     = var.app_port
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "${var.company}-${var.product}-alb-sg-${var.sdlc}"
    Company   = var.company
    Product   = "${var.product}-alb-Security Group"
    Program   = var.project
    SDLC      = var.sdlc
    Terraform = "true"
  }
}

# Traffic to the ECS Cluster should only come from the ALB
resource "aws_security_group" "ecs_tasks" {
  name        = "${var.company}-${var.product}-tasks-sg-${var.sdlc}"
  description = "allow inbound access from the ALB only"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    protocol        = "tcp"
    from_port       = var.app_port
    to_port         = var.app_port
    security_groups = [aws_security_group.lb.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "${var.company}-${var.product}-tasks-sg-${var.sdlc}"
    Company   = var.company
    Product   = "${var.product}-ecs-Security Group"
    Program   = var.project
    SDLC      = var.sdlc
    Terraform = "true"
  }
}

