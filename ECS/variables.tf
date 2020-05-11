#variable "aws_region" {
#   default =   "us-west-2"
#}

variable "company" {
  description = "Comany variable for naming."
  default = "company_name"
}

variable "stage" { 
   default = "prod"
   }

variable "asg_min" {
  default = "2"
}

variable "asg_max" {
  default = "6"
}

variable "dd_api_key" {
  default = "1234567890"
}

variable "project" {
  default = "customer_project_name"
}
 
variable "product" {
  default = "specific_product"
}

variable "domain" {
  default = "example.com"
}

variable "san_domain" {
  default = ["*.example.com"]
}

variable "app_port" {
  default = "80"
}

variable "fargate_cpu" {
  default = "256"
}

variable "fargate_memory" {
  default = "512"
}

variable "app_image" {
  default = "nginx"
}
 variable "key_name" {
    default =   "root_key"
 }