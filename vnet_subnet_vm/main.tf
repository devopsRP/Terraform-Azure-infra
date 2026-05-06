# Create a Resource Group to hold all resources
resource "azurerm_resource_group" "resource_group" {
  name     = "${var.name}-rg"        # Dynamic name using variable
  location = var.location           # Azure region
}

# Create a Virtual Network (VNet)
resource "azurerm_virtual_network" "vnet_block" {
  name                = "${var.name}-vnet"   # VNet name
  address_space       = ["10.0.0.0/16"]      # IP range for VNet
  location            = var.location         # Same region
  resource_group_name = azurerm_resource_group.resource_group.name
}

# Create a Subnet inside the VNet
resource "azurerm_subnet" "subnet_block" {
  name                 = "${var.name}-subnet"   # Subnet name
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet_block.name
  address_prefixes     = ["10.0.1.0/24"]        # Subnet IP range
}

# Create a Public IP address resource
resource "azurerm_public_ip" "public_ip" {
  location            = var.location
  name                = "${var.name}-pip"       # Public IP name
  resource_group_name = azurerm_resource_group.resource_group.name
  allocation_method   = "Static"                # Static public IP
}

# Create a Network Interface (NIC)
resource "azurerm_network_interface" "network_interface" {
  name                = "${var.name}-NIC"       # NIC name
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "internal"   # Config name
    subnet_id                     = azurerm_subnet.subnet_block.id
    private_ip_address_allocation = "Dynamic"    # Auto assign private IP

    # Attach Public IP to NIC (enables internet access)
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}


# Create a Network Security Group (NSG)
# NSG acts as a firewall to control inbound and outbound traffic
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.name}-nsg"        # NSG name (dynamic)
  location            = var.location             # Azure region
  resource_group_name = azurerm_resource_group.resource_group.name

  # 🔹 Rule to allow SSH access (Port 22)
  # Required to connect to VM using SSH
  security_rule {
    name                       = "Allow-SSH"     # Rule name
    priority                   = 1001            # Lower number = higher priority
    direction                  = "Inbound"       # Incoming traffic
    access                     = "Allow"         # Allow traffic
    protocol                   = "Tcp"           # TCP protocol
    source_port_range          = "*"             # Any source port
    destination_port_range     = "22"            # SSH port
    source_address_prefix      = "*"             # Allow from anywhere (not secure for prod)
    destination_address_prefix = "*"             # Any destination
  }

  # 🔹 Rule to allow HTTP traffic (Port 80)
  # Required to access web server via browser
  security_rule {
    name                       = "Allow-HTTP"    # Rule name
    priority                   = 1002            # Must be unique and higher than SSH
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"            # HTTP port
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Associate NSG with Subnet
# This applies the security rules to all resources inside the subnet
resource "azurerm_subnet_network_security_group_association" "sub_nsg_asso" {
  subnet_id                 = azurerm_subnet.subnet_block.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Create a Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "vm_block" {
  name                = "${var.name}-vm"        # VM name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location
  size                = "Standard_D2s_v3"       # VM size (CPU/RAM)

  # Login credentials
  admin_username = "rpdevops"
  admin_password = "Rpdevopsinsider@"

  # Attach NIC to VM
  network_interface_ids = [
    azurerm_network_interface.network_interface.id
  ]

  # OS Disk configuration
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # OS Image (Ubuntu)
  source_image_reference {
    publisher = "canonical"        # Image provider
    offer     = "ubuntu-24_04-lts" # OS offer
    version   = "latest"           # Latest version
    sku       = "server"           # SKU
  }

  # Allow password-based login (not recommended for production)
  disable_password_authentication = false
}