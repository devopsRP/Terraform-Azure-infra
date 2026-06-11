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


# Creates an Azure Resource Group to hold all Bastion-related resources.
resource "azurerm_resource_group" "rg_block" {
  name     = "rg_bastion"
  location = "centralindia"
}

# Creates a Virtual Network where the Bastion subnet will reside.
resource "azurerm_virtual_network" "vnet_block" {
  name                = "bastion_network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg_block.location
  resource_group_name = azurerm_resource_group.rg_block.name
}

# Creates the dedicated Azure Bastion subnet (must be named AzureBastionSubnet).
resource "azurerm_subnet" "subnet_block" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rg_block.name
  virtual_network_name = azurerm_virtual_network.vnet_block.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Creates a Standard Static Public IP for the Bastion Host.
resource "azurerm_public_ip" "ip_block" {
  name                = "bastion_ip"
  location            = azurerm_resource_group.rg_block.location
  resource_group_name = azurerm_resource_group.rg_block.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Creates an Azure Bastion Host for secure RDP/SSH access to VMs.
resource "azurerm_bastion_host" "bastion_block" {
  name                = "bastion"
  location            = azurerm_resource_group.rg_block.location
  resource_group_name = azurerm_resource_group.rg_block.name

  # Configures the Bastion Host with its subnet and public IP.
  ip_configuration {
    name                 = "ip_config"
    subnet_id            = azurerm_subnet.subnet_block.id
    public_ip_address_id = azurerm_public_ip.ip_block.id
  }
}