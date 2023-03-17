output "dns_record_nginx" {
  value = format("%s > %s", aws_route53_record.nginx.name, join(", ", aws_route53_record.nginx.records))
}