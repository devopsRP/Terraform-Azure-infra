#1. hardcoded no variable
resource "azurerm_resource_group" "rg_hard_coding" {
  name     = "hard-coded-rg"
  location = "central india"

}

#2. default variable
resource "azurerm_resource_group" "rg_default" {
  name     = var.rg_default_name
  location = var.rg_default_location

}


#3. cli input
resource "azurerm_resource_group" "rg_cli" {
  name     = var.rg_cli_name
  location = var.rg_cli_location

}

#4. tfvars
resource "azurerm_resource_group" "rg_tfvars" {
  name     = var.rg_tfvars_name
  location = var.rg_tfvars_location

}

