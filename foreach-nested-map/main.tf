resource "azurerm_resource_group" "rg_block" {
for_each = var.rg_resource
  name = each.value.name
  location = each.value.location
  
}

resource "azurerm_storage_account" "sa_block" {
    depends_on = [ azurerm_resource_group.rg_block ]
    for_each = var.storage_account
  name = each.value.name
  resource_group_name = each.value.rg_name
  location = each.value.location
  account_tier = each.value.account_tier
  account_replication_type =each.value.account_replication_type
  
}

