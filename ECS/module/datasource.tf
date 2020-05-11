data "aws_caller_identity" "current" {
}

### Subnets
data "aws_subnet" "private-az1" {
  filter {
    name   = "tag:Name"
    values = ["${var.stage}-vpc-private-${var.aws_region}a"]
  }
}

data "aws_subnet" "private-az2" {
  filter {
    name   = "tag:Name"
    values = ["${var.stage}-vpc-private-${var.aws_region}b"]
  }
}

data "aws_subnet" "private-az3" {
  filter {
    name   = "tag:Name"
    values = ["${var.stage}-vpc-private-${var.aws_region}c"]
  }
}

data "aws_subnet" "public-az1" {
  filter {
    name   = "tag:Name"
    values = ["${var.stage}-vpc-public-${var.aws_region}a"]
  }
}

data "aws_subnet" "public-az2" {
  filter {
    name   = "tag:Name"
    values = ["${var.stage}-vpc-public-${var.aws_region}b"]
  }
}

data "aws_subnet" "public-az3" {
  filter {
    name   = "tag:Name"
    values = ["${var.stage}-vpc-public-${var.aws_region}c"]
  }
}

### VPC
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.stage}-vpc"]
  }
}

