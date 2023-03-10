output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_id" {
  value = aws_subnet.public_subnets[0].id
}

output "igw" {
  value = aws_internet_gateway.igw
}