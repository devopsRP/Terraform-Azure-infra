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
# A logical container used to organize and manage Azure resources.
resource "azurerm_resource_group" "rg_block" {
  name = "subnet_rg"
  location = "centralindia"
  
}

# Virtual Network (VNet):
# A private network in Azure that enables communication between Azure resources.
resource "azurerm_virtual_network" "vnet_block" {
  name = "my_vnet"
  resource_group_name = azurerm_resource_group.rg_block.name
  location = azurerm_resource_group.rg_block.location
  address_space = ["10.0.0.0/16"]
  
}

# Subnet:
# A subnet is a segmented range of IP addresses within a Virtual Network (VNet).
# Example: VNet = 10.0.0.0/16, Subnet = 10.0.1.0/24
# Note: A subnet must always belong to a Virtual Network; it cannot exist independently.
resource "azurerm_subnet" "subnet_block" {
  name = "my_subnet"
  resource_group_name = azurerm_resource_group.rg_block.name
  virtual_network_name = azurerm_virtual_network.vnet_block.name
  address_prefixes = ["10.0.1.0/24"]
  
}