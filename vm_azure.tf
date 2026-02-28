# =====================
# Azure VM Network Interface
# =====================
resource "azurerm_network_interface" "vm_nic" {
  name                = "azure-vm-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet_01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_pip.id
  }
}

# =====================
# Azure Linux VM — Spot Instance
# =====================
resource "azurerm_linux_virtual_machine" "main" {
  name                = "testVMazure"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = "Standard_DC1ds_v3"
  admin_username      = "azureuser"
  zone                = "1"
  priority            = "Spot"        # ✅ Azure Spot — bypasses quota !
  eviction_policy     = "Deallocate"  # ✅ Required for Spot VMs
  max_bid_price       = -1            # ✅ Pay current spot price

  network_interface_ids = [azurerm_network_interface.vm_nic.id]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("C:/Users/HP ELITEBOOK/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}
