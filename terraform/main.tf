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
    TrainingSession = "2023-02-24"
    ManagedBy       = "Terraform"
  }
}

# Read exiting data
data "aws_availability_zones" "current" {
  state = "available"
}

## VPC SECTION
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

# Create Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge({ Name = local.gw_name }, local.main_common_tags)
}

# Create public subnet
resource "aws_subnet" "public_subnets" {
  count             = length(local.subnet_names)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = local.subnet_cidr_blocks[count.index]
  availability_zone = data.aws_availability_zones.current.names[count.index]
  tags              = merge({ Name = local.subnet_names[count.index] }, local.main_common_tags)
}

# Create Security Group
resource "aws_security_group" "sg" {
  name        = "starfleet-security-group"
  description = "Starfleet Terraform Homework"
  vpc_id      = aws_vpc.vpc.id
}

# Security Group outbound/inbound rules
resource "aws_security_group_rule" "public_out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "public_in_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "public_in_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "public_in_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg.id
}

# Install Nginx on EC2
locals {
  script = <<EOT
 #!/bin/bash
 sudo yum update -y
 sudo amazon-linux-extras install nginx1 -y
 sudo amazon-linux-extras enable nginx1
 sudo systemctl start nginx
 EOT
}

# Create EC2 instance
module "ec2_instance" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "~> 3.0"
  name                        = "starbase-80"
  ami                         = "ami-034f10b7ffb207ab9"
  instance_type               = "t2.micro"
  key_name                    = "CXP AWS EC2 KeyPair"
  monitoring                  = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.public_subnets[0].id
  tags                        = merge({ Name = "starbase-80" }, local.main_common_tags)
  associate_public_ip_address = true
  user_data                   = local.script
}