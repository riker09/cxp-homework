terraform {
  required_providers {
    azurerm = {
      version = "~> 3.50"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  main_common_tags = {
    Organization = "msg"
    Department   = "GBA"
    Solution     = var.solution_name
    Stage        = var.solution_stage
    ManagedBy    = "Terraform"
  }
}

locals {
  subnets = [
    {
      name          = "web"                  # subnet template name
      accessibility = "public"               # accessibility of the subnet ("public" or "private")
      role          = "web-role"             # role or responsibility of the subnet; can be used to find all subnets with matching roles
      newbits       = 1                      # additional bits to extend the prefix of this subnet
      tags          = local.main_common_tags # Tags to be attached to the subnet
    }
  #,
  #  {
  #    name          = "app"                  # subnet template name
  #    accessibility = "private"              # accessibility of the subnet ("public" or "private")
  #    role          = "app-role"             # role or responsibility of the subnet; can be used to find all subnets with matching roles
  #    newbits       = 2                      # additional bits to extend the prefix of this subnet
  #    tags          = local.main_common_tags # Tags to be attached to the subnet
  #  }
  ]
}

module "vnet" {
  source            = "git::https://github.com/msgoat/iac-tf-az-cloudtrain-modules.git//modules/network/vnet"
  region_name       = var.region_name
  region_code       = var.region_code
  solution_name     = var.solution_name
  solution_stage    = var.solution_stage
  solution_fqn      = var.solution_fqn
  common_tags       = local.main_common_tags
  resource_group_id = var.resource_group_id
  network_name      = var.network_name
  network_cidr      = var.network_cidr
  subnet_templates  = local.subnets
}