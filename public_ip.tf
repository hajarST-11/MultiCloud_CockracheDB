# =====================
# Azure VPN Gateway Public IP
# =====================
resource "azurerm_public_ip" "vpn_pip" {
  name                = "pip-vpn-azure-aws"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"   # ✅ Added — Standard SKU required for VpnGw1
}

# =====================
# Azure VM Public IP
# =====================
resource "azurerm_public_ip" "vm_pip" {
  name                = "pip-azure-vm"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"
}
