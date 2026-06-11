resource "azurerm_resource_group" "rg_block" {
  for_each = var.resource_group
  name = each.value.rg_name
  location = each.value.rg_location
  
}