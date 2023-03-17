
module "route53" {
  source             = "../terraform-modules//route53"
  common_tags        = local.main_common_tags
  instance_public_ip = module.ec2_public.ec2_public_ip
  depends_on = [
    module.ec2_public
  ]
}
