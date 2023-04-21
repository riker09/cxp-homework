Assignment 39a:
Setup a terraform project with remote state on Azure which creates a Resource Group for all Azure resources provisioned during this assignment.
Create VNet with several subnets,
drop a Virtual Machine as a webserver into the VNet,
create a public DNS zone for your team (parent DNS zone is cxp.azure.msgoat.eu in resource group rg-eu-west-cloudtrain-core),
create a public DNS record pointing to your VM.
The VM must be accessible via Internet using its public DNS name.
Make sure all resources are owned by your team resource group.

You may use the Terraform modules provided by iac-tf-az-cloudtrain-modules at GitHub, but you should try to write your own code first.
(all teams)