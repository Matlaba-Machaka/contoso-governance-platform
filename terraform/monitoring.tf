resource "azurerm_log_analytics_workspace" "ops_hub" {
  name                = "law-${var.prefix}-shared-hub"
  location            = azurerm_resource_group.gov_core.location
  resource_group_name = azurerm_resource_group.gov_core.name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_retention_days # Updated to use your variable
}

# Microsoft Sentinel
resource "azurerm_log_analytics_solution" "sentinel" {
  solution_name         = "SecurityInsights"
  location              = azurerm_resource_group.gov_core.location
  resource_group_name   = azurerm_resource_group.gov_core.name
  workspace_resource_id = azurerm_log_analytics_workspace.ops_hub.id
  workspace_name        = azurerm_log_analytics_workspace.ops_hub.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SecurityInsights"
  }
}