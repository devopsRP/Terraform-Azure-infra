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

# Creates an Azure Resource Group to contain all networking resources.
resource "azurerm_resource_group" "rg_block" {
  name = "rg_peering"
  location = "centralindia"
}

# Creates the first Virtual Network (VNet) with address space 10.0.0.0/16.
resource "azurerm_virtual_network" "vnet_block_1" {
  name = "network_1"
  location = azurerm_resource_group.rg_block.location
  resource_group_name = azurerm_resource_group.rg_block.name
  address_space = ["10.0.0.0/16"]
  
}

# Creates the second Virtual Network (VNet) with address space 10.1.0.0/16.
resource "azurerm_virtual_network" "vnet_block_2" {
  name = "network_2"
  location = azurerm_resource_group.rg_block.location
  resource_group_name = azurerm_resource_group.rg_block.name
  address_space = ["10.1.0.0/16"]
  
}

# Creates VNet peering from network_1 to network_2 for private communication.
resource "azurerm_virtual_network_peering" "peering_block_1" {
  name = "peer_1_to_2"
  resource_group_name = azurerm_resource_group.rg_block.name
  virtual_network_name = azurerm_virtual_network.vnet_block_1.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_block_2.id
}

# Creates VNet peering from network_2 to network_1 (required for bidirectional connectivity).
resource "azurerm_virtual_network_peering" "peering_block_2" {
  name = "peer_2_to_1"
  resource_group_name = azurerm_resource_group.rg_block.name
  virtual_network_name = azurerm_virtual_network.vnet_block_2.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_block_1.id
  
}