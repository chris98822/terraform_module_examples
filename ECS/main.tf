data aws_caller_identity current {

module fargate_prod {
    source            = ./module
    sdlc              = prod
    stage             = var.stage
    image             = "${data.aws_caller_identity.current.account_id}.dkr.ecr.us-west-2.amazonaws.com/${var.product}-prod:latest"
    dd_image          = "${data.aws_caller_identity.current.account_id}.dkr.ecr.us-west-2.amazonaws.com/datadog:latest"
    project           = var.project
    product           = var.product
    aws_region        = us-west-2
    app_port          = var.app_port
    domain            = var.domain
    alternate_domain  = var.san_domain
    app_count         = 2
    deploy_type       = ECS
    company           = var.company
    key_name          = var.key_name
    fargate_cpu       = var.fargate_cpu
    fargate_memory    = var.fargate_memory
    app_image         = var.app_image
    ecs_iam_role      = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/ecsTaskExecutionRole"
    dd_api_key        = var.dd_api_key
    asg_min           = var.asg_min
    asg_max           = var.asg_max
    container_cpu     = 198
    container_memory  = 198

