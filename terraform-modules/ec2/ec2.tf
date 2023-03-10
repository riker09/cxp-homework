# EC2 with security group and Nginx installation

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

# Create Security Group
resource "aws_security_group" "sg" {
  name        = "starfleet-security-group"
  description = "Starfleet Terraform Homework"
  vpc_id      = var.vpc_id
}

# Security Group outbound/inbound rules

# outgoing
resource "aws_security_group_rule" "public_out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg.id
}

# incoming security rules for SSH
resource "aws_security_group_rule" "public_in_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg.id
}

# incoming security rules for HTTP
resource "aws_security_group_rule" "public_in_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg.id
}

# Create EC2 instance
resource "aws_instance" "ec2_instance" {
  ami                         = "ami-034f10b7ffb207ab9"
  instance_type               = "t2.micro"
  key_name                    = "key-us-west-1-cxp-bruesd"
  monitoring                  = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  security_groups             = [aws_security_group.sg.id]
  subnet_id                   = var.subnet_id
  tags                        = merge({ Name = "starbase-80" }, local.ec2_common_tags)
  associate_public_ip_address = true
  user_data                   = local.script
  depends_on                  = [var.iwg]
}