output "resource_group_name" {
  value = azurerm_resource_group.gov_core.name
}

output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.ops_hub.workspace_id
}

output "hub_vnet_name" {
  value = azurerm_virtual_network.hub_vnet.name
}

output "spoke_vnet_name" {
  value = azurerm_virtual_network.spoke_vnet.name
}
