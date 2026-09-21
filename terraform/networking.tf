# Central Hub Network (For shared services/monitoring)
resource "azurerm_virtual_network" "hub_vnet" {
  name                = "vnet-${var.prefix}-prod-hub"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.gov_core.location
  resource_group_name = azurerm_resource_group.gov_core.name
  tags                = azurerm_resource_group.gov_core.tags
}

# Subnet inside the Hub Network
resource "azurerm_subnet" "hub_shared" {
  name                 = "sn-hub-shared-services"
  resource_group_name  = azurerm_resource_group.gov_core.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Workload Spoke Network (For hosting computing/VMs)
resource "azurerm_virtual_network" "spoke_vnet" {
  name                = "vnet-${var.prefix}-prod-spoke"
  address_space       = ["10.1.0.0/16"] # Prevents overlapping with Hub
  location            = azurerm_resource_group.gov_core.location
  resource_group_name = azurerm_resource_group.gov_core.name
  tags                = azurerm_resource_group.gov_core.tags
}

# Subnet inside the Spoke Network
resource "azurerm_subnet" "spoke_compute" {
  name                 = "sn-spoke-compute"
  resource_group_name  = azurerm_resource_group.gov_core.name
  virtual_network_name = azurerm_virtual_network.spoke_vnet.name
  address_prefixes     = ["10.1.1.0/24"]
}

# Peering: Hub to Spoke
resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                      = "peer-hub-to-spoke"
  resource_group_name       = azurerm_resource_group.gov_core.name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.spoke_vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

# Peering: Spoke to Hub
resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                      = "peer-spoke-to-hub"
  resource_group_name       = azurerm_resource_group.gov_core.name
  virtual_network_name      = azurerm_virtual_network.spoke_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

# Workload Spoke 2 Network 
resource "azurerm_virtual_network" "spoke_two_vnet" {
  name                = "vnet-${var.prefix}-prod-spoke2"
  address_space       = ["10.2.0.0/16"] # Shifted address space to prevent overlapping (Hub is 10.0, Spoke1 is 10.1)
  location            = azurerm_resource_group.gov_core.location
  resource_group_name = azurerm_resource_group.gov_core.name
  tags                = azurerm_resource_group.gov_core.tags
}

# Subnet inside Spoke 2 Network
resource "azurerm_subnet" "spoke_two_data" {
  name                 = "sn-spoke2-data"
  resource_group_name  = azurerm_resource_group.gov_core.name
  virtual_network_name = azurerm_virtual_network.spoke_two_vnet.name
  address_prefixes     = ["10.2.1.0/24"]
}

# Peering: Hub to Spoke 2
resource "azurerm_virtual_network_peering" "hub_to_spoke_two" {
  name                      = "peer-hub-to-spoke2"
  resource_group_name       = azurerm_resource_group.gov_core.name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.spoke_two_vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

# Peering: Spoke 2 to Hub
resource "azurerm_virtual_network_peering" "spoke_two_to_hub" {
  name                      = "peer-spoke2-to-hub"
  resource_group_name       = azurerm_resource_group.gov_core.name
  virtual_network_name      = azurerm_virtual_network.spoke_two_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}
