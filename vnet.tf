# =====================
# Azure VNet
# =====================
resource "azurerm_virtual_network" "main" {
  name                = "vnet-azure"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = [var.azure_vnet_cidr]  # 172.10.0.0/16
}

# =====================
# Subnet default
# =====================
resource "azurerm_subnet" "default" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["172.10.0.0/24"]
}

# =====================
# Subnet-01 (VM is here)
# =====================
resource "azurerm_subnet" "subnet_01" {
  name                 = "subnet-01"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["172.10.1.0/24"]
}
