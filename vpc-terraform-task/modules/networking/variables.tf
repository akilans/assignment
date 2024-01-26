# region
variable "region" {
  description = "Region name"
  type        = string
}

#vpc name
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

# vpc cidr range
variable "vpc_cidr_range" {
  description = "CIDR range for vpc"
}
