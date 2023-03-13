data "aws_route53_zone" "cxp" {
  name = "cxp.aws.msgoat.eu."
  # private_zone = true
}

## Create our starfleet zone
resource "aws_route53_zone" "starfleet" {
  name = "starfleet.${data.aws_route53_zone.cxp.name}"
}

## Link our zone to cxp.aws.msgoat.eu "root" zone
resource "aws_route53_record" "starfleet_ns_record" {
  zone_id = data.aws_route53_zone.cxp.zone_id
  name    = "starfleet.${data.aws_route53_zone.cxp.name}"
  type    = "NS"
  ttl     = 300
  records = [
    aws_route53_zone.starfleet.name_servers[0],
    aws_route53_zone.starfleet.name_servers[1],
    aws_route53_zone.starfleet.name_servers[2],
    aws_route53_zone.starfleet.name_servers[3],
  ]
}


## Records... Lot's of records

resource "aws_route53_record" "nginx" {
  zone_id = aws_route53_zone.starfleet.zone_id
  name    = "nginx.${aws_route53_zone.starfleet.name}"
  type    = "A"
  ttl     = 300
  records = [module.ec2.ec2_public_ip]
  depends_on = [
    module.ec2
  ]
}
