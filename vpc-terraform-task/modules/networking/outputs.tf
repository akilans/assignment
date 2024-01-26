# vpc id id
output "vpc_id" {
  description = "vpc id"
  value       = aws_vpc.myvpc.id
}


# list of subnets id
output "subnets" {
  description = "list of subnets id"
  value       = [for subnet in aws_subnet.mysubnets : subnet.id]
}
