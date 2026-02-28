# =====================
# AWS Outputs
# =====================
output "ec2_private_ip" {
  value       = aws_instance.main.private_ip
  description = "EC2 private IP — use this to ping from Azure"
}

output "ec2_public_ip" {
  value       = aws_instance.main.public_ip
  description = "EC2 public IP — use this to SSH"
}

output "aws_tunnel1_ip" {
  value = aws_vpn_connection.aws_to_azure.tunnel1_address
}

output "aws_tunnel2_ip" {
  value       = aws_vpn_connection.aws_to_azure.tunnel2_address
  description = "Tunnel 2 is UP — used in Local Network Gateway"
}

output "aws_tunnel2_preshared_key" {
  value     = aws_vpn_connection.aws_to_azure.tunnel2_preshared_key
  sensitive = true
}

# =====================
# Azure Outputs
# =====================
output "azure_vm_public_ip" {
  value       = azurerm_public_ip.vm_pip.ip_address
  description = "Azure VM public IP — use this to SSH"
}

output "azure_vm_private_ip" {
  value       = azurerm_network_interface.vm_nic.private_ip_address
  description = "Azure VM private IP — use this to ping from AWS"
}

output "azure_vpn_gateway_ip" {
  value       = azurerm_public_ip.vpn_pip.ip_address
  description = "Azure VPN Gateway public IP — used as Customer Gateway IP in AWS"
}

 