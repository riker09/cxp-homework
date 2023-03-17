# Script to install Nginx on the EC2
locals {
  script = <<EOT
 #!/bin/bash
    yum update -y
    amazon-linux-extras install nginx1 -y
    systemctl enable nginx
    systemctl start nginx
    cd /usr/share/nginx/html
    cp index.html index.original.html
    cat index.original.html | sed 's/Welcome to nginx!/Welcome to nginx of ${var.solution_fqn}!/g' > index.html
 EOT
}

module "ec2_public" {
  source         = "../terraform-modules//ec2"
  common_tags    = local.main_common_tags
  region_name    = var.region_name
  solution_name  = var.solution_name
  solution_stage = var.solution_stage
  solution_fqn   = var.solution_fqn
  vpc_id         = module.network_one.vpc_id
  subnet_id      = module.network_one.subnet_id
  iwg            = module.network_one.igw
  is_public      = true
  user_script    = local.script
}

module "ec2_private" {
  source         = "../terraform-modules//ec2"
  common_tags    = local.main_common_tags
  region_name    = var.region_name
  solution_name  = var.solution_name
  solution_stage = var.solution_stage
  solution_fqn   = var.solution_fqn
  vpc_id         = module.network_two.vpc_id
  subnet_id      = module.network_two.subnet_id
  iwg            = module.network_two.igw
  is_public      = false
}
