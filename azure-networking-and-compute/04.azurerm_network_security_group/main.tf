resource "azurerm_resource_group" "rg_block" {
    for_each = var.resource_group
  name = each.value.rg_name
  location = each.value.rg_location
  
}

resource "azurerm_network_security_group" "nsg_block" {
  for_each = var.nsg
  name = each.value.nsg_name
  resource_group_name = azurerm_resource_group.rg_block[each.value.rg].name
  location = azurerm_resource_group.rg_block[each.value.rg].location

 
  
}