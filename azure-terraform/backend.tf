terraform {
  backend "azurerm" {
    resource_group_name  = "rg-westeu-starfleet-dev-terraform"
    storage_account_name = "stwesteustarfleetdevtf"
    container_name       = "stc-westeu-starfleet-dev-backend"
    key                  = "terraform.tfstate"
  }
}