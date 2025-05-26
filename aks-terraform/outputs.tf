output "kube_config_command" {
  value = "az aks get-credentials --resource-group ${var.resource_group_name} --name ${var.aks_cluster_name}"
}
output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}
output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "aks_subnet_id" {
  value = azurerm_subnet.aks.id
}
