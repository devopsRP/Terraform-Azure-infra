# Creates one or more Azure Resource Groups dynamically using for_each.
resource "azurerm_resource_group" "rg_block" {
  for_each = var.resource_group
  name = each.value.rg_name
  location = each.value.rg_location
  
}

# Creates one or more Azure Virtual Networks and associates them with the specified Resource Group.
resource "azurerm_virtual_network" "vnet_block1" {
    for_each = var.vnet
  name = each.value.v_name
  resource_group_name = azurerm_resource_group.rg_blok[each.value.rg].name
  location = each.value.v_location
  address_space = each.value.add_space
  
}

# Creates VNet peerings between source and target virtual networks for private connectivity.
resource "azurerm_virtual_network_peering" "peering_block_1" {
    for_each = var.peering
  name = each.value.peer_name
  resource_group_name = azurerm_resource_group.rg_blok[each.value.rg].name
  virtual_network_name = azurerm_virtual_network.vnet_block1[each.value.source_vnet].name
  remote_virtual_network_id = azurerm_virtual_network.vnet_block1[each.value.target_vnet].id
  
}