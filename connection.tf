# =====================
# VPN Connection Azure → AWS
# =====================
variable "vpn_shared_key" {
  default = "acUCUd3QbmVx2_QWsp2KAjfOryy__3A6"
}
resource "azurerm_virtual_network_gateway_connection" "aws_connection" {
  name                = "connection-azure-aws"   # ✅ Fixed name to match manual config
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn_gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.aws.id

  shared_key = var.vpn_shared_key

  ipsec_policy {
    ike_encryption   = "AES256"
    ike_integrity    = "SHA256"
    dh_group         = "DHGroup14"
    ipsec_encryption = "AES256"
    ipsec_integrity  = "SHA256"
    pfs_group        = "PFS14"
    sa_lifetime      = 3600
    sa_datasize      = 102400000
  }
}
