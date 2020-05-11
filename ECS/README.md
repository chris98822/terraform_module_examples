# ECS Module Example

## Summary
This module example showcases the orginizational structure of provisioning an ECS cluster. It provides a complete solution in a flexible and readable way.
This particular example is configured to provision Fargate but may be easily modified to EC2-hosted or, provide options for either with a variable passed in from the recipe file.

This module is currently written to support Terraform 0.12.x but, also has a 0.11.x version as well.

# Provisioned Resources
- ECS Fargate Cluster
- ECS Fargate Service
- ECS Fargate Task Definition
- ECR Repo
- Application Load Balancer
- ACM Certificate
- Default AutoScaling Rules
- IAM policies for resource permissions
- Default Logging
- Security Groups

# Naming Standards
All provisioned resources follow a specific naming scheme for easy access and automated deployment consistancy.
Resource names will use hyphens "-" instead of underscores to comply with AWS naming requirements on some resources (some items must be DNS-compliant)

Naming looks like this: ${var.company}-${var.product}-<resource>-${var.sdlc}

Examples:
- ECS Cluster:  company-product-cluster-prod
- Load Balancer Sec. Group: company-product-alb-sg-prod