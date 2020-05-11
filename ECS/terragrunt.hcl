 remote_state {
    backend = "s3"
    config = {
      bucket = "terragrunt-state-${get_aws_account_id()}"
      key = "${path_relative_to_include()}/terraform.tfstate"
      region = "us-east-1"
      encrypt = true
      dynamodb_table = "terragrunt-lock-${get_aws_account_id()}"
    }
  }

