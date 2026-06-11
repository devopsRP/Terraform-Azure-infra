terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.76.0"
    }
  }
}

provider "azurerm" {
  # AzureRM provider configuration
  features {
    
  }
}

# Resource Group:
# A Resource Group is a logical container that holds and manages related Azure resources.
resource "azurerm_resource_group" "rg_block" {
  name     = "nsg_rg"
  location = "centralindia"
}

# Network Security Group (NSG):
# A Network Security Group is used to control inbound and outbound network traffic
# by defining security rules that allow or deny specific ports, protocols, and IP addresses.
resource "azurerm_network_security_group" "nsg_block" {
  name                = "my_nsg"
  resource_group_name = azurerm_resource_group.rg_block.name
  location            = azurerm_resource_group.rg_block.location
}