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
# A logical container that holds and manages related Azure resources.
resource "azurerm_resource_group" "rg_block" {
  name = "vm_rg"
  location = "centralindia"
}

# Virtual Network (VNet):
# A private network in Azure that enables communication between Azure resources.
resource "azurerm_virtual_network" "vnet_block" {
  name = "vm_vnet"
  resource_group_name = azurerm_resource_group.rg_block.name
  location = azurerm_resource_group.rg_block.location
  address_space = ["10.0.0.0/16"]
}

# Subnet:
# A subnet is a segmented range of IP addresses within a Virtual Network.
resource "azurerm_subnet" "subnet_block" {
  name = "vm_subnet"
  resource_group_name = azurerm_resource_group.rg_block.name
  virtual_network_name = azurerm_virtual_network.vnet_block.name
  address_prefixes = ["10.0.1.0/24"]
}

# Network Interface (NIC):
# A Network Interface connects a Virtual Machine to a Virtual Network and provides IP configuration.
resource "azurerm_network_interface" "nic" {
  name = "vm_nic"
  location = azurerm_resource_group.rg_block.location
  resource_group_name = azurerm_resource_group.rg_block.name

  ip_configuration {
    name = "ip_connection"
    subnet_id = azurerm_subnet.subnet_block.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Virtual Machine (VM):
# A Virtual Machine is a compute resource that runs an operating system and applications in Azure.
resource "azurerm_virtual_machine" "vm_block" {
  name = "my_vm"                               # Name of the Virtual Machine.
  location = azurerm_resource_group.rg_block.location  # Azure region where the VM will be deployed.
  resource_group_name = azurerm_resource_group.rg_block.name # Resource Group where the VM will be created.
  vm_size = "Standard_D2s_v3"                  # Defines CPU, memory, and performance of the VM.

  network_interface_ids = [ azurerm_network_interface.nic.id ] # Attaches the NIC to the VM.

  os_profile {
    computer_name  = "hostname"       # Hostname assigned to the VM.
    admin_username = "rpdevops"       # Username used to log in to the VM.
    admin_password = "Password1234!"  # Password used for VM authentication.
  }

  storage_os_disk {
    name              = "myosdisk1"     # Name of the operating system disk.
    caching           = "ReadWrite"     # Disk caching mode.
    create_option     = "FromImage"     # Creates OS disk from the selected image.
    managed_disk_type = "Standard_LRS"  # Storage performance tier of the disk.
  }

  storage_image_reference {
    publisher = "canonical"        # Image publisher.
    offer     = "ubuntu-24_04-lts" # Operating system offer.
    version   = "latest"           # Image version.
    sku       = "server"           # Image SKU/edition.
  }

  os_profile_linux_config {
    disable_password_authentication = false # Enables password-based login.
  }
}