# Creates Azure Resource Groups dynamically using values from the resource_group variable.
# Reason: A Resource Group is required to logically organize and manage Azure resources.
resource "azurerm_resource_group" "rg_block" {
  for_each = var.resource_group
  name = each.value.rg_name
  location = each.value.rg_location

}

# Creates Virtual Networks dynamically inside the specified Resource Group.
# Reason: A Virtual Network provides private network connectivity for Azure resources.
resource "azurerm_virtual_network" "vnet_block" {
 for_each = var.virtual_network
  name = each.value.v_name
  resource_group_name = azurerm_resource_group.rg_block[each.value.rg].name
  location = azurerm_resource_group.rg_block[each.value.rg].location
  address_space = each.value.add_space 
}

# Creates Subnets within the Virtual Network.
# Reason: Subnets divide a Virtual Network into smaller network segments for resource organization and security.
resource "azurerm_subnet" "subnet_block" {
  for_each = var.subnet
  name = each.value.sub_name
  virtual_network_name = azurerm_virtual_network.vnet_block[each.value.vnet].name
  resource_group_name = azurerm_virtual_network.vnet_block[each.value.vnet].resource_group_name
  address_prefixes = each.value.add_pref
}

# Creates a Standard Static Public IP Address.
# Reason: A Public IP is required to provide external connectivity to Azure services such as Bastion.
resource "azurerm_public_ip" "pip_block" {
    for_each = var.public_ip
  name = each.value.ip_name
  resource_group_name = azurerm_virtual_network.vnet_block[each.value.vnet].resource_group_name
  location = azurerm_virtual_network.vnet_block[each.value.vnet].location
  sku = "Standard"
  allocation_method = "Static"
  
}

# Creates Azure Bastion Hosts dynamically.
# Reason: Azure Bastion provides secure browser-based RDP and SSH access to virtual machines without exposing public IPs.
resource "azurerm_bastion_host" "bastion_block" {
     for_each = var.bastion_host
  name = each.value.bastion_name
  location = azurerm_virtual_network.vnet_block[each.value.vnet].location
  resource_group_name = azurerm_virtual_network.vnet_block[each.value.vnet].resource_group_name

  # Configures the Bastion Host with the required subnet and public IP.
  # Reason: Bastion requires a dedicated subnet and a public IP to establish secure VM connectivity.
  ip_configuration {
    name = each.value.config_name
    subnet_id = azurerm_subnet.subnet_block[each.value.sub].id
    public_ip_address_id = azurerm_public_ip.pip_block[each.value.ip].id
    }  
}