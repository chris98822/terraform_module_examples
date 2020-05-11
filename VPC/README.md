# VPC Module 

## Summary
The main.tf file in the root of this directory is the recipe file. It holds the variables and options set for the specific VPC being deployed. This recipe file will call the module and apply it's specific values to create the required resources.

The module itself will be responsible for creating a fully functional and featured VPC. The module follows AWS' recommendation for a Well Architected Framework.

The module folder contains both terraform 0.11.x and 0.12.x compatible versions.

## Created Resources
- VPC
- DHCP Options set
- Internet Gateway
- NAT Gateway
- Public and private routes
- All other require rout table associations
- Public and Private Subnets (3 AZs)
- Optional Subnets for ElasticCache/Search, Redshift and/or Databases
- Optional VPC Endpoints for S3 & DynamoDB
- Optional VPN Gateway