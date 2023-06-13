terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.50"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  main_common_tags = {
    Organization    = "msg"
    Department      = "GBA"
    Solution        = var.solution_name
    Stage           = var.solution_stage
    ManagedBy       = "Terraform"
  }
}

module "backend" {
  source         = "git::https://github.com/msgoat/iac-tf-az-cloudtrain-modules.git//modules/terraform/remote-state"
  region_name    = var.region_name
  region_code    = var.region_code
  solution_name  = var.solution_name
  solution_stage = var.solution_stage
  common_tags    = local.main_common_tags
}