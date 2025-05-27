resource "azurerm_resource_group" "aks" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location
  sku                 = "Basic"
  admin_enabled       = false
}


resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = "${var.aks_cluster_name}-dns"

  default_node_pool {
    name                = "systempool"
    node_count          = var.node_count
    vm_size             = var.vm_size
    vnet_subnet_id      = azurerm_subnet.aks.id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    dns_service_ip    = "10.2.0.10"
    service_cidr      = "10.2.0.0/16"
    docker_bridge_cidr = "172.17.0.1/16"
  }

   monitoring {
    enabled                    = true
    workspace_resource_id      = azurerm_log_analytics_workspace.law.id
  }


  tags = {
    environment = "dev"
  }
}
resource "azurerm_role_assignment" "aks_acr" {
  principal_id                      = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name              = "AcrPull"
  scope                             = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true

  depends_on = [azurerm_kubernetes_cluster.aks]
}

