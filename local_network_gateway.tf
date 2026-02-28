# =====================
# Local Network Gateway (represents AWS side in Azure)
# =====================
resource "azurerm_local_network_gateway" "aws" {
  name                = "lng-azure-aws"   # ✅ Fixed name to match manual config
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  # ✅ Fixed — use tunnel2_address (the UP tunnel), not tunnel1_address_space
  gateway_address = aws_vpn_connection.aws_to_azure.tunnel2_address

  address_space = [var.aws_vpc_cidr]   # 10.10.0.0/16
}
