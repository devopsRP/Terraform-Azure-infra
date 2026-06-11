resource "azurerm_resource_group" "rg_block" {
    for_each = var.resource_group
  name = each.value.rg_name
  location = each.value.rg_location
  
}

resource "azurerm_virtual_network" "vnet_block" {
      for_each = var.vnet
  name = each.value.v_name
  resource_group_name = azurerm_resource_group.rg_block[each.value.rg].name
  location = azurerm_resource_group.rg_block[each.value.rg].location
  address_space = each.value.add_space
}

resource "azurerm_subnet" "subnet_block" {
    for_each = var.subnet
  name = each.value.sub_name
  resource_group_name = azurerm_virtual_network.vnet_block[each.value.network].resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_block[each.value.network].name
  address_prefixes = each.value.address_pref
  
}