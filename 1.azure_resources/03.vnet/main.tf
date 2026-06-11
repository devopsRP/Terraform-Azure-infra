terraform{
    required_providers {
      azurerm={
        source = "hashicorp/azurerm"
        version = "4.71.0"
      }
    }
}

provider "azurerm" {
  features {
    
  }
}

resource "azurerm_resource_group" "rg_block" {
  name = "my_rg"
  location = "centralindia"
  
}

# Create a Virtual Network (VNet)
# Defines the overall IP address space for your Azure network
resource "azurerm_virtual_network" "vnet_block" {

  name = "my_vnet"   # Name of the Virtual Network

  # Reference to Resource Group name (implicit dependency)
  resource_group_name = azurerm_resource_group.rg_block.name

  # Location inherited from Resource Group
  location = azurerm_resource_group.rg_block.location

  # CIDR block defining IP range for VNet (classless inter domain routing)
  address_space = ["10.0.0.0/16"]
}

# Create a Subnet inside the VNet
# Subnet is a smaller segment of the VNet
resource "azurerm_subnet" "subnet_block" {

  name = "my_subnet"   # Subnet name

  # Resource Group where VNet exists
  resource_group_name = azurerm_resource_group.rg_block.name

  # Link subnet to VNet (should use .name)
  virtual_network_name = azurerm_virtual_network.vnet_block.name

  # CIDR range for subnet (must be within VNet range)
  address_prefixes = ["10.0.1.0/24"]
}