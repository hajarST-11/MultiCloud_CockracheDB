# =====================
# Azure Gateway Subnet
# =====================
resource "azurerm_subnet" "gateway" {          # ✅ name must be "gateway"
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["172.10.2.0/24"]
}
