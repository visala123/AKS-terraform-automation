terraform {
  backend "azurerm" {
    resource_group_name  = "demo-rg"
    storage_account_name = "terraformbackendalgorims"
    container_name       = "tfstate-aks"
    key                  = "aks.terraform.tfstate"
  }
}
