resource "azurerm_storage_account" "storage" {

  name = var.sta_name

  location = var.sta_location

  resource_group_name = "module-rg"

  account_tier = "Standard"

  account_replication_type = "LRS"

}