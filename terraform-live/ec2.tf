# EC2 with security group and Nginx installation

module "ec2" {
  source         = "../terraform-modules//ec2"
  common_tags    = local.main_common_tags
  region_name    = var.region_name
  solution_name  = var.solution_name
  solution_stage = var.solution_stage
  solution_fqn   = var.solution_fqn
  vpc_id   = module.network.vpc_id
  subnet_id = module.network.subnet_id
  iwg = module.network.igw
}
