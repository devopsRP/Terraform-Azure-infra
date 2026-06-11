provider "azurerm" {
    features {
      
    }
  
}

# Creates a Resource Group in Azure
resource "azurerm_resource_group" "rg_block" {
  name = "rg_pip"
  location = "centralindia"
  
}

# Creates a Public IP Address
resource "azurerm_public_ip" "pip_block" {
  # Name of the Public IP resource
  name = "puplic_ip_acess"

  # Uses the same location as the Resource Group
  location = azurerm_resource_group.rg_block.location

  # Associates the Public IP with the Resource Group
  resource_group_name = azurerm_resource_group.rg_block.name

  # Static means the IP address remains fixed and does not change
  allocation_method = "Static"
  
}