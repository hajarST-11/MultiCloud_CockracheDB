# =====================
# AWS Variables
# =====================
variable "aws_vpc_cidr" {
  default = "10.10.0.0/16"
}

variable "aws_subnet_cidr" {
  default = "10.10.1.0/24"
}

variable "aws_ami" {
  description = "Ubuntu 22.04 LTS - eu-west-1"
  default     = "ami-0694d931cee176e7d"
}

variable "key_pair_name" {
  description = "Your AWS key pair name"
  default     = "my-key-pair"
}

# =====================
# Azure Variables
# =====================
variable "azure_vnet_cidr" {
  default = "172.10.0.0/16"
}

variable "azure_location" {
  default = "westeurope" # ✅ Fixed from "West Europe"
}

variable "azure_resource_group" {
  default = "rg-azure-aws"
}

# =====================
# VPN Shared Key
# =====================
variable "vpn_shared_key" {
  description = "Pre-shared key for VPN tunnel"
  default     = "Hajar123SecureKey"
  sensitive   = true
}
