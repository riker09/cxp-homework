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

data "aws_availability_zones" "current" {
  state = "available"
}

## --- VPC SECTION

# resource aws_vpc network {
#   cidr_block = "10.37.0.1/16"
# }

locals {
  vpc_name           = "vpc-${var.region_name}-${var.solution_fqn}-${var.network_name}"
  gw_name            = "igw-${var.region_name}-${var.solution_fqn}"
  subnet_names       = [for zone_name in data.aws_availability_zones.current.names : "sn-${zone_name}-${var.solution_fqn}-${var.network_name}-public"]
  subnet_cidr_blocks = cidrsubnets(var.network_cidr, 8, 8, 8)
}

# Create a VPC resource
resource "aws_vpc" "vpc" {
  cidr_block           = var.network_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = merge({ Name = local.vpc_name }, local.main_common_tags)
}

## Create Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge({ Name = local.gw_name }, local.main_common_tags)
}

## Create public subnet
resource "aws_subnet" "public_subnets" {
  count             = length(local.subnet_names)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = local.subnet_cidr_blocks[count.index]
  availability_zone = data.aws_availability_zones.current.names[count.index]
  tags              = merge({ Name = local.subnet_names[count.index] }, local.main_common_tags)
}

## Create Security Group

## Create EC2 instance

## Install Webserver on EC2


## Read existing resources
# data aws_vpc_given {
#   id = var.my_vpc_id
# }