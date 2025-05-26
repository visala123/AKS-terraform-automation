terraform {
  backend "azurerm" {
    resource_group_name  = "demo-rg"
    storage_account_name = "terraformbackendalgorims"
    container_name       = "backend"
    key                  = "terraform-aks.tfstate"
  }
}
