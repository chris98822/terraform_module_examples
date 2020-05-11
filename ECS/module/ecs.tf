### ECS

resource "aws_ecs_cluster" "main" {
  name = "${var.company}-${var.product}-cluster-${var.sdlc}"
}

resource "aws_ecs_service" "main" {
  name            = "${var.product}-service-${var.sdlc}"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  #add deploy controller
  deployment_controller {
    type = var.deploy_type
  }

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = [data.aws_subnet.private-az1.id, data.aws_subnet.private-az2.id, data.aws_subnet.private-az3.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.app.id
    container_name   = "${var.product}-app-${var.sdlc}"
    container_port   = var.app_port
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = "${var.product}-app-${var.sdlc}"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.task_service_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory

  container_definitions = <<DEFINITION
[
  {
    "image": "${var.image}",
    "cpu": ${var.container_cpu},
    "memory": ${var.container_memory},
    "name": "${var.product}-app-${var.sdlc}",
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": ${var.app_port},
        "hostPort": ${var.app_port}
      }
    ],
    "environment": [
      { 
        "name" : "NODE_ENV", 
        "value" : "${var.sdlc}" 
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-region": "${var.aws_region}",
        "awslogs-group": "/ecs/${var.company}-${var.product}-app-${var.sdlc}",
        "awslogs-stream-prefix": "${var.product}"
      }
    }
  }
]
DEFINITION

}

resource "aws_ecr_repository" "ecr" {
  name = "${var.product}-${var.sdlc}"
}

