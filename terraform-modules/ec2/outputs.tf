output "ec2_public_ip" {
  value = aws_instance.ec2_instance.public_ip
}

output "ec2_private_ip" {
  value = aws_instance.ec2_instance.private_ip
}

output "ec2_dns_name" {
  value = aws_instance.ec2_instance.public_dns
}