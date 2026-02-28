# =====================
# Azure Route Table
# =====================
resource "azurerm_route_table" "main" {
  name                = "routage-azure"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  route {
    name                   = "route-to-aws-vpc"
    address_prefix         = var.aws_vpc_cidr   # 10.10.0.0/16
    next_hop_type          = "VirtualNetworkGateway"
  }
}

# Associate to subnet-01 (where VM lives)
resource "azurerm_subnet_route_table_association" "subnet_01" {
  subnet_id      = azurerm_subnet.subnet_01.id
  route_table_id = azurerm_route_table.main.id
}
