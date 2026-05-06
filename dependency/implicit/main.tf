# Create a Resource Group
# This acts as a container for all Azure resources
resource "azurerm_resource_group" "rg" {
  name     = "my-rg"            # Resource Group name
  location = "Central India"    # Azure region
}

# Create a Storage Account
resource "azurerm_storage_account" "storage-account" {

  # Storage Account name (must be globally unique across Azure)
  name = "implicitstorageaccount"

  # Location is taken from Resource Group
  # This creates an implicit dependency on the Resource Group
  location = azurerm_resource_group.rg.location

  # Reference to Resource Group name
  # Terraform automatically understands dependency (no need for depends_on)
  resource_group_name = azurerm_resource_group.rg.name

  # Storage performance tier
  account_tier = "Standard"

  # Replication type (LRS = locally redundant storage)
  account_replication_type = "LRS"
}