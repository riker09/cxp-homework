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

## --- COMMON SECTION
locals {
  main_common_tags = {
    Organization    = var.org_name
    Department      = var.department_name
    solution        = var.solution_name
    Stage           = var.solution_stage
    CostCenter      = "1234567890"
    TrainingSession = "2023-02-24"
    ManagedBy       = "Terraform"
  }
}


## --- VPC SECTION

# resource aws_vpc network {
#   cidr_block = "10.37.0.1/16"
# }

locals {
  vpc_name = "vpc-${var.region_name}-${var.solution_fqn}-${var.network_name}"
}

# Create a VPC resource
resource "aws_vpc" "vpc" {
  cidr_block           = var.network_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = merge({ Name = local.vpc_name }, local.main_common_tags)
}

## Read existing resources
# data aws_vpc_given {
#   id = var.my_vpc_id
# }