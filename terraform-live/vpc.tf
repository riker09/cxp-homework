## VPC and Network SECTION

module "network" {
  source         = "../terraform-modules//network"
  common_tags    = local.main_common_tags
  region_name    = var.region_name
  solution_name  = var.solution_name
  solution_stage = var.solution_stage
  solution_fqn   = var.solution_fqn
  network_name   = var.network_name
  network_cidr   = var.network_cidr
}