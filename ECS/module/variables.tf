variable "company" {
  description = "Comany variable for naming."
}

variable "sdlc" {
  description = ""
}

variable "stage" {
  description = ""
}

variable "project" {
  description = "Project description"
}

variable "product" {
  description = "Product this is building"
}

variable "aws_region" {
  description = "The AWS region to create things in."
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
}

variable "app_count" {
  description = "Number of docker containers to run"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
}

variable "ecs_iam_role" {
  description = "ECS task execution role name"
  default     = ""
}

variable "ecs_auto_scale_role_name" {
  description = "ECS auto scale role Name"
  default     = "AWSServiceRoleForAutoScaling"
}

variable "health_check_path" {
  default = "/"
}

variable "cert_arn" {
  default = "arn::"
}

variable "dd_api_key" {
  description = "API key to use to connect the Datadog agent to our Datadog account"
}

variable "asg_min" {
  description = "The minimum count that should be available in the autoscaling group"
}

variable "asg_max" {
  description = "The maximum count that should be available in the autoscaling group"
}

variable "domain" {
  description = "The domain name you are requesting the certificate for"
}

variable "alternate_domain" {
  description = "The additional domain name you are requesting the certificate for"
  type        = list(string)
  default     = []
}

variable "image" {
  description = "Fargate image location"
}

variable "dd_image" {
  description = "Datadog image"
}

variable "container_cpu" {
  description = "This is the container CPU units to provision (1 vCPU = 1024 CPU units)."
}

variable "container_memory" {
  description = "This is the container memory to provision (in MiB)."
}

variable "deploy_type" {
  description = "the type of deployment method - code_deploy or ECS"
  default     = "ECS"
}

