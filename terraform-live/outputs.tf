output "ec2_dns_name" {
  value = module.ec2_public.ec2_dns_name
}

output "ec2_public_ip" {
  value = module.ec2_public.ec2_public_ip
}

output "ec2_private_ip" {
  value = module.ec2_private.ec2_private_ip
}

output "dns_record_nginx" {
  value = module.route53.dns_record_nginx
}
