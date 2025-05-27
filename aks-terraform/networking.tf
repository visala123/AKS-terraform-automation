resource "azurerm_virtual_network" "vnet" {
  name                = "${var.resource_group_name}-vnet"
  address_space       = ["10.0.0.0/8"]
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
}

resource "azurerm_subnet" "aks" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.aks.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.240.0.0/16"]

  # delegation {
  #   name = "aks_delegation"
  #   service_delegation {
  #     name = "Microsoft.ContainerService/managedClusters"
  #     actions = [
  #       "Microsoft.Network/virtualNetworks/subnets/action",
  #     ]
  #   }
  # }
}
