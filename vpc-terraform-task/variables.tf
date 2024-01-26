# region
variable "region" {
  description = "Region name"
  type        = string
  default     = "ap-south-1"
}

#vpc name
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "my-vpc"
}

# vpc cidr range
variable "vpc_cidr_range" {
  description = "CIDR range for vpc"
  type        = string
  default     = "10.0.0.0/16"
}

