# Terraform block defines core Terraform settings
terraform {

  # Specify required providers for this configuration
  required_providers {

    # Azure Resource Manager (azurerm) provider
    azurerm = {
      source  = "hashicorp/azurerm"   # Official provider from Terraform Registry
      version = "4.71.0"              # Fixed version to ensure consistent behavior
    }
  }
}

# Configure the Azure provider
provider "azurerm" {

  # Features block is mandatory for azurerm provider
  # Used to enable provider-specific settings (even if empty)
  features {

  }

}



# Create a Resource Group in Azure
# Resource Group is a container that holds all related resources

resource "azurerm_resource_group" "rg_block_name" {

  location = "central india"   # Azure region where the Resource Group will be created

  name     = "rg_name"         # Name of the Resource Group (must be unique within subscription)
}


# Create an Azure Storage Account
# Used to store data such as blobs, files, queues, and tables

resource "azurerm_storage_account" "sa_block_name" {

  # Reference to Resource Group name
  # Creates implicit dependency (RG must be created first)
  resource_group_name = azurerm_resource_group.rg_block_name.name

  # Storage Account name (must be globally unique across Azure and lowercase)
  name = "storageaccount07052026"

  # Azure region where storage account will be deployed
  location = "central india"

  # Replication type (LRS = Locally Redundant Storage)
  # Data is replicated within a single region
  account_replication_type = "LRS"

  # Performance tier (Standard = cost-effective, General purpose)
  account_tier = "Standard"
}