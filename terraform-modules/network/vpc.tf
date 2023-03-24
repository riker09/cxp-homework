## VPC and Network SECTION

locals {
  vpc_name           = "vpc-${var.region_name}-${var.solution_fqn}-${var.network_name}"
  subnet_names       = [for zone_name in data.aws_availability_zones.current.names : "sn-${zone_name}-${var.solution_fqn}-${var.network_name}-public"]
  subnet_cidr_blocks = cidrsubnets(var.network_cidr, 8, 8, 8)
  gw_name            = "igw-${var.region_name}-${var.solution_fqn}"
}

# Create a VPC resource
resource "aws_vpc" "vpc" {
  cidr_block           = var.network_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = merge({ Name = local.vpc_name }, local.network_common_tags)
}

# Read exiting data, the availability zones of the region
data "aws_availability_zones" "current" {
  state = "available"
}

# Create public subnet
resource "aws_subnet" "public_subnets" {
  count                = length(local.subnet_names)
  vpc_id               = aws_vpc.vpc.id
  cidr_block           = local.subnet_cidr_blocks[count.index]
  availability_zone_id = data.aws_availability_zones.current.zone_ids[count.index]
  map_public_ip_on_launch = true
  tags                 = merge({ Name = local.subnet_names[count.index] }, local.network_common_tags)
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge({ Name = local.gw_name }, local.network_common_tags)
}

# Create a route table
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge({ Name = "Route Table" }, local.network_common_tags)
}

# Add a route to the internet gateway
resource "aws_route" "internet_gateway" {
  route_table_id         = aws_route_table.route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Let the subnets use the created route table
resource "aws_route_table_association" "subnets" {
  count          = length(local.subnet_names)
  route_table_id = aws_route_table.route_table.id
  subnet_id      = aws_subnet.public_subnets[count.index].id
}

# Make the created route table the default route table
resource "aws_main_route_table_association" "main_route_table" {
  route_table_id = aws_route_table.route_table.id
  vpc_id         = aws_vpc.vpc.id
}
