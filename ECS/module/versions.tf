terraform {
  required_version = "~> 0.11.14"
}

provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
  version = "${var.aws_version}"
}

