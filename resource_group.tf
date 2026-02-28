# =====================
# Azure Resource Group
# =====================
resource "azurerm_resource_group" "main" {
  name     = var.azure_resource_group  # "rg-azure-aws"
  location = var.azure_location        # "East US" ✅
}
