output "vnet_id" {
  description = "Unique identifier of the newly created VNet."
  value       = module.vnet.vnet_id
}

output "vnet_fqn" {
  description = "Fully qualified name of the newly created VNet."
  value       = module.vnet.vnet_fqn
}

output "subnets" {
  description = "Information about all created subnets"
  value       = module.vnet.subnets
}