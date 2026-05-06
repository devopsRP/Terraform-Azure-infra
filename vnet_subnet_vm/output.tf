
# Output block to display the Public IP address of the VM
# This fetches the IP from the azurerm_public_ip resource
# Useful for SSH access or external connectivity
output "public_ip" {
  value = azurerm_public_ip.public_ip.ip_address
}

# Output block to display the Private IP address of the VM
# This fetches the internal IP from the Network Interface (NIC)
# Used for internal communication within the virtual network
output "private_ip" {
  value = azurerm_network_interface.network_interface.private_ip_address
}


