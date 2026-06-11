resource "azurerm_resource_group" "rg_block" {
    for_each = var.resource_group
  name = each.value.rg_name
  location = each.value.rg_location
  
}

resource "azurerm_virtual_network" "vnet_block" {
  for_each = var.vnet
  name = each.value.name
  location = azurerm_resource_group.rg_block[each.value.rg].location
  resource_group_name = azurerm_resource_group.rg_block[each.value.rg] .name
  address_space = each.value.add_space

}

resource "azurerm_subnet" "subnet_block" {
    for_each = var.subnet
  name = each.value.sub_name
  resource_group_name = azurerm_virtual_network.vnet_block[each.value.vnet].resource_group_name
  address_prefixes = each.value.add_pref
  virtual_network_name = azurerm_virtual_network.vnet_block[each.value.vnet].name
  
}

resource "azurerm_network_interface" "nic_block" {
     for_each = var.nic
  name = each.value.nic_name
  resource_group_name = azurerm_resource_group.rg_block[each.value.rg].name

  location = azurerm_resource_group.rg_block[each.value.rg].location
  
  
  ip_configuration {
    name = each.value.ipconfig_name
    subnet_id = azurerm_subnet.subnet_block[each.value.sub].id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_virtual_machine" "vm_block" {
    for_each = var.virtual_machine
  name = each.value.vm_name
  location = azurerm_virtual_network.vnet_block[each.value.vnet].location
  resource_group_name = azurerm_virtual_network.vnet_block[each.value.vnet].resource_group_name
  vm_size = each.value.vm_size
  network_interface_ids = [azurerm_network_interface.nic_block[each.value.nic].id]

  storage_os_disk {
    name = each.value.disk_name
    caching           = "ReadWrite"     
    create_option     = "FromImage"    
    managed_disk_type = "Standard_LRS" 
  }

  storage_image_reference {
     publisher = "canonical"        
    offer     = "ubuntu-24_04-lts" 
    version   = "latest"           
    sku       = "server"  
  }

  os_profile {
    admin_username = "ravidevops"
    admin_password = "Ravi@12345"
    computer_name = "my-linux-computer"
  }

  os_profile_linux_config {
    disable_password_authentication = false
    }

  
}