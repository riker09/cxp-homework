terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}

locals {
  main_common_tags = {
    Organization    = var.org_name
    Department      = var.department_name
    Solution        = var.solution_name
    Stage           = var.solution_stage
    CostCenter      = "1234567890"
    TrainingSession = "2023-03-03"
    ManagedBy       = "Terraform"
  }
}

module "backend" {
  source         = "git::https://github.com/msgoat/iac-tf-aws-cloudtrain-modules.git//modules/terraform/remote-state"
  region_name    = var.region_name
  solution_name  = var.solution_name
  solution_stage = var.solution_stage
  solution_fqn   = var.solution_fqn
  backend_name   = var.backend_name
  common_tags    = local.main_common_tags
}