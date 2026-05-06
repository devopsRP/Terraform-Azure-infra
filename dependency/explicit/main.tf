# Create a Resource Group
# This is required before creating any Azure resources inside it
resource "azurerm_resource_group" "rg" {
  name     = "my-rg"            # Name of the Resource Group
  location = "Central India"    # Azure region
}

# Create a Storage Account
resource "azurerm_storage_account" "storage-account" {

  # Explicit dependency
  # Ensures that Resource Group is created before Storage Account
  # Useful when Terraform cannot automatically detect dependency
  depends_on = [azurerm_resource_group.rg]

  name                     = "implicitstorageaccount"   # Must be globally unique
  location                 = "Central India"           # Same region as RG
  resource_group_name      = "my-rg"                   # Target Resource Group
  account_tier             = "Standard"                # Performance tier
  account_replication_type = "LRS"                     # Locally redundant storage
}