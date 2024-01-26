# This module creates 
# VPC
# Subnets in all AZs
# Internet Gateway
# Attach IG to default route table
module "vpc_module" {
  source         = "./modules/networking"
  region         = var.region
  vpc_name       = var.vpc_name
  vpc_cidr_range = var.vpc_cidr_range
}
