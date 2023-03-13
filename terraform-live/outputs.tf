output "ec2_dns_name" {
  value = module.ec2.ec2_dns_name
}

output "ec2_public_ip" {
  value = module.ec2.ec2_public_ip
}

output "dns_record_nginx" {
  value = format("%s > %s", aws_route53_record.nginx.name, join(", ", aws_route53_record.nginx.records))
}
