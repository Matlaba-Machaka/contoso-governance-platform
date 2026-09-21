resource "azurerm_resource_group" "gov_core" {
  name     = "rg-${var.prefix}-prod-governance"
  location = var.location
  
  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
    CostCentre  = "CC-RETAIL-001"
    Owner       = "Platform-Team"
  }
}

# Production Immutable Safeguard
resource "azurerm_management_lock" "rg_delete_lock" {
  name       = "lock-${var.prefix}-prod-immutable"
  scope      = azurerm_resource_group.gov_core.id
  lock_level = "CanNotDelete"
  notes      = "Protects critical business infrastructure from accidental deletion."
}

