terraform {

  backend "s3" {
    bucket         = "akilan-terraform-vpc-task"
    key            = "terraform-vpc-task"
    region         = "ap-south-1"
    dynamodb_table = "akilan-terraform-vpc-task-state"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}
