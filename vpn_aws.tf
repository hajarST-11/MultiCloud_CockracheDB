# =====================
# Virtual Private Gateway
# =====================
resource "aws_vpn_gateway" "vgw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "vgw-aws-azure"
  }
}

# Enable route propagation
resource "aws_vpn_gateway_route_propagation" "main" {
  vpn_gateway_id = aws_vpn_gateway.vgw.id
  route_table_id = aws_route_table.main.id
}

# =====================
# Customer Gateway (Azure VPN GW IP)
# =====================
resource "aws_customer_gateway" "azure" {
  bgp_asn    = 65000
  ip_address = azurerm_public_ip.vpn_pip.ip_address  # Azure VPN Gateway public IP
  type       = "ipsec.1"

  tags = {
    Name = "cgw-azure"
  }
}

# =====================
# VPN Connection
# =====================
resource "aws_vpn_connection" "aws_to_azure" {
  vpn_gateway_id      = aws_vpn_gateway.vgw.id
  customer_gateway_id = aws_customer_gateway.azure.id
  type                = "ipsec.1"
  static_routes_only  = true
  tunnel1_preshared_key = var.vpn_shared_key   # ✅ Force same key
  tunnel2_preshared_key = var.vpn_shared_key   # ✅ Force same key

  tags = {
    Name = "vpn-aws-azure"
  }
}

# =====================
# Static Routes to Azure
# =====================
resource "aws_vpn_connection_route" "azure_subnet_default" {
  vpn_connection_id      = aws_vpn_connection.aws_to_azure.id
  destination_cidr_block = "172.10.0.0/24"
}

resource "aws_vpn_connection_route" "azure_subnet_01" {
  vpn_connection_id      = aws_vpn_connection.aws_to_azure.id
  destination_cidr_block = "172.10.1.0/24"
}
