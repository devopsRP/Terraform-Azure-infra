# Terraform block defines backend and provider requirements
terraform {

  # Configure remote backend using Azure Storage Account
  backend "azurerm" {

    resource_group_name  = "backend-rg"        # Resource Group where storage account exists

    storage_account_name = "remotestorage88"   # Storage Account used to store Terraform state
    container_name       = "tfstate"           # Blob container inside storage account
    key                  = "terraform.tfstate" # State file name (path inside container)
  }

  # Specify required providers
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"   # Official Azure provider
      version = "4.64.0"              # Fixed version for consistency
    }
  }
}

# Configure Azure provider
provider "azurerm" {

  # Mandatory block for Azure provider
  features {
    
  }
}

# Create a Resource Group using remote backend state
resource "azurerm_resource_group" "remote-rg" {

  name     = "my_rg_remote"   # Name of the resource group
  location = "central india"  # Azure region
}