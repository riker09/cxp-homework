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

## COMMON SECTION
locals {
  main_common_tags = {
    Organization    = var.org_name
    Department      = var.department_name
    solution        = var.solution_name
    Stage           = var.solution_stage
    CostCenter      = "1234567890"
    TrainingSession = "2023-03-03"
    ManagedBy       = "Terraform"
  }
}