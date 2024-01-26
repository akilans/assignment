# data to fetch all az
data "aws_availability_zones" "aws_zones" {
  state = "available"
}


# create vpc
resource "aws_vpc" "myvpc" {
  cidr_block           = var.vpc_cidr_range
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}


# create subnet in each az with dynamic cidr block
resource "aws_subnet" "mysubnets" {
  for_each                = toset(data.aws_availability_zones.aws_zones.names)
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr_range, 8, index(data.aws_availability_zones.aws_zones.names, each.key))
  map_public_ip_on_launch = true
  availability_zone       = each.key
  tags = {
    Name = "subnet-${index(data.aws_availability_zones.aws_zones.names, each.key) + 1}"
  }
}

# create internet gateway and attach it to vpc
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "my-igw"
  }
}

# adding IG to default route table for the new VPC
resource "aws_default_route_table" "default_rt" {
  default_route_table_id = aws_vpc.myvpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "my-rt"
  }
}
