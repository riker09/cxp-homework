## VPC and Network SECTION

module "network_one" {
  source         = "../terraform-modules//network"
  common_tags    = local.main_common_tags
  region_name    = var.region_name
  solution_name  = var.solution_name
  solution_stage = var.solution_stage
  solution_fqn   = var.solution_fqn
  network_name   = var.network_name
  network_cidr   = var.network_cidr
}

module "network_two" {
  source         = "../terraform-modules//network"
  common_tags    = local.main_common_tags
  region_name    = var.region_name
  solution_name  = var.solution_name
  solution_stage = var.solution_stage
  solution_fqn   = var.solution_fqn
  network_name   = var.network_two_name
  network_cidr   = var.network_two_cidr
}

resource "aws_vpc_peering_connection" "peer" {
  peer_vpc_id = module.network_one.vpc_id
  vpc_id      = module.network_two.vpc_id
  #peer_region   = var.region_name
  auto_accept = true
  depends_on  = [module.network_one, module.network_two]
}

# Add a route from first vpc to the vpc peering connection
resource "aws_route" "route_owner_to_peer" {
  route_table_id            = module.network_one.route_table.id
  destination_cidr_block    = var.network_two_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  depends_on                = [aws_vpc_peering_connection.peer, module.network_one.route_table]
}

# Add a route from second vpc to the vpc peering connection
resource "aws_route" "route_accepter_to_peer" {
  route_table_id            = module.network_two.route_table.id
  destination_cidr_block    = var.network_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  depends_on                = [aws_vpc_peering_connection.peer, module.network_two.route_table]
}