output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_id" {
  value = aws_subnet.public_subnets[0].id
}

output "subnet_ids" {
  value = [aws_subnet.public_subnets[0].id, aws_subnet.public_subnets[1].id]
}

output "igw" {
  value = aws_internet_gateway.igw
}

output "route_table" {
  value = aws_route_table.route_table
}