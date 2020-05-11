#################
#    IAM user   #
#################

resource "aws_iam_user" "ecs_user" {
  name = "${var.company}_${var.product}_${var.sdlc}"
}

resource "aws_iam_user_policy_attachment" "ecs_user" {
  user       = aws_iam_user.ecs_user.name
  policy_arn = aws_iam_policy.ecs_service_role_policy.arn
}

#################
#  ECS Service  #
#################

resource "aws_iam_role" "task_service_role" {
  name               = "${var.company}-${var.product}-task-${var.sdlc}"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role_policy.json
  # aws_service_name = "ecs.amazonaws.com"
  # custom_suffix = "ECSRole-papi-${var.sdlc}"
}

data "aws_iam_policy_document" "ecs_service_policy" {
  statement {
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:*"]
    actions = [
      "logs:Create*",
      "logs:PutLogEvents",
    ]
  }
  statement {
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:Describe*",
      "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
      "elasticloadbalancing:DeregisterTargets",
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
      "elasticloadbalancing:RegisterTargets",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:CreateRepository",
      "ecr:InitiateLayerUpload",
      "ecr:DescribeRepositories",
      "ecr:CompleteLayerUpload",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:PutImage",
      "ecr:DescribeImages",
      "ecr:InitiateLayerUpload",
      "ecs:UpdateService",
    ]
  }
}

resource "aws_iam_role_policy_attachment" "ecs_service_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = aws_iam_policy.ecs_service_role_policy.arn
}

resource "aws_iam_policy" "ecs_service_role_policy" {
  name        = "ecs_service_role_policy_${var.product}_${var.sdlc}"
  description = "ECS service policy for ${var.sdlc}"
  policy      = data.aws_iam_policy_document.ecs_service_policy.json
}

resource "aws_iam_policy" "service_policy" {
  name        = "service-execution-policy_${var.product}_${var.sdlc}"
  description = "ECS service execution policy for ${var.sdlc}"
  policy      = data.aws_iam_policy_document.service_policy.json
}

data "aws_iam_policy_document" "service_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "service_policy" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:CreateTags",
    ]
    resources = ["arn:aws:ec2:*:*:network-interface/*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "ec2:AttachNetworkInterface",
      "ec2:CreateNetworkInterface",
      "ec2:CreateNetworkInterfacePermission",
      "ec2:DeleteNetworkInterface",
      "ec2:DeleteNetworkInterfacePermission",
      "ec2:Describe*",
      "ec2:DetachNetworkInterface",
      "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
      "elasticloadbalancing:DeregisterTargets",
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
      "elasticloadbalancing:RegisterTargets",
      "route53:ChangeResourceRecordSets",
      "route53:CreateHealthCheck",
      "route53:DeleteHealthCheck",
      "route53:Get*",
      "route53:List*",
      "route53:UpdateHealthCheck",
      "servicediscovery:DeregisterInstance",
      "servicediscovery:Get*",
      "servicediscovery:List*",
      "servicediscovery:RegisterInstance",
      "servicediscovery:UpdateInstanceCustomHealthStatus",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy_attachment" "service_policy" {
  role       = aws_iam_role.task_service_role.name
  policy_arn = aws_iam_policy.service_policy.arn
}

#################
# ECS Execution #
#################
resource "aws_iam_role" "ecs_execution_role" {
  name               = "${var.company}-${var.product}-execution-${var.sdlc}"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role_policy.json
}

data "aws_iam_policy_document" "ecs_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_run" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

